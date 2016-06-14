//
//  GVUserDefaults+User.h
//  diagnosis
//
//  Created by QUANTA on 16/6/14.
//  Copyright © 2016年 sysmex. All rights reserved.
//



#import "GVUserDefaults.h"

@interface GVUserDefaults (Properties)

@property (nonatomic, weak) NSString *userName;
@property (nonatomic, weak) NSString *userId;
@property (nonatomic, weak) NSString *password;
@property (nonatomic, weak) NSString *role;
@property (nonatomic, weak) NSString *companyname;

@property (nonatomic, weak) NSString *field;
@property (nonatomic, weak) NSString *position;
@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *type;
@property (nonatomic, weak) NSString *smscode;
@property (nonatomic, weak) NSString *address;
@property (nonatomic, weak) NSString *contactperson;
@property (nonatomic, weak) NSString *phone;


@end