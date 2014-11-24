//
//  ContactViewController.m
//  taskExpert
//
//  Created by XN on 11/8/14.
//  Copyright (c) 2014 iakworkshop. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.contactToEdit != nil) {
        self.title = @"编辑联系人";
        
        self.nameTextField.text = self.contactToEdit.name;
        self.phoneNumberTextField.text = self.contactToEdit.phoneNumber;
        self.doneButton.enabled = YES;
    }
}

//触摸关闭键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//添加任务打开时的firstResponder
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)cancel{
    [self.delegate ContactViewControllerDidCancel:self];
}

-(IBAction)done{
    if([self.nameTextField.text isEqual:@""] || [self.phoneNumberTextField.text isEqual:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请填写全部信息" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else{
        
        if (self.contactToEdit == nil) {
            Contact *contact = [[Contact alloc]init];
            contact.name = self.nameTextField.text;
            contact.phoneNumber = self.phoneNumberTextField.text;
            [self.delegate ContactViewController:self didFinishAddingContact:contact];
        }else{
            
            self.contactToEdit.name = self.nameTextField.text;
            self.contactToEdit.phoneNumber = self.phoneNumberTextField.text;
            [self.delegate ContactViewController:self didFinishEditingContact:self.contactToEdit];
        }
    }
}

#pragma mark - add contact from contact book

- (IBAction)pushButton:(id)sender {
    self.picker = [[ABPeoplePickerNavigationController alloc] init];
    self.picker.peoplePickerDelegate = self;
    
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
    
    
    NSString *contactName = CFBridgingRelease(ABRecordCopyCompositeName(person));
    self.nameTextField.text = [NSString stringWithFormat:@"%@", contactName ? contactName : @"No Name"];
    
    
    ABMultiValueRef phoneRecord = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFStringRef phoneNumber = ABMultiValueCopyValueAtIndex(phoneRecord, 0);
    self.phoneNumberTextField.text = (__bridge_transfer NSString *)phoneNumber;
    CFRelease(phoneRecord);
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}



-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
     shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property
                             identifier:(ABMultiValueIdentifier)identifier
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    return NO; }

@end
