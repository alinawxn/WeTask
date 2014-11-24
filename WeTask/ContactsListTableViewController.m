//
//  ContactsListTableViewController.m
//  Checklists
//
//  Created by Xiaonan Wang on 10/26/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "ContactsListTableViewController.h"
#import "ContactDetailViewController.h"
#import "ContactList.h"
#import "Contact.h"


@interface ContactsListTableViewController ()

@end

@implementation ContactsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contactList sortContacts];
    [self.tableView reloadData];
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark view

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.contactList sortContacts];
    [self.tableView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.contactList sortContacts];
    [self.tableView reloadData];
    
    self.navigationController.delegate = self;
    
    NSInteger index = [self.contactList indexOfSelectedContact];
    
    if(index >=0 && index <[self.contactList.contacts count]){
        
        Contact *contact = self.contactList.contacts[index];
        
        [self performSegueWithIdentifier:@"ShowContact" sender:contact];
    }
}

#pragma mark - UINavigationController delegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(viewController ==self){
        
        [self.contactList setIndexOfSelectedContact:-1];
        [self.contactList sortContacts];
        [self.tableView reloadData];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactList.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Contact *contact = self.contactList.contacts[indexPath.row];
    
    cell.textLabel.text = contact.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.contactList setIndexOfSelectedContact:indexPath.row];
    Contact *contact = self.contactList.contacts[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowContact" sender:contact];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.contactList.contacts removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowContact"]) {
        ContactDetailViewController *controller = segue.destinationViewController;
        controller.contact = sender;
        //ContactViewController *controller = segue.destinationViewController;
        //controller.checklist = sender;
    } else if ([segue.identifier isEqualToString:@"AddContact"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ContactViewController *controller = (ContactViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.contactToEdit = nil;
    }
}

//taskdetail 界面 cancel事件代理
- (void)ContactViewControllerDidCancel:(ContactViewController *)controller{
    [self.contactList sortContacts];
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ContactViewController:(ContactViewController *)controller didFinishAddingContact:(Contact *)contact{
    [self.contactList.contacts addObject:contact];
    [self.contactList saveContacts];
    [self.contactList sortContacts];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ContactViewController:(ContactViewController *)controller didFinishEditingContact:(Contact *)contact
{
    [self.contactList sortContacts];
    [self.tableView reloadData];
    [self.contactList saveContacts];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactNavigationController"];
    
    ContactViewController *controller = (ContactViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    Contact *contact = self.contactList.contacts[indexPath.row];
    controller.contactToEdit = contact;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
