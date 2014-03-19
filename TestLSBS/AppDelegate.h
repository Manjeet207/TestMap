//
//  AppDelegate.h
//  TestLSBS
//
//  Created by Perry Chaturvedi on 3/18/14.
//  Copyright (c) 2014 Perry Chaturvedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSLocation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSTimer *backgroundTimer;
}

@property (strong, nonatomic) UIWindow *window;

@end
