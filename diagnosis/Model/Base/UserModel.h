//
//  UserModel.h
//  DAZD
//
//  Created by dingjm on 15/10/15.
//  Copyright (c) 2015年 DIAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic) int role;
@property(nonatomic, strong) NSString *userid;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *position;
@property(nonatomic, strong) NSString *field;
@property(nonatomic, strong) NSString *companyname;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *smscode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *contactperson;


@end
