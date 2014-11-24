//
//  ContactList.m
//  Checklists
//
//  Created by XN on 11/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "ContactList.h"
#import "Contact.h"

@implementation ContactList

-(void)sortContacts{
    [self.contacts sortUsingSelector:@selector(compare:)];
}

-(void)registerDefaults{
    
    NSDictionary *dictionary = @{@"ContactIndex" :@-1,@"FirstTime":@YES};
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}

-(void)handleFirstTime{
    
    BOOL firstTime = [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTime"];
    
    if(firstTime){
        Contact *contact = [[Contact alloc]init];
        
        contact.name = @"我";
        contact.phoneNumber = @"12345";
        [self.contacts addObject:contact];
        [self setIndexOfSelectedContact:0];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"FirstTime"];

    }
}

#pragma mark init初始化

-(id)init{
    
    if((self =[super init])){
        
        [self loadContacts];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

#pragma mark 获取沙盒地址

-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
}

-(NSString*)dataFilePath{
    
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Contacts.plist"];
}

-(void)saveContacts{
    
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:_contacts forKey:@"Contacts"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
    
    
}

-(void)loadContacts{
    
    NSString *path = [self dataFilePath];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        self.contacts = [unarchiver decodeObjectForKey:@"Contacts"];
        
        [unarchiver finishDecoding];
    }else{
        
        self.contacts = [[NSMutableArray alloc]initWithCapacity:20];
    }
    
}


#pragma mark NSUserDefaults

-(NSInteger)indexOfSelectedContact{
    
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"ContactIndex"];
}

-(void)setIndexOfSelectedContact:(NSInteger)index{
    
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"ContactIndex"];
    
}


@end
