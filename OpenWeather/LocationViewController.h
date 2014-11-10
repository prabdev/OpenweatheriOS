//
//  LocationViewController.h
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationDataDelegate;

@interface LocationViewController : UIViewController
@property (nonatomic,weak) id<LocationDataDelegate> delegate;

@end

@protocol LocationDataDelegate <NSObject>
@required
- (void)didSelectLocation:(NSString*)selectedLocation;
@end

