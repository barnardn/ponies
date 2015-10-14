//
//  PonyDetailsViewController.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 MaestroMobile. All rights reserved.
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
    NSArray *tags = (self.pony) ? [[self.pony.tags allObjects] valueForKeyPath:@"name"] : self.ponyInfo[@"tags"];
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
    Pony *pony = [Pony ponyWithIdentity:ponyId context:self.context];
    if (!pony) {
        pony = [Pony ponyFromDictionary:self.ponyInfo context:self.context];
    }
    NSString *kategoryId = [self.ponyInfo valueForKeyPath:@"category.id"];
    Kategory *kategory = [Kategory kategoryWithIdentity:kategoryId context:self.context];
    if (!kategory) {
        NSDictionary *value = self.ponyInfo[@"category"];
        kategory = [Kategory kategoryWithDictionary:value context:self.context ];
    }
    
    NSArray *tags = self.ponyInfo[@"tags"];
    [tags enumerateObjectsUsingBlock:^(NSString *tagName, NSUInteger idx, BOOL *stop) {
        Tag *tag = [Tag tagWithName:tagName context:self.context];
        [pony addTagsObject:tag];
    }];
    
    [kategory addPoniesObject:pony];
    
    [self.context save:NULL];
    [self.context.parentContext save:NULL];

    NSData *ponyFace = UIImagePNGRepresentation(self.fullSizeImageview.image);
    NSString *filename = [NSString stringWithFormat:@"pony-face-%@.png", pony.identity];
    NSURL *outputURL = [[NSFileManager defaultManager] MOA_urlForResourceNamed:filename];
    [ponyFace writeToURL:outputURL atomically:YES];
    
    self.favoriteButton.hidden = YES;
    
}


@end
