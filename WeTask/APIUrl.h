//
//  APIUrl.h
//  test
//
//  Created by XN on 11/23/14.
//  Copyright (c) 2014 Concordia InforTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIUrl : NSObject

- (NSURL *)fetchUserRegiserAPIUrl;
- (NSURL *)fetchUserLoginAPIUrl;


- (NSString *)paramsComponentsForUserRegisterAPIwithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password;
- (NSString *)paramsComponentsForUserLoginAPIwithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password;

@end
