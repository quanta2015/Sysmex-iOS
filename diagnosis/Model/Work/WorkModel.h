//
//  WorkModel.h
//  diagnosis
//
//  Created by QUANTA on 16/6/7.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *count;
@property(nonatomic) int status;

@end
