//
//  STKPersistenceManager.h
//  Stack
//
//  Created by Norm Barnard on 5/18/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface OOPersistenceManager : NSObject

@property (assign, nonatomic, readonly, getter=isInitialized) BOOL initialized;
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;       // main queue context

- (instancetype)initWithCompletionBlock:(void (^)(NSError *error))completionBlock;

- (void)save;

@end
