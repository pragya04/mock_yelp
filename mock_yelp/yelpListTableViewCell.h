//
//  yelpListTableViewCell.h
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/22/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yelpListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *businessImageView;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UILabel *businessReviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessAddress;
@property (weak, nonatomic) IBOutlet UIImageView *businessRatingsLabel;

@end
