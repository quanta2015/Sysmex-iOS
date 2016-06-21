//
//  ConfigInfoTableViewCell.m
//  diagnosis
//
//  Created by QUANTA on 16/6/14.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "ConfigInfoTableViewCell.h"
#import "GVUserDefaults.h"
#import "GVUserDefaults+User.h"

@implementation ConfigInfoTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
    }
    return self;

}

-(void)initViews{
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 64, 64)];
    [userImage setImage:[UIImage imageNamed:@"icon_user"]];
    userImage.backgroundColor = DEFAULT_WHITE_COLOR;
    userImage.layer.cornerRadius = 4;
    userImage.layer.borderWidth = 1;
    userImage.layer.borderColor = DEFAULT_LINE_GRAY_COLOR.CGColor;
    [self.contentView addSubview:userImage];
    
    UILabel * usernameLable, *ptLabel, *typeLabel, *fieldLabel, *companyLabel;
    NSString *username = [GVUserDefaults standardUserDefaults].userName;
    NSString *pt = StrCat4(@"职位职称：",[GVUserDefaults standardUserDefaults].position, @"/", [GVUserDefaults standardUserDefaults].title);
    NSString *field = StrCat(@"研究领域：",[GVUserDefaults standardUserDefaults].field);
    NSString *company = StrCat(@"单位地址：",[GVUserDefaults standardUserDefaults].companyname);
    NSString *type = StrCat([GVUserDefaults standardUserDefaults].type,@"专家");
    
    INIT_LABEL_L(usernameLable,85,10,200,24,16,DEFAULT_FONT_COLOR,username, self.contentView);
    INIT_LABEL_L(ptLabel      ,85,36,200,24,12,DEFAULT_FONT_MID_COLOR,pt, self.contentView);
    INIT_LABEL_L(fieldLabel   ,85,36+18,200,24,12,DEFAULT_FONT_MID_COLOR,field, self.contentView);
    INIT_LABEL_L(fieldLabel   ,85,36+18*2,screen_width-20,24,12,DEFAULT_FONT_MID_COLOR,company, self.contentView);
    INIT_LABEL_L(typeLabel    ,18,72,64,24,12,DEFAULT_THEME_COLOR_UI,type, self.contentView);
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
