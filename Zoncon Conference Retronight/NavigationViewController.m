//
//  NavigationViewController.m
//  Zoncon Ecommerce Morningmist
//
//  Created by Hrushikesh  on 15/04/16.
//  Copyright © 2016 MeGo Technologies. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#include <unistd.h>
#include <netdb.h>
#import "globals.h"
#import "DbHelper.h"
#import "AppDelegate.h"
#import "SyncViewController.h"
#import <objc/runtime.h>
#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

const char keyIdStreamSrv;
const char keyIdItemSrv;
const char keyIdDiscount;
const char keyBookingPrice;
@synthesize notifParams = _notifParams;
@synthesize labelBadge = _labelBadge;
UIAlertView *alertConfirmAddToCart;
UIAlertView *alertMaxCartLimit;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        return NO;
    }
    else{
        return YES;
    }
    
}

@end
