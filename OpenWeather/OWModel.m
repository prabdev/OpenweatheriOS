//
//  OWModel.m
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import "OWModel.h"

@implementation OWModel

- (void)updateModelWithDictionary:(NSDictionary*)responseDict {
    if ([responseDict objectForKey:@"name"]) {
        self.cityName = [responseDict objectForKey:@"name"];
    }
    if ([responseDict objectForKey:@"main"]) {
        NSDictionary *mainDict = [responseDict objectForKey:@"main"];
        float temp = ([[mainDict objectForKey:@"temp"] integerValue] * 9/5) - 459.67;
        float maxtemp = ([[mainDict objectForKey:@"temp_max"] integerValue] * 9/5) - 459.67;
        float mintemp = ([[mainDict objectForKey:@"temp_min"] integerValue] * 9/5) - 459.67;
        self.temperature = [NSString stringWithFormat:@"%f",temp];
        self.maxTemp = [NSString stringWithFormat:@"%f",maxtemp];
        self.minTemp = [NSString stringWithFormat:@"%f",mintemp];
        self.humidity = [mainDict objectForKey:@"humidity"];
        self.pressure = [mainDict objectForKey:@"pressure"];
    }
}

@end
