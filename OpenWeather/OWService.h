//
//  OWService.h
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OWService : NSObject

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError* error);

+(OWService*)sharedInstance;
- (void)requestWeatherWithLocation:(CLLocation*)curLocation success:(successBlock)success failure:(failureBlock)fail;
- (void)requestWeatherWithCityName:(NSString*)cityName success:(successBlock)success failure:(failureBlock)fail;

@end
