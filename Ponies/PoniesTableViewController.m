//
//  PoniesTableViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <CoreData/CoreData.h>
#import "PoniesTableViewController.h"
#import "PonyDetailsViewController.h"
#import "PoniesSearchResultsTableViewCell.h"

@interface PoniesTableViewController() <UISearchBarDelegate>

@property (weak, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation PoniesTableViewController

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;
    _sessionManager = [self _sessionManager];
    _context = context;
    return self;
}

- (UITabBarItem *)tabBarItem {
    UITabBarItem *tbi = [super tabBarItem];
    tbi.image = [[UIImage imageNamed:@"tab-horse"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tbi.title = @"Find Ponies";
    return tbi;
}

- (NSString *)title {
    return @"Find Ponies";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    
    searchBar.delegate = self;
    self.searchBar = searchBar;

    

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PoniesSearchResultsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PoniesSearchResultsTableViewCell class])];
}

#pragma mark - private methods


- (AFHTTPSessionManager *)_sessionManager {
    
    NSURL *baseURL = [NSURL URLWithString:@"http://ponyfac.es"];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    return sessionManager;
}

- (void)_displaySearchResults:(NSArray *)searchResults {
    
    self.searchResults = searchResults;
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *pony = self.searchResults[indexPath.row];
    PoniesSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PoniesSearchResultsTableViewCell class])];
    NSDictionary *category = pony[@"category"];
    cell.categoryName = category[@"name"];
    cell.thumbnailURL = [NSURL URLWithString:pony[@"thumbnail"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *pony = self.searchResults[indexPath.row];
    PonyDetailsViewController *detail = [[PonyDetailsViewController alloc] initWithPony:nil ponyInfo:pony];
    detail.context = self.context;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.0f;
}


#pragma mark - searchbar delegate

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [searchBar endEditing:YES];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"ended %@", searchBar.text);
    
    NSString *searchPath = [NSString stringWithFormat:@"/api.json/tag:%@", searchBar.text];
    [self.sessionManager GET:searchPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *json = responseObject;
        [self _displaySearchResults:json[@"faces"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"boo %@", error);
    }];
    
}






@end
