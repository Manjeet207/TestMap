//
//  LSLocation.m
//  TestLSBS
//
//  Created by Perry Chaturvedi on 3/18/14.
//  Copyright (c) 2014 Perry Chaturvedi. All rights reserved.
//

#import "LSLocation.h"

#define DESTINATIONLATITUDE = 28.611926700000000000    //51.517918
#define DESTINATIONLONGITUDE = 77.362321200000000000   //-0.110804

@implementation LSLocation

+(id)sharedInstance {
    
    static LSLocation *location = nil;
    if(location == nil) {
        location = [[LSLocation alloc] init];
    }
    return location;
}

-(void)getUserLocation {
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
		
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[servicesDisabledAlert show];
	} else {
       
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
            NSLog(@"authorizationStatus failed");
        } else {
          
            NSLog(@"authorizationStatus authorized");
            geocoder = [[CLGeocoder alloc] init];
            self.locationManger = [[CLLocationManager alloc] init];
            self.locationManger.delegate=self;
            self.locationManger.desiredAccuracy=kCLLocationAccuracyBest;
            self.locationManger.pausesLocationUpdatesAutomatically = NO;
            self.locationManger.distanceFilter=kCLDistanceFilterNone;
            [self.locationManger startUpdatingLocation];
        }
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currentLocation = [locations lastObject];
    
    if (_currentLocation != nil) {
        _latitudeStr = [NSString stringWithFormat:@"%.8f", _currentLocation.coordinate.latitude];
        _longitudeStr = [NSString stringWithFormat:@"%.8f", _currentLocation.coordinate.longitude];
    }
    
    if([self inCampus]) {
        [self.locationManger stopUpdatingLocation];
    }
    
//    NSLog(@"Resolving the Address");
//    [geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//        if (error == nil && [placemarks count] > 0) {
//            placemark = [placemarks lastObject];
//            NSLog(@"Address = %@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                   placemark.subThoroughfare, placemark.thoroughfare,
//                                   placemark.postalCode, placemark.locality,
//                                   placemark.administrativeArea,
//                                   placemark.country]);
//        } else {
//            NSLog(@"%@", error.debugDescription);
//        }
//    }];
}

- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error
{
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Please check your network connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case kCLErrorDenied:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enable Location Service" message:@"You have to enable the Location Service to use this App. To enable, please go to Settings->Privacy->Location Services->CircleWatch (ON)" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        default:{
            
        }
            break;
    }
}

-(BOOL)inCampus {
    
    CLLocationDistance maxRadius = 30; // in meters
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude: _currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:28.613530100000000000 longitude:77.359360599999950000];
    float distInMeter = [userLocation distanceFromLocation:destinationLocation]; // which returns in meters
    
    //converting meters to mile
    float distInMile = 0.000621371192 * distInMeter;
    NSLog(@"Actual Distance in Mile : %f",distInMile);
    
    if(distInMeter <= maxRadius){
        NSLog(@"Yeah, this place is inside my circle");
        return YES;
    }
    return NO;
}

@end
