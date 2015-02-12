//
//  LoginViewController.m
//  WeTask
//
//  Created by XN on 11/23/14.
//  Copyright (c) 2014 Concordia InforTech. All rights reserved.
//

#import "LoginViewController.h"
#import "PersonnalInformationViewController.h"
#import "APIUrl.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    UIView* loadingView;
    UIActivityIndicatorView *activityView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showInformation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (IBAction)reg:(id)sender {
    if( self.phoneNumber.text.length == 0 || self.password.text.length < 6 || self.password.text.length > 16){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请填写信息或请填写正确信息。" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else{
        
        [self loadActivityIndicator];
        
        APIUrl *apiurl = [[APIUrl alloc]init];
        NSURL *url = [apiurl fetchUserRegiserAPIUrl];
        NSString *param = [apiurl paramsComponentsForUserRegisterAPIwithPhoneNumber:self.phoneNumber.text password:self.password.text];
        [self sendHttpRequestToUrl:url withParam:param];

    }
}

- (IBAction)login:(id)sender {
    if(!self.phoneNumber.text || self.password.text.length < 6 || self.password.text.length > 16){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请填写信息或请填写正确信息。" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else{
        
        [self loadActivityIndicator];
        
        APIUrl *apiurl = [[APIUrl alloc]init];
        NSURL *url = [apiurl fetchUserLoginAPIUrl];
        NSString *param = [apiurl paramsComponentsForUserLoginAPIwithPhoneNumber: self.phoneNumber.text password:self.password.text];
        [self sendHttpRequestLoginToUrl:url withParam:param];
        
    }
}

-(void)sendHttpRequestLoginToUrl:(NSURL *)url withParam:(NSString *)params{
    //create and config a NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [self customConfig:config];
    //create a post request with url
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod: @"POST"];
    
    //serialize params as json data
    //NSError *error = nil;
    //NSData  *data = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSError *error;
    NSData *data2 = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&error];
    if (!data2)
    {
        NSLog(@"Download Error: %@", error.localizedDescription);
        UIAlertView *alert =
        [[UIAlertView alloc]initWithTitle:@"Error"
                                  message:[NSString stringWithFormat:@"Error : %@",error.localizedDescription]
                                 delegate:self
                        cancelButtonTitle:@"Ok"
                        otherButtonTitles:nil];
        [alert show];
    }else{
        NSString* newStr = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",newStr);
    }
    
    // Parse the (binary) JSON data from the web service into an NSDictionary object
    NSDictionary *JSON =[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:&error];
    [self APILogin:JSON];
    
}

-(void)sendHttpRequestToUrl:(NSURL *)url withParam:(NSString *)params{
    //create and config a NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [self customConfig:config];
    //create a post request with url
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod: @"POST"];
    
    //serialize params as json data
    //NSError *error = nil;
    //NSData  *data = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSError *error;
    NSData *data2 = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&error];
    if (!data2)
    {
        NSLog(@"Download Error: %@", error.localizedDescription);
        UIAlertView *alert =
        [[UIAlertView alloc]initWithTitle:@"Error"
                                  message:[NSString stringWithFormat:@"Error : %@",error.localizedDescription]
                                 delegate:self
                        cancelButtonTitle:@"Ok"
                        otherButtonTitles:nil];
        [alert show];
    }else{
        NSString* newStr = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",newStr);
    }
    
    // Parse the (binary) JSON data from the web service into an NSDictionary object
    NSDictionary *JSON =[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:&error];
    [self APIRegister:JSON];

}

//configuration of session
- (void)customConfig: (NSURLSessionConfiguration *)sessionConfig{
    //allow cellular access
    sessionConfig.allowsCellularAccess = YES;
    //set all requests only accept json response
    //[sessionConfig setHTTPAdditionalHeaders:@{@"Content-Type":@"application/json"}];
    [sessionConfig setHTTPAdditionalHeaders:@{@"Accept":@"Application/json"}];
    //others
    sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    sessionConfig.timeoutIntervalForRequest = 60.0;
    sessionConfig.timeoutIntervalForResource = 60.0;
}

#pragma mark -
#pragma mark activityIndicator
- (void) loadActivityIndicator{
    CGSize screenSize = [[UIScreen mainScreen]bounds].size;
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(screenSize.width/2-40, screenSize.height/2-40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
    loadingView.layer.cornerRadius = 5;
    
    activityView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(loadingView.frame.size.width / 2.0, 35);
    [activityView startAnimating];
    [loadingView addSubview:activityView];
    
    UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
    lblLoading.text = @"Loading...";
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
    lblLoading.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:lblLoading];
    
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
}

//completionHandlerCalledByAPIRequest
- (void)APIRegister:(NSDictionary *)responseData{
    NSLog(@"ResponseData: %@",responseData);
    if([[responseData objectForKey:@"status"] isEqualToString:@"succeed"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功！" message:@"用户注册成功，请登陆。" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        [self dismissActivityIndicator];
    }else if([[responseData objectForKey:@"status"] isEqualToString:@"exist"]){
        //sample data
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"该手机号码已被注册" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles:nil];
        [alert show];
        [self dismissActivityIndicator];
    }else{
        NSLog(@"ELSE");
        [self dismissActivityIndicator];
    }
}

- (void)APILogin:(NSDictionary *)responseData{
    NSLog(@"ResponseData: %@",responseData);
    
    //登陆成功
    if([[responseData objectForKey:@"status"] isEqualToString:@"exist"]){
        [self performSegueWithIdentifier:@"ShowPersonnalInformation" sender:self.phoneNumber.text];
        [self dismissActivityIndicator];
    }else if([[responseData objectForKey:@"status"] isEqualToString:@"no"]){
        //sample data
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"登陆错误" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles:nil];
        [alert show];
        [self dismissActivityIndicator];
    }else{
        NSLog(@"ELSE");
        [self dismissActivityIndicator];
    }
}

- (void) dismissActivityIndicator{
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPersonnalInformation"]) {
        PersonnalInformationViewController *newView = segue.destinationViewController;
        newView.infor.text = sender;
    }
}

@end
