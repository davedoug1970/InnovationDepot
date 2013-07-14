//
//  IDViewController.m
//  InnovationDepot
//
//  Created by David Douglas on 7/13/13.
//  Copyright (c) 2013 Innovation Depot. All rights reserved.
//

#import "IDViewController.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface IDViewController ()

@end

@implementation IDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //UIImage *image = [UIImage imageNamed:@"firstfloor.png"];
    //self.mapView = [[UIImageView alloc] initWithImage:image];
    //self.mapView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};

    [[NSBundle mainBundle] loadNibNamed:@"MapImageView" owner:self options:nil];
    self.mapView.transform = CGAffineTransformRotate(self.mapView.transform, DEGREES_TO_RADIANS(-90));

    [self.scrollView addSubview:self.mapView];
    self.scrollView.contentSize = CGSizeMake(self.mapView.frame.size.width, self.mapView.frame.size.height);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect scrollViewFrame = self.view.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
    self.scrollView.maximumZoomScale = 1.0f;
    //self.scrollView.zoomScale = minScale;
    
    [self.scrollView setZoomScale:minScale];
    
    [self centerScrollViewContents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
        [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mapView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.mapView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.mapView.frame = contentsFrame;
}

@end
