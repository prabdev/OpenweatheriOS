//
//  OWService.m
//  OpenWeather
//
//  Created by Prabhu Devineni on 11/9/14.
//  Copyright (c) 2014 SampleApp. All rights reserved.
//

#import "OWService.h"

#define kApiKey @"b99ddd35470e8dc1766fad2a4b46cc03" //&APPID=
#define kBaseUrl @"http://api.openweathermap.org/data/2.5/weather?"

@implementation OWService

static OWService *sharedOWService = nil;

+ (OWService*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOWService = [[self alloc] init];
    });
    return sharedOWService;
}

- (void)requestWeatherWithLocation:(CLLocation*)curLocation success:(successBlock)success failure:(failureBlock)fail {
     NSString * urlString = [NSString stringWithFormat:@"%@lat=%f&lon=%f",kBaseUrl,curLocation.coordinate.latitude,curLocation.coordinate.longitude];
    [self requestWithUrlString:urlString
                       success:^(id responseObject) {
                           success(responseObject);
                       } failure:^(NSError *error) {
                           fail(error);
                       }
    ];
}

- (void)requestWeatherWithCityName:(NSString*)cityName success:(successBlock)success failure:(failureBlock)fail {
    NSString * urlString = [NSString stringWithFormat:@"%@q=%@",kBaseUrl,cityName];
    [self requestWithUrlString:urlString
                       success:^(id responseObject) {
                           success(responseObject);
                       } failure:^(NSError *error) {
                           fail(error);
                       }
     ];
}

- (void)requestWithUrlString:(NSString*)urlString success:(successBlock)success failure:(failureBlock)fail {
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    request.timeoutInterval = 15;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"charset" forHTTPHeaderField:@"utf-8"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSDictionary * dictionary = nil;
         if(data.length>0 && !error) {
             dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             success(dictionary);
         }
         
         if(error) {
             fail(error);
         }
         
     }];
}


@end
