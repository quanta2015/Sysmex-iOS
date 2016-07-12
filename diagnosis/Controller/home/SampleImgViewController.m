//
//  SampleImgViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/5/30.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "SampleImgViewController.h"


@interface SampleImgViewController ()
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
    UIImageView *imgView;
}

@end

@implementation SampleImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imgArr[_imgIndex]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    
    _imgScrollView = [[SMScrollView alloc] initWithFrame:self.view.bounds];
    _imgScrollView.maximumZoomScale = 3;
    _imgScrollView.delegate = self;
    _imgScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _imgScrollView.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:0.9];
    _imgScrollView.contentSize = imageView.frame.size;
    _imgScrollView.alwaysBounceVertical = NO;
    _imgScrollView.alwaysBounceHorizontal = NO;
    _imgScrollView.clipsToBounds = YES;
    [_imgScrollView addViewForZooming:imageView];
    [_imgScrollView scaleToFit];
    [self.view addSubview:_imgScrollView];
    
    _imgScrollView.imgArr = _imgArr;
    _imgScrollView.imgIndex = _imgIndex;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgScrollView.viewForZooming;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [imgView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
