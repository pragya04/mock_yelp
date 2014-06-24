//
//  yelpTableViewController.m
//  mock_yelp
//
//  Created by Pragya  Pherwani on 6/19/14.
//  Copyright (c) 2014 Pragya  Pherwani. All rights reserved.
//

#import "yelpTableViewController.h"


@interface yelpTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger collapsedSectionIndex;
@property (nonatomic, assign) BOOL distanceSectionExpanded;
@property (nonatomic, assign) BOOL sortSectionExpanded;
@property (nonatomic, assign) BOOL categorySectionExpanded;
@property (nonatomic, strong) NSMutableDictionary *expanded;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, assign) NSInteger initialCategoriesRows;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, assign) BOOL dealsFlag;
@property (nonatomic, assign) NSInteger sortType;
@property (nonatomic, assign) NSString* categoryType;


@end

@implementation yelpTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filters";
        self.expanded = [[NSMutableDictionary alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancelButtonClick)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(updateSearch)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    self.filters = [[Filters alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button click handlers

- (void)onCancelButtonClick
{
    layoutViewController *lc = [[layoutViewController alloc] initWithNibName:@"layoutViewController" bundle:nil];
    [self.navigationController pushViewController:lc animated:YES];
}
- (void)updateSearch
{
    layoutViewController *lc = [[layoutViewController alloc] initWithNibName:@"layoutViewController" bundle:nil];
    lc.isDealsOn = self.dealsFlag;
    lc.sortTypeIndex = self.sortType;
    lc.categoryType = self.categoryType;
    [self.navigationController pushViewController:lc animated:YES];
}


#pragma mark - filter table view methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.expanded[@(section)] boolValue]) {
        return [self.filters.sections[section][@"rows"] count];
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *rows = self.filters.sections[indexPath.section][@"rows"];
    cell.textLabel.text = rows[indexPath.row];
    if(indexPath.section != 0) {
        if ([self.expanded[@(indexPath.section)]  isEqual: @1]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = self.filters.sections[indexPath.section][@"rows"][indexPath.row];
        }else{
            cell.textLabel.text = self.filters.sections[indexPath.section][@"rows"][self.selectedRow];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else {
        CGRect frame = CGRectMake(250.0, 6.0, 32.0, 32.0);
        UISwitch *deals = [[UISwitch alloc] initWithFrame:frame];
        [deals addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview: deals];
    }
    return cell;
}

- (void)switchValueChanged:(UISwitch *)theSwitch {
    self.dealsFlag = theSwitch.on;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return [self.filters.sections count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    sectionName = self.filters.sections[section][@"title"];
    return sectionName;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.expanded[@(indexPath.section)] = @(![self.expanded[@(indexPath.section)] boolValue]);
    self.selectedRow = indexPath.row;
    if(indexPath.section == 2) {
        self.sortType = self.selectedRow;
    }
    NSArray *rows = self.filters.sections[indexPath.section][@"rows"];
    if(indexPath.section == 3) {
        self.categoryType = rows[indexPath.row];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

@end
