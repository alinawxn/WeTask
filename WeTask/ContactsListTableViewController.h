//
//  ContactsListTableViewController.h
//  Checklists
//
//  Created by Xiaonan Wang on 10/26/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactViewController.h"


@class ContactList;

@interface ContactsListTableViewController : UITableViewController <ContactViewControllerDelegate, UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) ContactList *contactList;
@end
