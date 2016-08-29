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
    
    int _w = screen_width;
    int _fs = (_w>=768)?IPAD_FONTSIZE:IPHONE_FONTSIZE;
    
    _samplenum = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, screen_width, 30)];
    _samplenum.font = [UIFont boldSystemFontOfSize:_fs];
    _samplenum.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_samplenum];
    
    _createtdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30 + 6, screen_width, 30)];
    _createtdateLabel.font = [UIFont boldSystemFontOfSize:_fs];
    _createtdateLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_createtdateLabel];
    
    _sexAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 55 + 6*2, screen_width, 30)];
    _sexAgeLabel.font = [UIFont boldSystemFontOfSize:_fs];
    _sexAgeLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_sexAgeLabel];
    
    _machineTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80 + 6*3, screen_width, 30)];
    _machineTypeLabel.font = [UIFont boldSystemFontOfSize:_fs];
    _machineTypeLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_machineTypeLabel];
    
    _diagnoseinfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 105 + 6*4, screen_width, 30)];
    _diagnoseinfoLabel.font = [UIFont boldSystemFontOfSize:_fs];
    _diagnoseinfoLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_diagnoseinfoLabel];
    
    _remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130 + 6*5, screen_width-30, 30)];
    _remarkLabel.font = [UIFont boldSystemFontOfSize:_fs];
    _remarkLabel.textColor = DEFAULT_FONT_MID_COLOR;
    _remarkLabel.numberOfLines = 0;
    _remarkLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.contentView addSubview:_remarkLabel];
    
    _helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 155 + 6*5, screen_width-30, 30)];
    _helpLabel.font = [UIFont boldSystemFontOfSize:_fs];
    _helpLabel.textColor = DEFAULT_FONT_MID_COLOR;
    _helpLabel.numberOfLines = 0;
    _helpLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.contentView addSubview:_helpLabel];

}



-(void)setSampleData:(SampleDetailModel *)sampleData{
    
    if (IsNilOrNull(sampleData)) {
        return;
    }
    _sampleData = sampleData;
    
    (IsNilOrNull(_sampleData.machinetype))?_sampleData.machinetype = @"":0;
    
    int _fs = (screen_width>=768)?IPAD_FONTSIZE:IPHONE_FONTSIZE;
    int _remarkHeight,_helpHeight,_height;
    
    
    NSString * remarkStr = StrCat(@"病史描述：",_sampleData.remark);
    NSString * helpStr = StrCat(@"求助内容：",_sampleData.help);
    _samplenum.text = StrCat(@"标本号码：",_sampleData.samplenum);
    _createtdateLabel.text = StrCat(@"检验日期：",_sampleData.createtimeStr);
    _sexAgeLabel.text = StrCat4(@"年龄/性别：",_sampleData.patientage,@"/",_sampleData.patientsex);
    _machineTypeLabel.text = StrCat(@"仪器型号：",_sampleData.machinetype);
    _diagnoseinfoLabel.text = StrCat(@"临床诊断：",_sampleData.diagnoseinfo);
    _remarkLabel.text = remarkStr;
    _helpLabel.text = helpStr;
    
    
    _height = 130+6*5;
    
    calLabelHeight(remarkStr,_fs,screen_width-30,_remarkHeight);
    [_remarkLabel setFrame:CGRectMake(20, _height, screen_width-30, _remarkHeight+10)];
    _height = _height + _remarkHeight + 10;
    
    calLabelHeight(helpStr,_fs,screen_width-30,_helpHeight);
    [_helpLabel setFrame:CGRectMake(20, _height, screen_width-30, _helpHeight+10)];
    _height = _height + _helpHeight + 10;
    
    //生成仪器信息表
    NSMutableArray * r = _sampleData.sampleresultList;
    UILabel *t1,*t2,*t3,*t4,*t5,*t6;
    int _w = screen_width;
    int _h = 24;
    
    INIT_LABEL_T(t1,         0,  _height, _w*0.091, 20, _fs, DEFAULT_WHITE_COLOR, DEFAULT_TEXT_GRAY_COLOR, @"序号", self.contentView);
    INIT_LABEL_T_L(t2, _w*0.09,  _height, _w*0.51,  20, _fs, DEFAULT_WHITE_COLOR,DEFAULT_TEXT_GRAY_COLOR, @"检验项目", self.contentView);
    INIT_LABEL_T_L(t3, _w*0.59 , _height, _w*0.096, 20, _fs, DEFAULT_WHITE_COLOR,DEFAULT_TEXT_GRAY_COLOR, @"结果", self.contentView);
    INIT_LABEL_T_L(t4, _w*0.685, _height, _w*0.096, 20, _fs, DEFAULT_WHITE_COLOR,DEFAULT_TEXT_GRAY_COLOR, @"前1次", self.contentView);
    INIT_LABEL_T_L(t5, _w*0.78 , _height, _w*0.096, 20, _fs, DEFAULT_WHITE_COLOR,DEFAULT_TEXT_GRAY_COLOR, @"前2次", self.contentView);
    INIT_LABEL_T_L(t6, _w*0.875, _height, _w*0.125, 20, _fs, DEFAULT_WHITE_COLOR,DEFAULT_TEXT_GRAY_COLOR, @"前3次", self.contentView);
    
    for(int i=0;i<r.count;i++) {
        
        NSString *rt = NumToStr([r[i] objectForKey:@"srcresult"]);
        NSString *h1 = NumToStr([r[i] objectForKey:@"history1"]);
        NSString *h2 = NumToStr([r[i] objectForKey:@"history2"]);
        NSString *h3 = NumToStr([r[i] objectForKey:@"history3"]);
        
        INIT_LABEL(t1,          0, _height+(i+1)*_h, _w*0.09, 20, _fs, DEFAULT_TEXT_GRAY_COLOR, IntToStr(i+1), self.contentView);
        INIT_LABEL_L(t2, _w*0.094, _height+(i+1)*_h, _w*0.5 , 20, _fs, DEFAULT_TEXT_GRAY_COLOR, [r[i] objectForKey:@"itemname" ], self.contentView);
        INIT_LABEL_L(t3, _w*0.59 , _height+(i+1)*_h, _w*0.095, 20, _fs, DEFAULT_TEXT_GRAY_COLOR, rt, self.contentView);
        INIT_LABEL_L(t4, _w*0.685 ,_height+(i+1)*_h, _w*0.095, 20, _fs, DEFAULT_TEXT_GRAY_COLOR, h1, self.contentView);
        INIT_LABEL_L(t5, _w*0.78 , _height+(i+1)*_h, _w*0.095, 20, _fs, DEFAULT_TEXT_GRAY_COLOR, h2, self.contentView);
        INIT_LABEL_L(t6, _w*0.875 ,_height+(i+1)*_h, _w*0.125, 20, _fs, DEFAULT_TEXT_GRAY_COLOR, h3, self.contentView);
    }
    
    _height += 30;
    
    NSMutableArray * ip = _sampleData.ipmessageList;
    INIT_LABEL_T(t1,         0,_height+(r.count)*_h, _w*0.21, 20, _fs, DEFAULT_WHITE_COLOR, DEFAULT_TEXT_GRAY_COLOR, @"序号", self.contentView);
    INIT_LABEL_T_L(t2, _w*0.2,_height+(r.count)*_h, _w*0.8, 20, _fs, DEFAULT_WHITE_COLOR,DEFAULT_TEXT_GRAY_COLOR, @"报警信息", self.contentView);
    
    for(int i=0;i<ip.count;i++) {
        NSString *rt = NumToStr([r[i] objectForKey:@"srcresult"]);
        INIT_LABEL(t1,        0, _height+(r.count+i+1)*_h, _w*0.2, 20, _fs, DEFAULT_TEXT_GRAY_COLOR, IntToStr(i+1), self.contentView);
        INIT_LABEL_L(t2, _w*0.2, _height+(r.count+i+1)*_h, _w*0.8 , 20,_fs, DEFAULT_TEXT_GRAY_COLOR, [ip[i] objectForKey:@"ipmessage" ], self.contentView);
    }
    
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
