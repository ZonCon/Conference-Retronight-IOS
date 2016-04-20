//
//  MenuTableViewController.h
//  Abs Fitness Express
//
//  Created by Hrushikesh  on 02/11/15.
//  Copyright (c) 2015 MeGo Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController <UIPageViewControllerDelegate>

-(IBAction) writeFeedbackEmail:(id) sender;
-(IBAction) shareWithFriends:(id) sender;
-(IBAction) rateThisApp:(id) sender;

@end
