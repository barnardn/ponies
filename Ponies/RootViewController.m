//
//  RootViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 MaestroMobile. All rights reserved.
//

#import "RootViewController.h"
#import "PoniesTableViewController.h"
#import "FavoritesTableViewController.h"

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicatorView startAnimating];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)presentMainInterfaceWithManagedObjectContext:(NSManagedObjectContext *)context; {
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    PoniesTableViewController *poniesViewController = [[PoniesTableViewController alloc] initWithManagedObjectContext:context];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:poniesViewController];
    
    FavoritesTableViewController *faves = [[FavoritesTableViewController alloc] initWithContext:context];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:faves];
    
    tabController.viewControllers = @[navController, navController2];
    
    [self.activityIndicatorView stopAnimating];
    [self presentViewController:tabController animated:NO completion:nil];
}

@end
