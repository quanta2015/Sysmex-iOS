//
//  ConfigMenuTableViewCell.m
//  diagnosis
//
//  Created by QUANTA on 16/6/14.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "ConfigMenuTableViewCell.h"

@implementation ConfigMenuTableViewCell {
    NSMutableArray *_menuTitleArray;
    NSMutableArray *_menuIconArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    _menuTitleArray = CONFIG_MENU_TXT_ARRAY;
    _menuIconArray = CONFIG_MENU_ICON_ARRAY;
    
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
    [self.contentView addSubview:_titleImage];
    
    INIT_LABEL_L(_titleLabel,60,10,200,24,16,DEFAULT_FONT_MID_COLOR,@"", self.contentView);
}


-(void)setMenuData:(int)index{
    
    _titleLabel.text = _menuTitleArray[index];
    [_titleImage setImage:[UIImage imageNamed:_menuIconArray[index]]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
