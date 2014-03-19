//
//  LSLocation.h
//  TestLSBS
//
//  Created by Perry Chaturvedi on 3/18/14.
//  Copyright (c) 2014 Perry Chaturvedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LSLocation : NSObject <CLLocationManagerDelegate> {
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@property (nonatomic, strong) CLLocationManager *locationManger;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) NSString *latitudeStr;
@property (nonatomic, strong) NSString *longitudeStr;

+(id)sharedInstance;

-(void)getUserLocation;
-(BOOL)inCampus;

@end
