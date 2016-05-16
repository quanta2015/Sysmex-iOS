//
//  NetworkSingleton.h
//  afnet
//
//  Created by QUANTA on 16/5/16.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);

@interface NetSingleton : NSObject

+(NetSingleton *)sharedManager;
-(AFHTTPSessionManager *)baseHtppSession;

#pragma mark - LOGIN
-(void)loginToServer:(NSDictionary *)parameters url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
