//
//  AppDelegate.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import "AppDelegate.h"
#import "OOPersistenceManager.h"
#import "RootViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) OOPersistenceManager *persistenceManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0f green:0.75f blue:0.75f alpha:1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UIActivityIndicatorView appearance] setTintColor:[UIColor colorWithRed:1.0f green:0.75f blue:0.75f alpha:1.0f]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.5f green:0.0f blue:1.0f alpha:1.0f]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithRed:1.0f green:0.5f blue:0.5f alpha:1.0f];
    self.window.rootViewController = [[RootViewController alloc] init];
    self.window.tintColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    AppDelegate __weak *weakSelf = self;
    self.persistenceManager = [[OOPersistenceManager alloc] initWithCompletionBlock:^(NSError *error) {
        AppDelegate __strong *strongSelf = weakSelf;
        RootViewController *rootViewController = (RootViewController *)strongSelf.window.rootViewController;
        [rootViewController presentMainInterfaceWithManagedObjectContext:strongSelf.persistenceManager.managedObjectContext];
    }];
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
