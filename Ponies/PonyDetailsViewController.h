//
//  PonyDetailsViewController.h
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSManagedObjectContext;
@class Pony;

@interface PonyDetailsViewController : UIViewController

- (instancetype)initWithPony:(Pony *)pony ponyInfo:(NSDictionary *)ponyInfo;

@property (strong, nonatomic) NSManagedObjectContext *context;

@end
