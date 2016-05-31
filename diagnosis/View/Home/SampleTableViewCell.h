//
//  SampleTableViewCell.h
//  diagnosis
//
//  Created by QUANTA on 16/5/29.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleModel.h"

@interface SampleTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel *barcodeLabel;
@property(nonatomic, strong) UILabel *companyLabel;
@property(nonatomic, strong) UILabel *createtdateLabel;
@property(nonatomic, strong) UILabel *enddateLabel;
@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) SampleModel *sampleData;



@end
