//
//  SampleBasicInfoTableViewCell.h
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleDetailModel.h"

@interface SampleBasicInfoTableViewCell : UITableViewCell


@property(nonatomic, strong) SampleDetailModel *sampleData;
@property(nonatomic, strong) UILabel *samplenum;
@property(nonatomic, strong) UILabel *createtdateLabel;
@property(nonatomic, strong) UILabel *sexAgeLabel;
@property(nonatomic, strong) UILabel *machineTypeLabel;
@property(nonatomic, strong) UILabel *diagnoseinfoLabel;
@property(nonatomic, strong) UILabel *remarkLabel;





@end
