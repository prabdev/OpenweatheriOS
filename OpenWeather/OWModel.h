//
//  OWModel.h
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWModel : NSObject

@property (nonatomic,strong)NSString *cityName;
@property (nonatomic,strong)NSString *temperature;
@property (nonatomic,strong)NSString *maxTemp;
@property (nonatomic,strong)NSString *minTemp;
@property (nonatomic,strong)NSString *humidity;
@property (nonatomic,strong)NSString *pressure;

- (void)updateModelWithDictionary:(NSDictionary*)responseDict;

@end
