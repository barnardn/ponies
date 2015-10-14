//
//  PoniesTableViewController.h
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 MaestroMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoniesTableViewController : UITableViewController

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
