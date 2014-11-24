//
//  APIUrl.m
//  test
//
//  Created by XN on 11/23/14.
//  Copyright (c) 2014 Concordia InforTech. All rights reserved.
//

#import "APIUrl.h"

@implementation APIUrl

NSString *UserRegisterAPIUrl = @"http://www.concordia.comule.com/registrationAPI.php";

#pragma mark - urlForAPIs
- (NSURL *)fetchUserRegiserAPIUrl{
    return [NSURL URLWithString:UserRegisterAPIUrl];
}


#pragma mark - paramsComponentsForAPIs
- (NSString *)paramsComponentsForUserRegisterAPIwithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password{
    NSArray *paramArray = [[NSArray alloc]initWithObjects:@"phoneNumber=", phoneNumber,@"&password=", password, nil];
    NSString *param = [paramArray componentsJoinedByString:@""];
    return param;
}

@end
