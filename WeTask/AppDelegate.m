//
//  ChecklistsAppDelegate.m
//  Checklists


#import "AppDelegate.h"

#import "AllListsViewController.h"
#import "ContactsListTableViewController.h"

#import "DataModel.h"
#import "ContactList.h"

@implementation AppDelegate{
    ContactList *_contactList;
    DataModel *_dataModel;
}

-(void)saveData{
    [_contactList saveContacts];
    [_dataModel saveChecklists];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    _dataModel = [[DataModel alloc]init];
    _contactList = [[ContactList alloc]init];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *navigationController = (UINavigationController *)tabBarController.viewControllers[0];
    
    UINavigationController *navigationController2 = (UINavigationController *)tabBarController.viewControllers[1];
    
    UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
    [barButtonAppearance setTintColor:[UIColor redColor]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    AllListsViewController *controller = navigationController.viewControllers[0];
    
    ContactsListTableViewController *control = navigationController2.viewControllers[0];
    
    controller.dataModel = _dataModel;
    controller.contactList = _contactList;
    
    control.contactList = _contactList;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveData];
}

@end
