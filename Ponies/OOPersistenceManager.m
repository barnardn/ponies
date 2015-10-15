//
//  STKPersistenceManager.m
//  Stack
//
//  Created by Norm Barnard on 5/18/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import "NSFileManager+MOAExtensions.h"
#import "OOPersistenceManager.h"

static NSString * const kManagedObjectModelName = @"DataModel";
static NSString * const kPersistentStoreFileName = @"ponies.sqlite";
static NSString * const kSetupCoreDataDefaultsUserDefaultsKey = @"com.Norm Barnard.ontario.setupcoredatadefaultskey";

@interface OOPersistenceManager()

@property (assign, nonatomic, readwrite, getter=isInitialized) BOOL initialized;
@property (strong, nonatomic) NSManagedObjectContext *privateContext;           // for writes!
@property (strong, nonatomic, readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (copy, nonatomic) void (^completionBlock) ();

@end


@implementation OOPersistenceManager

- (instancetype)initWithCompletionBlock:(void (^)(NSError *error))completionBlock {
    NSParameterAssert(completionBlock);
    self = [super init];
    if (!self) return nil;
    
    _completionBlock = completionBlock;
    [self _setupCoreData];
    
    return self;
}

- (void)_setupCoreData {
    
    if (self.managedObjectContext) return;

    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kManagedObjectModelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    _privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _privateContext.undoManager = nil;
    _privateContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.undoManager = nil;
    _managedObjectContext.parentContext = _privateContext;
    
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @true, NSInferMappingModelAutomaticallyOption : @true};
#ifdef DEBUG
    options = @{NSMigratePersistentStoresAutomaticallyOption : @true, NSInferMappingModelAutomaticallyOption : @true, NSSQLitePragmasOption : @{ @"journal_mode" : @"DELETE" }};
#endif

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *storeURL = [[NSFileManager defaultManager] MOA_urlForResourceNamed:kPersistentStoreFileName];
        NSLog(@"%@", storeURL);
        
        NSError *error = nil;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
            [self setInitialized:NO];
            [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setInitialized:YES];
            self.completionBlock(error);
        });
        
    });
    
}

- (void)save; {
    
    if (!self.managedObjectContext.hasChanges && !self.privateContext.hasChanges) return;
    
    [self.managedObjectContext performBlockAndWait:^{
        
        NSError *error;
        __block BOOL ok = [self.managedObjectContext save:&error];
        
        [self.privateContext performBlock:^{
            NSError *blockError;
            ok = [self.privateContext save:&blockError];
            NSAssert(ok, @"%@", blockError);
        }];
        
    }];
    
    
}

@dynamic initialized;

- (BOOL)isInitialized {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSetupCoreDataDefaultsUserDefaultsKey];
}

- (void)setInitialized:(BOOL)initialized {
    [[NSUserDefaults standardUserDefaults] setBool:initialized forKey:kSetupCoreDataDefaultsUserDefaultsKey];
}


@end
