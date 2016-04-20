//
//  AbsWorldCollectionViewController.h
//  Abs Fitness Express
//
//  Created by Hrushikesh  on 02/11/15.
//  Copyright (c) 2015 MeGo Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCategoriesViewController : UICollectionViewController <UIActionSheetDelegate>

@property (nonatomic, strong) UIPopoverController *userDataPopover;

@property (nonatomic, strong) NSMutableArray *arrTitles;
@property (nonatomic, strong) NSMutableArray *arrSrvIds;
@property (nonatomic, strong) NSMutableArray *arrPictures;
@property (nonatomic, strong) NSMutableArray *arrNotifs;
@property (nonatomic, strong) NSTimer *timerBanner;
@property (nonatomic, strong) UILabel *labelBannerTitle;
@property (nonatomic, strong) UILabel *labelBannerSub;
@property (nonatomic, strong) UIImageView *pictureBanner;
@property (nonatomic) int indexBanner;
@property (nonatomic) int countBanner;

@end
