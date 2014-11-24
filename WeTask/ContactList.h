//
//  ContactList.h
//  Checklists
//
//  Created by XN on 11/7/14.
//

#import <Foundation/Foundation.h>

@interface ContactList : NSObject

@property(nonatomic,strong)NSMutableArray *contacts;

-(void)saveContacts;

-(NSInteger)indexOfSelectedContact;

-(void)setIndexOfSelectedContact:(NSInteger)index;

-(void)sortContacts;

@end
