//
//  RootViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 MaestroMobile. All rights reserved.
//

#import <Realm/Realm.h>

#import "RootViewController.h"
#import "PoniesTableViewController.h"
#import "FavoritesTableViewController.h"

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", [RLMRealm defaultRealm].path);
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    PoniesTableViewController *poniesViewController = [[PoniesTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:poniesViewController];
    
    FavoritesTableViewController *faves = [[FavoritesTableViewController alloc] init];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:faves];
    
    tabController.viewControllers = @[navController, navController2];

    [self addChildViewController:tabController];
    [self.view addSubview:tabController.view];
    tabController.view.frame = self.view.bounds;
    [tabController didMoveToParentViewController:self];
    
}

- (void)viewDidLayoutSubviews {
    UIViewController *child = [self.childViewControllers firstObject];
    child.view.frame = self.view.bounds;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
