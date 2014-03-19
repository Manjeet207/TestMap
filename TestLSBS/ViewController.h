//
//  ViewController.h
//  TestLSBS
//
//  Created by Perry Chaturvedi on 3/18/14.
//  Copyright (c) 2014 Perry Chaturvedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSLocation.h"

@interface ViewController : UIViewController {
    
}

@property (nonatomic, weak) IBOutlet UIButton *guestButton;
@property (nonatomic, weak) IBOutlet UIButton *studentButton;

-(IBAction)guestLogin:(id)sender;

@end
