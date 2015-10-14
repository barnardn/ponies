//
//  PoniesSearchResultsTableViewCell.m
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 MaestroMobile. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PoniesSearchResultsTableViewCell.h"

@interface PoniesSearchResultsTableViewCell()


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;


@end

@implementation PoniesSearchResultsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setThumbnailURL:(NSURL *)thumbnailURL {
    [self.activityIndicatorView startAnimating];
    NSURLRequest *request = [NSURLRequest requestWithURL:thumbnailURL];
    
    [self.thumbnailImageview
        setImageWithURLRequest:request
        placeholderImage:nil
            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [self.activityIndicatorView stopAnimating];
                self.thumbnailImageview.image = image;
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                [self.activityIndicatorView stopAnimating];
    }];
}

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    self.categoryNameLabel.text = categoryName;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.thumbnailImageview.image = nil;
}

@end
