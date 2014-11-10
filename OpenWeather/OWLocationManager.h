//
//  OWLocationManager.h
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface OWLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *curDeviceLocation;
@property (nonatomic,strong) NSString *curUserLocation;
@property (nonatomic) BOOL isCurDeviceLocation;

+(OWLocationManager*)sharedInstance;
- (void)startLocationService;

@end
