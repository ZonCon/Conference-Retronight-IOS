//
//  AbsWorldListCollectionViewController.h
//  Abs Fitness Express
//
//  Created by Hrushikesh  on 15/11/15.
//  Copyright © 2015 MeGo Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentItemsListCollectionViewController : UICollectionViewController <NSURLConnectionDelegate>

@property (nonatomic, strong) NSString *idSrv;

@property (nonatomic, strong) NSMutableArray *arrTitles;
@property (nonatomic, strong) NSMutableArray *arrSubTitles;
@property (nonatomic, strong) NSMutableArray *arrTimes;
@property (nonatomic, strong) NSMutableArray *arrPictures;
@property (nonatomic, strong) NSMutableArray *arrSrvIds;

@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end
