//
//  layoutViewController.h
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/22/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filters.h"
@interface layoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property(nonatomic) BOOL isDealsOn;
@property(nonatomic) NSInteger sortTypeIndex;
@property(nonatomic) NSString *categoryType;
@property (nonatomic, strong) Filters *filters;
- (void)updateSearch;
@end
