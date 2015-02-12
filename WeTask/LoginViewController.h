//
//  LoginViewController.h
//  WeTask
//
//  Created by XN on 11/23/14.
//  Copyright (c) 2014 Concordia InforTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic) BOOL showInformation;
- (IBAction)reg:(id)sender;
- (IBAction)login:(id)sender;

@end
