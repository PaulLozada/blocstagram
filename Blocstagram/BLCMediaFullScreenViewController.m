//
//  BLCMediaFullScreenViewController.m
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-31.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCMediaFullScreenViewController.h"
#import "BLCMedia.h"


@interface BLCMediaFullScreenViewController () <UIScrollViewDelegate>

@property(nonatomic,strong) BLCMedia *media;
@property(nonatomic,strong) UITapGestureRecognizer *tap;
@property(nonatomic,strong) UITapGestureRecognizer *doubleTap;


@end

@implementation BLCMediaFullScreenViewController

#pragma mark = UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self centerScrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self centerScrollView];
    
}
-(instancetype) initWithMedia:(BLCMedia *)media {
    self = [super init];
    
    if (self) {
        self.media = media;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.scrollView];
    
    self.imageView = [UIImageView new];
    self.imageView.image = self.media.image;
    
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.media.image.size;


    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFired:)];
    
    self.doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapFired:)];
    self.doubleTap.numberOfTapsRequired = 2 ;
    
    [self.tap requireGestureRecognizerToFail:self.doubleTap];
    
    [self.scrollView addGestureRecognizer:self.tap];
    [self.scrollView addGestureRecognizer:self.doubleTap];

}

#pragma mark - Gesture Recognizers

-(void)tapFired:(UITapGestureRecognizer *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)pressedDisclosure:(UIButton *)sender{
    
    NSArray *array = [NSArray arrayWithObjects:@"Test", nil];
    UIActivityViewController *activity = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
    
    NSLog(@"Test");
}

-(void)doubleTapFired: (UITapGestureRecognizer *)sender{
    
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        
        CGPoint locationPoint = [sender locationInView:self.imageView];
        
        CGSize scrollViewSize = self.scrollView.bounds.size;
        
        CGFloat width = scrollViewSize.width / self.scrollView.maximumZoomScale;
        CGFloat height = scrollViewSize.height / self.scrollView.maximumZoomScale;
        CGFloat x = locationPoint.x - (width / 2);
        CGFloat y = locationPoint.y - (height/ 2);
        
        [self.scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressedDisclosure:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor blackColor];
    [button setTitle:@"Share" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];

    [button setFrame:CGRectMake(0, 0, 568, 100)];

    
    
    
    
    
    self.scrollView.frame = self.view.bounds;
    
    CGSize scrollViewFrameSize = self.scrollView.frame.size;
    CGSize scrollViewContentSize = self.scrollView.contentSize;
    
    CGFloat scaleWidth = scrollViewFrameSize.width / scrollViewContentSize.width;
    CGFloat scaleHeight = scrollViewFrameSize.height / scrollViewContentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1;
}

-(void)centerScrollView {
    [self.imageView sizeToFit];
    
    CGSize boundSize = self.scrollView.bounds.size;
    CGRect contentFrame = self.imageView.frame;
    
    if (contentFrame.size.width < boundSize.width) {
        
        contentFrame.origin.x = (boundSize.width - CGRectGetWidth(contentFrame)) / 2 ;
    } else {
        contentFrame.origin.x = 0 ;
    }
    
    if (contentFrame.size.height < boundSize.height) {
        contentFrame.origin.y = (boundSize.height - CGRectGetHeight(contentFrame)) / 2 ;
    } else {
        contentFrame.origin.y = 0;
    }
    self.imageView.frame = contentFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
