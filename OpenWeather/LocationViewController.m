//
//  LocationViewController.m
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import "LocationViewController.h"
#import "OWLocationManager.h"

@interface LocationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *locationTableview;
@property (nonatomic,strong) NSMutableArray *locationDataSource;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
    self.title = @"Select a Location";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.locationTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.locationTableview setBackgroundColor:[UIColor lightGrayColor]];
    self.locationTableview.showsVerticalScrollIndicator = NO;
    self.locationTableview.dataSource = self;
    self.locationTableview.delegate = self;
    [self.view addSubview:self.locationTableview];
    
    self.locationDataSource = [[NSMutableArray alloc] initWithObjects:@"Current Location",@"San Jose,USA",@"Sunnyvale,USA",@"Mountain View,USA",@"Fremont,USA",@"San Francisco,USA",@"Los Angeles,USA",@"New York,USA", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonPressed {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *locationCellID = @"LocationCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locationCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [self.locationDataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [OWLocationManager sharedInstance].isCurDeviceLocation = YES;
    } else {
        [OWLocationManager sharedInstance].isCurDeviceLocation = NO;
    }
    [OWLocationManager sharedInstance].curUserLocation = [self.locationDataSource objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectLocation:)]) {
        [self.delegate didSelectLocation:[self.locationDataSource objectAtIndex:indexPath.row]];
    }

    [self cancelButtonPressed];
}


@end
