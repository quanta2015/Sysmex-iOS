//
//  SampleImgInfoTableViewCell.m
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "SampleImgInfoTableViewCell.h"
#import "SampleImgViewController.h"
#import "SampleDiagViewController.h"

@implementation SampleImgInfoTableViewCell 

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
}

-(void)setDataList:(NSMutableArray *)dataList :(NSString *)title :(int)index{
    
    if (IsNilOrNull(dataList)||(dataList.count==0)) {
        return;
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screen_width, 24)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:10];
    _titleLabel.textColor = DEFAULT_FONT_MID_COLOR;
    [self.contentView addSubview:_titleLabel];
    
    _dataList = dataList;
    _titleLabel.text = title;
    
    int i;
    int _t = (index == 6)?3:4;
    int _wide = (screen_width-M_MARGIN*5)/_t;
    
    for (i=0; i<dataList.count; i++) {
        
        int _x = 15+i%_t*(_wide+10);
        int _y = 30+i/_t*(_wide+10);
        
        NSString *imgUrl = StrCat(urlServer, [(NSDictionary*)[dataList objectAtIndex:i] objectForKey:@"picurl"]);
        
        imgUrl = ReplaceUrl(imgUrl);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setFrame:CGRectMake(_x, _y, _wide, _wide) ];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [self.contentView addSubview:imageView];
        
        CALayer * layer = [imageView layer];
        layer.borderColor = [DEFAULT_FONT_LIGHT_COLOR CGColor];
        layer.borderWidth = 1.0f;
        
        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tmpBtn.tag = i+index*10;
        [tmpBtn setFrame:CGRectMake(_x, _y, _wide, _wide)];
        [tmpBtn addTarget:self action:@selector(showImgDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tmpBtn];
    }
    
}

-(void) showImgDetail:(UITapGestureRecognizer *)sender {
    
    int selectedTag = ((UIButton *)sender).tag;
    NSLog(@"%d",selectedTag);
    int selectedImg = selectedTag%10;
    
    
    if (selectedTag >= 60) {    //普通图片数据
        
        UITableViewController *uc = (UITableViewController*)[self GetRootViewController];
        SampleDiagViewController *nextVC = [[SampleDiagViewController alloc] init];
        
        nextVC.sample = [_dataList objectAtIndex:selectedImg];
        [uc.navigationController pushViewController:nextVC animated:NO];
        [uc.navigationController setNavigationBarHidden:false animated:NO];
        
    }else{                      //镜检切片数据
        
        UITableViewController *uc = (UITableViewController*)[self GetRootViewController];
        SampleImgViewController *nextVC = [[SampleImgViewController alloc] init];
        
        NSString *imgUrl = StrCat(urlServer, [(NSDictionary*)[_dataList objectAtIndex:selectedImg] objectForKey:@"picurl"]);
        nextVC.imgUrl = ReplaceUrl(imgUrl);
        [uc.navigationController pushViewController:nextVC animated:NO];
        [uc.navigationController setNavigationBarHidden:false animated:NO];
    }
    
    
}

-(UIViewController *) GetRootViewController {
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    return (UIViewController*)object;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
