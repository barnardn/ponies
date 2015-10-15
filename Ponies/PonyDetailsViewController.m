//
//  PonyDetailsViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <CoreData/CoreData.h>
#import "NSFileManager+MOAExtensions.h"
#import "PonyDetailsViewController.h"
#import "Pony.h"
#import "Kategory.h"
#import "Tag.h"

@interface PonyDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *fullSizeImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSDictionary *ponyInfo;
@property (strong, nonatomic) Pony *pony;

@end

@implementation PonyDetailsViewController

- (instancetype)initWithPony:(Pony *)pony ponyInfo:(NSDictionary *)ponyInfo {
    self = [super init];
    if (!self) return nil;
    _ponyInfo = ponyInfo;
    _pony = pony;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = (self.pony) ? self.pony.kategory.name :  [self.ponyInfo valueForKeyPath:@"category.name"];
    NSArray *tags = (self.pony) ? [self.pony.tags  valueForKeyPath:@"name"] : self.ponyInfo[@"tags"];
    self.tagsLabel.text = [tags componentsJoinedByString:@","];

    [self.favoriteButton addTarget:self action:@selector(favoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.pony) {
        NSString *filename = [NSString stringWithFormat:@"pony-face-%@.png", self.pony.identity];
        NSURL *faceURL = [[NSFileManager defaultManager] MOA_urlForResourceNamed:filename];
        UIImage *image = [UIImage imageWithContentsOfFile:[faceURL path]];
        self.fullSizeImageview.image = image;
    } else {
        NSURL *imageURL = [NSURL URLWithString:self.ponyInfo[@"image"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
        [self.activityIndicator startAnimating];
        [self.fullSizeImageview setImageWithURLRequest:request placeholderImage:nil
         
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                   [self.activityIndicator stopAnimating];
                                                   self.fullSizeImageview.image= image;
                                                   
                                               } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                   [self.activityIndicator stopAnimating];
                                                   NSLog(@"boo: %@", error);
                                               }];
    }
    
    
    if (self.pony) {
        self.favoriteButton.hidden = YES;
    } else {
        self.favoriteButton.hidden = NO;
    }
    
}


- (void)favoriteButtonTapped:(id)sender {
    
    NSString *ponyId = self.ponyInfo[@"id"];
    Pony *pony = [[Pony alloc] init];
    pony.identity = ponyId;
    
    Kategory *kategory = [[Kategory alloc] initWithValue:@{@"identity" : [self.ponyInfo valueForKeyPath:@"category.id"],
                                                           @"name" : [self.ponyInfo valueForKeyPath:@"category.name"]} ];
    pony.kategory = kategory;
    
    NSArray *tags = self.ponyInfo[@"tags"];
    [tags enumerateObjectsUsingBlock:^(NSString *tagName, NSUInteger idx, BOOL *stop) {
        Tag *tag = [[Tag alloc] initWithValue:@{@"name" : tagName}] ;
        [pony.tags addObject:tag];
    }];

    NSData *ponyFace = UIImagePNGRepresentation(self.fullSizeImageview.image);
    NSString *filename = [NSString stringWithFormat:@"pony-face-%@.png", pony.identity];
    NSURL *outputURL = [[NSFileManager defaultManager] MOA_urlForResourceNamed:filename];
    [ponyFace writeToURL:outputURL atomically:YES];
    pony.thumbnail = filename;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:pony];
    [realm commitWriteTransaction];
    
    NSLog(@"wrote file to %@", outputURL);
    
    self.favoriteButton.hidden = YES;
    
}


@end
