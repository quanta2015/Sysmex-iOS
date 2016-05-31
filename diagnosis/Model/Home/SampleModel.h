//
//  SampleModel.h
//  diagnosis
//
//  Created by QUANTA on 16/5/29.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleModel : NSObject

@property(nonatomic) int id;
@property(nonatomic, strong) NSString *barcode;
@property(nonatomic, strong) NSString *samplenum;
@property(nonatomic, strong) NSString *uploadCompany;
@property(nonatomic, strong) NSString *createtimeStr;
@property(nonatomic, strong) NSString *enddate;
@property(nonatomic, strong) NSString *diagnosestatusStr;
@property(nonatomic, strong) NSString *diagnoseinfo;
@property(nonatomic, strong) NSString *diagnosisresult;
@property(nonatomic, strong) NSString *patientage;
@property(nonatomic, strong) NSString *patientsex;
@property(nonatomic) int diagnosestatus;
@property(nonatomic) int status;






@end
