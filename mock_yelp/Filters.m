//
//  Filters.m
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/21/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import "Filters.h"
@interface Filters()
@property (nonatomic, strong) NSDictionary *allCategories;
@end

@implementation Filters


- (id) init {
    self = [super init];
    self.allCategories = @{@"Active Life": @"active", @"Arts & Entertainment" : @"arts", @"Automotive" : @"auto", @"Beauty & Spas" : @"beautysvc", @"Education" : @"education", @"Event Planning & Services" : @"eventservices", @"Financial Services" : @"financialservices", @"Food" : @"food", @"Health & Medical" : @"health", @"Home Services" : @"homeservices", @"Hotels & Travel" : @"hotelstravel", @"Local Services" : @"localservices", @"Nightlife" : @"nightlife", @"Pets" : @"pets", @"Professional Services" : @"professional", @"Public Services & Government" : @"publicservicesgovt", @"Real Estate" : @"realestate", @"Restaurants" : @"restaurants", @"Shopping" : @"shopping"};
    
    self.sections = @[@{@"title" :@"Most Popular", @"rows": @[@"Offering a deal"]},
                      @{@"title" :@"Distance", @"rows": @[@"Auto", @"2 blocks", @"4 blocks", @"1 mile", @"2 miles"]},
                      @{@"title" :@"Sort by", @"rows": @[@"Best Matched", @"Distance", @"Highest Rated"]},
                      @{@"title" :@"Categories", @"rows": [self.allCategories allKeys]}
                      ];
    
    self.categories = [[NSMutableArray alloc] init];
    self.distanceIndex = 0;
    self.sortIndex = 0;
    self.parametersArray = [NSMutableDictionary dictionary];
    return self;
}

@end
