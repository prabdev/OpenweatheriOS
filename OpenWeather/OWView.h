//
//  OWView.h
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWView : UIView

@property (nonatomic,strong)UILabel *cityNameLabel;
@property (nonatomic,strong)UILabel *temperatureLabel;
@property (nonatomic,strong)UILabel *maxTempLabel;
@property (nonatomic,strong)UILabel *minTempLabel;
@property (nonatomic,strong)UILabel *humidityLabel;
@property (nonatomic,strong)UILabel *pressureLabel;

@end
