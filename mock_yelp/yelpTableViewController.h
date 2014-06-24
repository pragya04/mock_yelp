//
//  yelpTableViewController.h
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/19/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filters.h"
#import "layoutViewController.h"


@class yelpTableViewController;

@protocol SearchDelegate <NSObject>

@end

@interface yelpTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Filters *filters;
@property (nonatomic, weak) id <SearchDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *filterQuery;

@end
