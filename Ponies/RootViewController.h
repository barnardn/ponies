//
//  RootViewController.h
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

- (void)presentMainInterfaceWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
