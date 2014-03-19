//
//  AppDelegate.m
//  TestLSBS
//
//  Created by Perry Chaturvedi on 3/18/14.
//  Copyright (c) 2014 Perry Chaturvedi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LSLocation sharedInstance] getUserLocation];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIApplication *app = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier bgTask = 0;
    
    backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:(1*60) target:self  selector:@selector(backgroundTask) userInfo:nil repeats:YES];
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
    }];
}

-(void)backgroundTask{
    [[[LSLocation sharedInstance] locationManger]startUpdatingLocation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[[LSLocation sharedInstance]locationManger]stopUpdatingLocation];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
