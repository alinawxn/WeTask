//
//  ContactDetailViewController.h
//  taskExpert
//
//  Created by XN on 11/10/14.
//  Copyright (c) 2014 iakworkshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberTextField;

@property (strong, nonatomic) Contact *contact;

@end
