//
//  layoutViewController.m
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/22/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import "layoutViewController.h"
#import "yelpListTableViewCell.h"
#import "YelpClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "yelpTableViewController.h"

NSString * const kYelpConsumerKey = @"oEDPHokXg3NaIu9kPB-Glw";
NSString * const kYelpConsumerSecret = @"mINahRm9vxFQ8Iv7fOmjPK-kSjw";
NSString * const kYelpToken = @"Kb6L0k319tlZmeAeLDcGcm_Du0iaqcui";
NSString * const kYelpTokenSecret = @"KIsMp5VsBSR4v8Aj30GbyaV74HI";

@interface layoutViewController ()
@property (weak, nonatomic) IBOutlet UITableView *businessesListTableView;
@property (nonatomic, strong) yelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) yelpTableViewController *fvc;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation layoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;

    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Filter"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(showFilters:)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    self.fvc = [[yelpTableViewController alloc] init];
    
    self.client = [[yelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchBar;
    self.businessesListTableView.delegate = self;
    self.businessesListTableView.dataSource = self;
    [self.businessesListTableView registerNib:[UINib nibWithNibName:@"yelpListTableViewCell" bundle:nil] forCellReuseIdentifier:@"yelpListTableViewCell"];
    self.businessesListTableView.rowHeight = 110;
    
    [self runSearch:@{@"category_filter": @"restaurants", @"term":@"restaurants"}];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view methods

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.businesses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    yelpListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yelpListTableViewCell"];
    NSDictionary *business = self.businesses[indexPath.row];
    cell.businessName.text = business[@"name"];
    cell.businessReviewCountLabel.text = [NSString stringWithFormat:@"%@", business[@"review_count"]];;
    
    NSString *imageUrl = business[@"image_url"];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [cell.businessImageView setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"default"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.businessImageView.image = image;
    }
        failure:nil];
    
    cell.businessAddress.text = business[@"location"][@"address"][0];
    
    NSString *ratingImageUrl = business[@"rating_img_url"];
    NSURL *ratingUrl = [NSURL URLWithString:ratingImageUrl];
    [cell.businessRatingsLabel setImageWithURL:ratingUrl];
    return cell;
}

- (void) showFilters:(id)sender
{
    [self.navigationController pushViewController:self.fvc animated:YES];
}

#pragma mark - search
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSMutableDictionary *params = [@{@"category_filter": @"restaurants"} mutableCopy];
    if (![searchBar.text isEqualToString:@""]) {
        params[@"term"] = searchBar.text;
    }
    [self runSearch:params];
    [searchBar endEditing:YES];
}

- (void) runSearch:(NSDictionary *)params
{
    [self.client searchWithTerm:params
                        success:^(AFHTTPRequestOperation *operation, id response) {
                            self.businesses = response[@"businesses"];
                            [self.businessesListTableView reloadData];
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error: %@", [error description]);
                        }];
}



@end
