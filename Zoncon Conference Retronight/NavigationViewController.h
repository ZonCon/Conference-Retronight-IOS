//
//  NavigationViewController.h
//  Zoncon Ecommerce Morningmist
//
//  Created by Hrushikesh  on 15/04/16.
//  Copyright © 2016 MeGo Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController <UITabBarControllerDelegate, UITabBarDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) NSString *notifParams;

@property (nonatomic, strong) UILabel *labelBadge;

- (BOOL)isNetworkAvailable;

@end
