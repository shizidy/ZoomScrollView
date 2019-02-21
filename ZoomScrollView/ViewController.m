//
//  ViewController.m
//  ZoomScrollView
//
//  Created by Macmini on 2019/2/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import "ViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *enlargeImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.enlargeImage;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGRect(self.enlargeImage.frame));
    CGRect frame = self.enlargeImage.frame;
    
    frame.origin.y = (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) * 0.5 : 0;
    self.enlargeImage.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(self.enlargeImage.frame.size.width, self.enlargeImage.frame.size.height);
}
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    self.scrollView.contentSize = CGSizeMake(self.enlargeImage.frame.size.width + kScreenWidth, self.enlargeImage.frame.size.height);
//}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 3;
        _scrollView.delegate = self;
        [_scrollView addSubview:self.enlargeImage];
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIImageView *)enlargeImage {
    if (!_enlargeImage) {
        _enlargeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _enlargeImage.image = [UIImage imageNamed:@"123.jpg"];
        _enlargeImage.center = self.scrollView.center;
    }
    return _enlargeImage;
}


@end
