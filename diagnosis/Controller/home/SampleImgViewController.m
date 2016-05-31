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
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, screen_width, screen_height-NAV_HEIGHT)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

     imgView.contentMode = UIViewContentModeScaleAspectFit;
    [imgView setMultipleTouchEnabled:YES];
    [imgView setUserInteractionEnabled:YES];
    oldFrame = imgView.frame;
    largeFrame = CGRectMake(0 - screen_width, 0 - screen_height,5 * oldFrame.size.width, 5 * oldFrame.size.height);
    
    [self.view addSubview:imgView];
    
    [self addGestureRecognizerToView:imgView];
}

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (imgView.frame.size.width < oldFrame.size.width) {
            imgView.frame = oldFrame;
            //让图片无法缩得比原图小
        }
        if (imgView.frame.size.width > 3 * oldFrame.size.width) {
            imgView.frame = largeFrame;
        }
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
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
