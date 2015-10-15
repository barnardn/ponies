//
//  PoniesSearchResultsTableViewCell.h
//  Ponies
//
//  Created by Norm Barnard on 8/7/15.
//  Copyright (c) 2015 Norm Barnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoniesSearchResultsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageview;
@property (nonatomic) NSString *categoryName;
@property (nonatomic) NSURL *thumbnailURL;


@end
