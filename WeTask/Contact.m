//
//  Contact.m
//  Checklists
//
//  Created by XN on 11/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(id)init{
    
    if((self = [super init])){
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self =[super init])){
        self.name = [aDecoder decodeObjectForKey:@"ContactName"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"PhoneNumber"];
    }
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.name forKey:@"ContactName"];
    [aCoder encodeObject:self.phoneNumber forKey:@"PhoneNumber"];
}

-(NSComparisonResult)compare:(Contact *)otherContact{
    return [self.name compare:otherContact.name];
}


@end
