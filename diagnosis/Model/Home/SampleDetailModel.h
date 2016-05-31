//
//  SampleDetailModel.h
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleDetailModel : NSObject

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
@property(nonatomic, strong) NSString *unqualifyreason;
@property(nonatomic, strong) NSString *remark;
@property(nonatomic, strong) NSString *machinetype;
@property(nonatomic) int diagnosestatus;
@property(nonatomic) int status;

@property(nonatomic, strong) NSMutableArray *graphList;
@property(nonatomic, strong) NSMutableArray *historyList;
@property(nonatomic, strong) NSMutableArray *alertList;
@property(nonatomic, strong) NSMutableArray *ipmessageList;
@property(nonatomic, strong) NSMutableArray *machineList;
@property(nonatomic, strong) NSMutableArray *microscopeList;
@property(nonatomic, strong) NSMutableArray *otherList;
@property(nonatomic, strong) NSMutableArray *sampleresultList;

// expertdiagnose: null
// mergeFinishedTime: null
// oper: 9
// testdate: 1424880000000

@end
