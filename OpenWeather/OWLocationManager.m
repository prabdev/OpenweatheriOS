//
//  OWLocationManager.m
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import "OWLocationManager.h"

@implementation OWLocationManager

static OWLocationManager *sharedOWLocationManager = nil;

+ (OWLocationManager*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOWLocationManager = [[self alloc] init];
    });
    return sharedOWLocationManager;
}

- (id)init {
    if ((self = [super init])) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        if ([self.locationManager respondsToSelector:@selector(authorizationStatus)]) {
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
                [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please check location service permissions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [authAV show];
            }
        }
    }
    return self;
}

- (void)startLocationService {
    [self.locationManager startUpdatingLocation];
    [self performSelector:@selector(stopLocationService)
               withObject:nil
               afterDelay:60];
}

- (void)stopLocationService {
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
}

#pragma Location Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) {
        return;
    }
    
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    if (self.curDeviceLocation == nil || self.curDeviceLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        self.curDeviceLocation = newLocation;
        
        if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            [self stopLocationService];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopLocationService) object:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [authAV show];
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopLocationService];
    }
}


@end
