//
//  AbsWorldListCollectionViewCell.h
//  Abs Fitness Express
//
//  Created by Hrushikesh  on 15/11/15.
//  Copyright © 2015 MeGo Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentItemsListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *textTitle;
@property (nonatomic, strong) IBOutlet UILabel *textSub;
@property (nonatomic, strong) IBOutlet UILabel *textTime;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
