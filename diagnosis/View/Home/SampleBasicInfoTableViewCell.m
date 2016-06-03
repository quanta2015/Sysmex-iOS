//
//  SampleBasicInfoTableViewCell.m
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "SampleBasicInfoTableViewCell.h"

@implementation SampleBasicInfoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    _samplenum = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, screen_width, 24)];
    _samplenum.font = [UIFont boldSystemFontOfSize:14];
    _samplenum.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_samplenum];
    
    _createtdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, screen_width, 24)];
    _createtdateLabel.font = [UIFont boldSystemFontOfSize:14];
    _createtdateLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_createtdateLabel];
    
    _sexAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, screen_width, 24)];
    _sexAgeLabel.font = [UIFont boldSystemFontOfSize:14];
    _sexAgeLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_sexAgeLabel];
    
    _machineTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, screen_width, 24)];
    _machineTypeLabel.font = [UIFont boldSystemFontOfSize:14];
    _machineTypeLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_machineTypeLabel];
    
    _diagnoseinfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 105, screen_width, 24)];
    _diagnoseinfoLabel.font = [UIFont boldSystemFontOfSize:14];
    _diagnoseinfoLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_diagnoseinfoLabel];
    
    _remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, screen_width, 24)];
    _remarkLabel.font = [UIFont boldSystemFontOfSize:14];
    _remarkLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_remarkLabel];
}



-(void)setSampleData:(SampleDetailModel *)sampleData{
    
    if (IsNilOrNull(sampleData)) {
        return;
    }
    _sampleData = sampleData;
    
    (IsNilOrNull(_sampleData.machinetype))?_sampleData.machinetype = @"":0;

    _samplenum.text = StrCat(@"标本号码：",_sampleData.samplenum);
    _createtdateLabel.text = StrCat(@"检验日期：",_sampleData.createtimeStr);
    _sexAgeLabel.text = StrCat4(@"年龄/性别：",_sampleData.patientage,@"/",_sampleData.patientsex);
    _machineTypeLabel.text = StrCat(@"仪器型号：",_sampleData.machinetype);
    _diagnoseinfoLabel.text = StrCat(@"临床诊断：",_sampleData.diagnoseinfo);
    _remarkLabel.text = StrCat(@"标本备注：",_sampleData.remark);
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
