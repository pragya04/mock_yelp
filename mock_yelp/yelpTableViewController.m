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
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonClick)];
    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(onSearchButtonClick)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    self.filters = [[Filters alloc] init];
//    [self.expanded setObject:@NO forKey:@0];
//    [self.expanded setObject:@NO forKey:@1];
//    [self.expanded setObject:@NO forKey:@2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button click handlers

- (void)onDoneButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)onSearchButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if ([self.expanded[@(indexPath.section)]  isEqual: @1]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = self.filters.sections[indexPath.section][@"rows"][indexPath.row];
    }else{
        cell.textLabel.text = self.filters.sections[indexPath.section][@"rows"][self.selectedRow];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return [self.filters.sections count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"DISTANCE", @"distance");
            break;
        case 1:
            sectionName = NSLocalizedString(@"SORT BY", @"sortby");
            break;
        case 2:
            sectionName = NSLocalizedString(@"CATEGORY", @"category");
            break;
    }
    return sectionName;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.expanded[@(indexPath.section)] = @(![self.expanded[@(indexPath.section)] boolValue]);
    self.selectedRow = indexPath.row;
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    if(indexPath.section == 0 ) {
//        self.filters.distanceIndex = indexPath.row;
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    if(indexPath.section == 1 ) {
//        self.filters.sortIndex = indexPath.row;
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    
    
   //    if(self.expanded[@(indexPath.section)]) {
////        
////    } else {
////    
////    }
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    int previousCollapsedSectionIndex = self.collapsedSectionIndex;
//    self.collapsedSectionIndex = indexPath.section;
//    
//    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:previousCollapsedSectionIndex];
//    [indexSet addIndex:self.collapsedSectionIndex];
//    
//    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
