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
    
    userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 64, 64)];
    
    userImage.backgroundColor = DEFAULT_WHITE_COLOR;
    userImage.layer.cornerRadius = 4;
    userImage.layer.borderWidth = 1;
    userImage.layer.borderColor = DEFAULT_LINE_GRAY_COLOR.CGColor;
    [self.contentView addSubview:userImage];
    
    INIT_LABEL_L(usernameLable,85,10,200,24,16,DEFAULT_FONT_COLOR,@"", self.contentView);
    INIT_LABEL_L(ptLabel      ,85,36,200,24,12,DEFAULT_FONT_MID_COLOR,@"", self.contentView);
    INIT_LABEL_L(fieldLabel   ,85,36+18,200,24,12,DEFAULT_FONT_MID_COLOR,@"", self.contentView);
    INIT_LABEL_L(companyLabel ,85,36+18*2,screen_width-20,24,12,DEFAULT_FONT_MID_COLOR,@"", self.contentView);
    INIT_LABEL_L(typeLabel    ,18,72,64,24,12,DEFAULT_THEME_COLOR_UI,@"", self.contentView);
}

-(void)setData {
    
    NSString *username = [GVUserDefaults standardUserDefaults].userName;
    NSString *pt = StrCat4(NSLocalizedString(@"position", nil),[GVUserDefaults standardUserDefaults].position, @"/", [GVUserDefaults standardUserDefaults].title);
    NSString *field = StrCat(NSLocalizedString(@"research", nil),[GVUserDefaults standardUserDefaults].field);
    NSString *company = StrCat(NSLocalizedString(@"addr", nil),[GVUserDefaults standardUserDefaults].companyname);
    NSString *type = StrCat([GVUserDefaults standardUserDefaults].type,NSLocalizedString(@"expert", nil));
    
    usernameLable.text = username;
    ptLabel.text = pt;
    fieldLabel.text = field;
    companyLabel.text = company;
    typeLabel.text = type;
    
    
    [userImage setImage:[UIImage imageNamed:@"icon_user"]];
    
    
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
