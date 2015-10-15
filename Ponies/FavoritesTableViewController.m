//
//  FavoritesTableViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//
#import <Realm/Realm.h>

#import "NSFileManager+MOAExtensions.h"
#import "PoniesSearchResultsTableViewCell.h"
#import "FavoritesTableViewController.h"
#import "Pony.h"
#import "Kategory.h"
#import "PonyDetailsViewController.h"

@interface FavoritesTableViewController ()

@property (strong, nonatomic) RLMResults<Pony *> *ponies;

@end

@implementation FavoritesTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;
    return self;
}

- (UITabBarItem *)tabBarItem {
    UITabBarItem *tbi = [super tabBarItem];
    tbi.title = @"My Faves!";
    tbi.image = [[UIImage imageNamed:@"tab-faves"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return tbi;
}

- (NSString *)title {
    return @"My Faves!";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PoniesSearchResultsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PoniesSearchResultsTableViewCell class])];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.ponies  = [Pony allObjects];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ponies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PoniesSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PoniesSearchResultsTableViewCell class])];
    Pony *pony = self.ponies[indexPath.row];

    cell.categoryName = pony.kategory.name;
    NSString *filename = [NSString stringWithFormat:@"pony-face-%@.png", pony.identity];
    NSURL *url = [[NSFileManager defaultManager] MOA_urlForResourceNamed:filename];
    cell.thumbnailImageview.image = [UIImage imageWithContentsOfFile:[url path]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Pony *pony = self.ponies[indexPath.row];
    PonyDetailsViewController *detail = [[PonyDetailsViewController alloc] initWithPony:pony ponyInfo:nil];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.0f;
}

@end
