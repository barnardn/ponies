//
//  NSFileManager+StackExtensions.m
//  Stack
//
//  Created by Norm Barnard on 5/18/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import "NSFileManager+MOAExtensions.h"

static NSString * const kCachesSubfolderName = @"com.Norm Barnard.ontario-cache";

@implementation NSFileManager (MOAExtensions)

#pragma mark - directory and file methods

- (NSURL *)ME_applicationSupportDirectoryURL {
    NSURL *retval = [[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask].lastObject;
    
    if (![retval checkResourceIsReachableAndReturnError:NULL]) {
        NSError *outError;
        if (![[NSFileManager defaultManager] createDirectoryAtURL:retval withIntermediateDirectories:YES attributes:nil error:&outError])
            NSLog(@"%@", outError);
    }
    
    return retval;
}

- (NSURL *)MOA_urlForResourceNamed:(NSString *)resourceName; {
    return [[self ME_applicationSupportDirectoryURL] URLByAppendingPathComponent:resourceName];
}

- (NSURL *)MOA_urlForResourceNamed:(NSString *)resourceName inFolderNamed:(NSString *)folderName; {
    NSURL *folderURL = [[[NSFileManager defaultManager] ME_applicationSupportDirectoryURL] URLByAppendingPathComponent:folderName];
    if (![folderURL checkResourceIsReachableAndReturnError:nil])
        if (![self _moa_createFolderAtURL:folderURL]) return nil;
    return [folderURL URLByAppendingPathComponent:resourceName];
}

- (NSURL *)MOA_urlForCachedResourceNamed:(NSString *)resourceName; {
    NSURL *allCachesFolder = [[self URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *cacheFolder = [allCachesFolder URLByAppendingPathComponent:kCachesSubfolderName];
    if (![cacheFolder checkResourceIsReachableAndReturnError:nil])
        if (![self _moa_createFolderAtURL:cacheFolder]) return nil;
    return [cacheFolder URLByAppendingPathComponent:resourceName];
}

- (BOOL)_moa_createFolderAtURL:(NSURL *)folderURL
{
    NSError *error;
    BOOL ok = [[NSFileManager defaultManager] createDirectoryAtURL:folderURL withIntermediateDirectories:NO attributes:nil error:&error];
    return ok;
}



@end
