//
//  AddTaskTakerTableViewController.h
//  taskExpert
//
//  Created by XN on 11/13/14.
//  Copyright (c) 2014 iakworkshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactList.h"
#import "Contact.h"

@class AddTaskTakerTableViewController;

@protocol AddTaskTakerTableViewDelegate <NSObject>
-(void)AddTaskTakerDidCancel:(AddTaskTakerTableViewController *)controller;
- (void)AddTaskTakerViewController:(AddTaskTakerTableViewController *)controller didFinishAddingTaskTaker:(Contact *)contact;
@end

@interface AddTaskTakerTableViewController : UITableViewController<UINavigationBarDelegate>

@property (nonatomic, weak) id <AddTaskTakerTableViewDelegate> delegate;

@property (nonatomic, strong) ContactList *contactList;
@property (nonatomic, strong) NSMutableArray *selectedContactList;

-(IBAction)cancel;
@end
