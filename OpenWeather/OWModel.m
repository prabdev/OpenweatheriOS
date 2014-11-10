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
        self.temperature = [mainDict objectForKey:@"temp"];
        self.maxTemp = [mainDict objectForKey:@"temp_max"];
        self.minTemp = [mainDict objectForKey:@"temp_min"];
        self.humidity = [NSString stringWithFormat:@"%@",[mainDict objectForKey:@"humidity"]];
        self.pressure = [NSString stringWithFormat:@"%@",[mainDict objectForKey:@"pressure"]];
    }
}

@end
