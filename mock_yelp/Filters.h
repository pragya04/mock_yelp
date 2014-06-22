//
//  Filters.h
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/21/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject

@property (nonatomic, strong) NSString *searchTerm;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableDictionary *parametersArray;
@property (nonatomic, assign) NSInteger sortIndex;
@property (nonatomic, assign) NSInteger distanceIndex;
@property (nonatomic, assign) BOOL dealOnly;

@end
