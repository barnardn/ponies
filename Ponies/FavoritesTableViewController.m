//
//  FavoritesTableViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSFileManager+MOAExtensions.h"
#import "PoniesSearchResultsTableViewCell.h"
#import "FavoritesTableViewController.h"
#import "Pony.h"
#import "Kategory.h"
#import "PonyDetailsViewController.h"

@interface FavoritesTableViewController ()

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchedResultsController *fetchController;

@end

@implementation FavoritesTableViewController

- (instancetype)initWithContext:(NSManagedObjectContext *)context; {
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;
    _context = context;
    return self;
}

- (UITabBarItem *)tabBarItem {
    UITabBarItem *tbi = [super tabBarItem];
    tbi.image = [[UIImage imageNamed:@"tab-faves"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tbi.title = @"My Faves!";
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
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Pony entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"kategory.name" ascending:YES]];
    self.fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    [self.fetchController performFetch:NULL];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.fetchController.sections count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchController.sections[section];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PoniesSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PoniesSearchResultsTableViewCell class])];
    Pony *pony = [self.fetchController objectAtIndexPath:indexPath];
    
    cell.categoryName = pony.kategory.name;
    NSString *filename = [NSString stringWithFormat:@"pony-face-%@.png", pony.identity];
    NSURL *url = [[NSFileManager defaultManager] MOA_urlForResourceNamed:filename];
    cell.thumbnailImageview.image = [UIImage imageWithContentsOfFile:[url path]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Pony *pony = [self.fetchController objectAtIndexPath:indexPath];
    PonyDetailsViewController *detail = [[PonyDetailsViewController alloc] initWithPony:pony ponyInfo:nil];
    detail.context = self.context;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.0f;
}

@end
