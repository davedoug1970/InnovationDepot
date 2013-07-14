//
//  IDViewController.h
//  InnovationDepot
//
//  Created by David Douglas on 7/13/13.
//  Copyright (c) 2013 Innovation Depot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *mapView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic) CGFloat maximumZoomScale;
@property(nonatomic) CGFloat minimumZoomScale;

@end
