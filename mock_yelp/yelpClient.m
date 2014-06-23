//
//  yelpClient.m
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/22/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import "yelpClient.h"

@implementation yelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        NSLog(@"%@",params);
    NSDictionary *parameters = @{@"term": params[@"term"], @"location" : @"San Francisco", @"category_filter": params[@"category_filter"], @"deals_filter": params[@"deals_filter"], @"sort": params[@"sort"]};
    NSLog(@"%@",parameters);

    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

@end