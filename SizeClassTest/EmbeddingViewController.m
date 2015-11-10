//
//  EmbeddingViewController.m
//  SizeClassTest
//
//  Created by Paul on 11/11/15.
//  Copyright © 2015 Mathemusician.net. All rights reserved.
//

#import "EmbeddingViewController.h"

#import "ViewController.h"


@implementation EmbeddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Instantiate 真正的內容 view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];

    // 加入到這個 view controller 為 child view controller
    // addChildViewController, addSubview, didMoveToParentViewController
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];

    // Autolayout
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[child]|" options:0 metrics:nil views:@{ @"child" : viewController.view }]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[child]|" options:0 metrics:nil views:@{ @"child" : viewController.view }]];

    [viewController didMoveToParentViewController:self];
}

- (UITraitCollection *)overrideTraitCollectionForChildViewController:(UIViewController *)childViewController
{
    // 直向：寬小於高
    if (CGRectGetWidth(self.view.bounds) < CGRectGetHeight(self.view.bounds)) {

        UITraitCollection *horizontalCompact = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
        UITraitCollection *verticalRegular   = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular];
        return [UITraitCollection traitCollectionWithTraitsFromCollections:@[ horizontalCompact, verticalRegular ]];
    }
    // 橫向
    else {

        UITraitCollection *horizontalRegular = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
        UITraitCollection *verticalCompact   = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
        return [UITraitCollection traitCollectionWithTraitsFromCollections:@[ horizontalRegular, verticalCompact ]];
    }
}

@end
