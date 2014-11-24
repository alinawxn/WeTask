//
//  ContactDetailViewController.m
//  taskExpert
//
//  Created by XN on 11/10/14.
//  Copyright (c) 2014 iakworkshop. All rights reserved.
//

#import "ContactDetailViewController.h"

@interface ContactDetailViewController ()

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = self.contact.name;
    // Do any additional setup after loading the view.
    self.nameTextField.text = [NSString stringWithFormat:@"姓名：%@", self.contact.name];
    
    self.phoneNumberTextField.text = [NSString stringWithFormat:@"电话：%@", self.contact.phoneNumber];
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

@end
