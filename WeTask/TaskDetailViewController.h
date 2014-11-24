//
//  TaskDetailViewController.h
//  Checklists
//  添加任务/编辑任务 view controller
//  Created by XN on 11/8/14.
//  Copyright (c) 2014 iakworkshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checklist.h"
#import "ChecklistItem.h"
#import "CKCalendarView.h"
#import "AddTaskTakerTableViewController.h"

@class TaskDetailViewController;

@protocol TaskDetailViewControllerDelegate <NSObject>
- (void)TaskDetailViewControllerDidCancel:(TaskDetailViewController *)controller;
- (void)TaskDetailViewController:(TaskDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;
- (void)TaskDetailViewController:(TaskDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist;
@end

@interface TaskDetailViewController : UIViewController<AddTaskTakerTableViewDelegate,UITextFieldDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) id <TaskDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Checklist *checklistToEdit;

//navigation bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;

//输入框
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskTaker;//执行人
@property (weak, nonatomic) IBOutlet UITextField *dateField;//日历
@property (weak, nonatomic) IBOutlet UITextField *hour;
@property (weak, nonatomic) IBOutlet UITextField *minute;
@property (weak, nonatomic) IBOutlet UITextView *taskDescription;
@property (weak, nonatomic) IBOutlet UIButton *addContactButton;


- (IBAction)cancel;
- (IBAction)done;
- (IBAction)setDate:(id)sender;
- (IBAction)addContact:(id)sender;
- (IBAction)showButton:(id)sender;
- (IBAction)hideButton:(id)sender;




@end
