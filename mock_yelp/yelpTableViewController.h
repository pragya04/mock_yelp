//
//  yelpTableViewController.h
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/19/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filters.h"

@interface yelpTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Filters *filters;
@end
