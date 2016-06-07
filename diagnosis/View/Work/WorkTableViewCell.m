//
//  WorkTableViewCell.m
//  diagnosis
//
//  Created by QUANTA on 16/6/7.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "WorkTableViewCell.h"

@implementation WorkTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    INIT_LABEL(_titleLabel,20,0,100,60,18,DEFAULT_FONT_MID_COLOR, @"", self.contentView);
    INIT_LABEL(_countLabel,20+screen_width/2,0,50,60,18,DEFAULT_FONT_LIGHT_COLOR, @"", self.contentView);
}

-(void)setWorkData:(WorkModel *)workData{
    
    if (IsNilOrNull(workData)) {
        return;
    }
    _workData = workData;
    
    _titleLabel.text = _workData.title;
    _countLabel.text = _workData.count;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
