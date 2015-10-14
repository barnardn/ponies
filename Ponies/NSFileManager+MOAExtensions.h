//
//  NSFileManager+StackExtensions.h
//  Stack
//
//  Created by Norm Barnard on 5/18/15.
//  Copyright (c) 2015 MaestroMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (MOAExtensions)

- (NSURL *)MOA_urlForResourceNamed:(NSString *)resourceName;
- (NSURL *)MOA_urlForResourceNamed:(NSString *)resourceName inFolderNamed:(NSString *)folderName;
- (NSURL *)MOA_urlForCachedResourceNamed:(NSString *)resourceName;

@end
