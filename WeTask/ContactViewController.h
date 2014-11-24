//
//  ContactViewController.h
//  taskExpert
//
//  Created by XN on 11/8/14.
//  Copyright (c) 2014 iakworkshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Contact.h"


@class ContactViewController;

@protocol ContactViewControllerDelegate <NSObject>
- (void)ContactViewControllerDidCancel:(ContactViewController *)controller;
- (void)ContactViewController:(ContactViewController *)controller didFinishAddingContact:(Contact *)contact;
- (void)ContactViewController:(ContactViewController *)controller didFinishEditingContact:(Contact *)contact;
@end

@interface ContactViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id <ContactViewControllerDelegate> delegate;
@property (nonatomic, strong) Contact *contactToEdit;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) ABPeoplePickerNavigationController *picker;

-(IBAction)cancel;
-(IBAction)done;

- (IBAction)pushButton:(id)sender;


@end
