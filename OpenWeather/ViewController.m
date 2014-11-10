//
//  ViewController.m
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/7/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"
#import "OWLocationManager.h"
#import "OWService.h"
#import "OWModel.h"
#import "OWView.h"

@interface ViewController () <LocationDataDelegate>

@property (nonatomic,strong)OWModel *curDataModel;
@property (nonatomic,strong)OWView *curWeatherView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"OpenWeather";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    locationButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 80, 160, 80);
    [locationButton setTitle:@"Select a location" forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(locationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationButton];
    
    [[OWLocationManager sharedInstance] startLocationService];
    
    self.curWeatherView = [[OWView alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width, self.view.frame.size.height-200)];
    [self.view addSubview:self.curWeatherView];
}

- (void)updateWeatherView {
    self.curWeatherView.cityNameLabel.text = @"Place Name:";
    self.curWeatherView.temperatureLabel.text = @"Temperature:";
    self.curWeatherView.maxTempLabel.text = @"Max Temp:";
    self.curWeatherView.minTempLabel.text = @"Min Temp:";
    self.curWeatherView.humidityLabel.text = @"Humidity:";
    self.curWeatherView.pressureLabel.text = @"Pressure:";
    
    self.curWeatherView.cityNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.cityNameLabel.text,self.curDataModel.cityName];
    self.curWeatherView.temperatureLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.temperatureLabel.text,self.curDataModel.temperature];
    self.curWeatherView.maxTempLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.maxTempLabel.text,self.curDataModel.maxTemp];
    self.curWeatherView.minTempLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.minTempLabel.text,self.curDataModel.minTemp];
    self.curWeatherView.humidityLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.humidityLabel.text,self.curDataModel.humidity];
    self.curWeatherView.pressureLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.pressureLabel.text,self.curDataModel.pressure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationButtonPressed {
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:locationVC];
    [navController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

#pragma LocationDataDelegate
- (void)didSelectLocation:(NSString*)selectedLocation {
    if ([OWLocationManager sharedInstance].isCurDeviceLocation) {
        [[OWService sharedInstance] requestWeatherWithLocation:[OWLocationManager sharedInstance].curDeviceLocation
                                                       success:^(id responseObject){
                                                           NSLog(@"Response Object %@",responseObject);
                                                           if (!self.curDataModel) {
                                                               self.curDataModel = [[OWModel alloc] init];
                                                           }
                                                           [self.curDataModel updateModelWithDictionary:(NSDictionary*)responseObject];
                                                           [self performSelectorOnMainThread:@selector(updateWeatherView) withObject:nil waitUntilDone:NO];
            
                                                       } failure:^(NSError *error) {
                                                           NSLog(@"Response Error %@",error);
                                                           UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please, try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                           [authAV show];
        }];
    } else {
        [[OWService sharedInstance] requestWeatherWithCityName:[OWLocationManager sharedInstance].curUserLocation
                                                       success:^(id responseObject){
                                                           NSLog(@"Response Object %@",responseObject);
                                                           if (!self.curDataModel) {
                                                               self.curDataModel = [[OWModel alloc] init];
                                                           }
                                                           [self.curDataModel updateModelWithDictionary:(NSDictionary*)responseObject];
                                                           [self performSelectorOnMainThread:@selector(updateWeatherView) withObject:nil waitUntilDone:NO];
            
                                                       } failure:^(NSError *error) {
                                                           NSLog(@"Response Error %@",error);
                                                           UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please, try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                           [authAV show];
        }];
    }
}

@end
