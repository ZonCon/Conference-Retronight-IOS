//
//  AbsWorldCollectionViewController.m
//  Abs Fitness Express
//
//  Created by Hrushikesh  on 02/11/15.
//  Copyright (c) 2015 MeGo Technologies. All rights reserved.
//

#import "ContentCategoriesViewController.h"
#import "ContentCategoriesViewCell.h"
#import "ContentItemsListCollectionViewController.h"
#import "globals.h"
#import "DbHelper.h"
#import "SyncViewController.h"
#import "AppDelegate.h"
#import "NavigationViewController.h"

@interface ContentCategoriesViewController ()

@end

@implementation ContentCategoriesViewController

@synthesize userDataPopover = _userDataPopover;
@synthesize arrNotifs = _arrNotifs;
@synthesize arrSrvIds = _arrSrvIds;
@synthesize arrTitles = _arrTitles;
@synthesize arrPictures = _arrPictures;
@synthesize timerBanner = _timerBanner;
@synthesize indexBanner = _indexBanner;
@synthesize countBanner = _countBanner;
@synthesize labelBannerSub = _labelBannerSub;
@synthesize labelBannerTitle = _labelBannerTitle;
@synthesize pictureBanner = _pictureBanner;

static NSString * const reuseIdentifier = @"Categories";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrTitles = [[NSMutableArray alloc]init];
    _arrSrvIds = [[NSMutableArray alloc]init];
    _arrPictures = [[NSMutableArray alloc]init];
    _arrNotifs = [[NSMutableArray alloc]init];
    
    
    _indexBanner = 0;
    _timerBanner = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                    target: self
                                                  selector:@selector(onTick:)
                                                  userInfo: nil repeats:YES];
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.view endEditing:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    _arrTitles = [[NSMutableArray alloc]init];
    _arrSrvIds = [[NSMutableArray alloc]init];
    _arrPictures = [[NSMutableArray alloc]init];
    _arrNotifs = [[NSMutableArray alloc]init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    _arrTitles = [[NSMutableArray alloc]init];
    _arrSrvIds = [[NSMutableArray alloc]init];
    _arrPictures = [[NSMutableArray alloc]init];
    _arrNotifs = [[NSMutableArray alloc]init];
    
    [self loadFromLocalDB];
    [self.collectionView reloadData];
    
}

- (void)loadFromLocalDB {
    
    _arrTitles = [[NSMutableArray alloc]init];
    _arrSrvIds = [[NSMutableArray alloc]init];
    _arrPictures = [[NSMutableArray alloc]init];
    _arrNotifs = [[NSMutableArray alloc]init];
    
    // Find streams
    NSDictionary *cv = @{
                         DB_COL_TYPE: DB_STREAM_TYPE_MESSAGE
                         };
    NSMutableArray *arr = [[DbHelper getSharedInstance] retrieveRecords:cv];
    
    for(int i = 3; i < arr.count; i++) {
        
        NSDictionary *cvStreams = arr[i];
        NSString *title = [cvStreams objectForKey:DB_COL_NAME];
        NSString *srvId = [cvStreams objectForKey:DB_COL_SRV_ID];
        NSString *_idStream = [cvStreams objectForKey:DB_COL_ID];
        NSString *picture = @"";
        
        //Find items belonging to the stream
        cv = @{
               DB_COL_TYPE: DB_RECORD_TYPE_ITEM,
               DB_COL_FOREIGN_KEY: _idStream
               };
        NSMutableArray *arrItems = [[DbHelper getSharedInstance] retrieveRecords:cv];
        
        if(i == 3) {
            _countBanner = arrItems.count;
        }
        
        if(arrItems.count > 0) {
            
            NSDictionary *cvItems = [arrItems objectAtIndex:0];
            NSString *_idItem = [cvItems objectForKey:DB_COL_ID];
            
            //Find pictures belonging to the item of the stream
            cv = @{
                   DB_COL_TYPE: DB_RECORD_TYPE_PICTURE,
                   DB_COL_FOREIGN_KEY: _idItem
                   };
            
            NSMutableArray *arrPictures = [[DbHelper getSharedInstance] retrieveRecords:cv];
            if(arrPictures.count > 0) {
                
                
                NSDictionary *cvPictures = [arrPictures objectAtIndex:0];
                picture = [cvPictures objectForKey:DB_COL_PATH_ORIG];
                
            }
            
        }
        
        cv = @{
               DB_COL_TYPE: DB_RECORD_TYPE_MESSAGESTREAM_NOTIFICATION_ALERT,
               DB_COL_SRV_ID: srvId
               };
        NSMutableArray *arrNotifs = [[DbHelper getSharedInstance] retrieveRecords:cv];
        if(arrNotifs.count > 0) {
            
            title = [title stringByAppendingString:@" (1)"];
            
        }
        
        if(![title isEqualToString:@"Terms"] && ![title isEqualToString:@"Terms (1)"] && ![title isEqualToString:@"TERMS"] && ![title isEqualToString:@"TERMS (1)"]) {
            
            [_arrTitles addObject:title];
            [_arrSrvIds addObject:srvId];
            [_arrPictures addObject:picture];
            
        }
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([[segue identifier] isEqualToString:@"ShopItemsList"])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        int rowNo = indexPath.row;
        ContentItemsListCollectionViewController *vc = [segue destinationViewController];
        // Pass any objects to the view controller here, like...
        vc.idSrv = [_arrSrvIds objectAtIndex:rowNo];
        
    }
    
}


#pragma mark <UICollectionViewDataSource>

- (void)dealloc {
    
    self.collectionView = nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrTitles.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([indexPath row] != 0) {
        
        CGFloat widthOfScreen  = (SCREEN_WIDTH - 41)/3;
        CGFloat width = widthOfScreen;
        return CGSizeMake(width, width);
        
    } else {
        
        CGFloat widthOfScreen  = [[UIScreen mainScreen] bounds].size.width - 20;
        CGFloat width = widthOfScreen;
        CGFloat height = (widthOfScreen*3)/4;
        return CGSizeMake(width, height);
        
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentCategoriesViewCell *cell = (ContentCategoriesViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if(_arrTitles.count > 0 && _arrPictures.count > 0) {
        
        NSString *title = [[_arrTitles objectAtIndex: [indexPath row]] uppercaseString];
        NSString *picture = [_arrPictures objectAtIndex: [indexPath row]];
        
        cell.textTitle.text = title;
        cell.textSub.text = title;
        
        if([indexPath row] == 0) {
            _labelBannerTitle = cell.textTitle;
            _labelBannerSub = cell.textSub;
            _pictureBanner = cell.imageView;
            cell.textSub.hidden = FALSE;
            [self onTick:_timerBanner];
        } else {
            cell.textSub.hidden = TRUE;
        }
        
        if(picture.length > 0) {
            
            NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSArray *arrPath =[picture componentsSeparatedByString: @"/"];
            NSString *fileName = [arrPath objectAtIndex:(arrPath.count - 1)];
            NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            
            NSError *attributesError = nil;
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&attributesError];
            
            NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
            long long fileSize = [fileSizeNumber longLongValue];
            
            if(fileExists && fileSize > 1000) {
                
                NSData * data = [NSData dataWithContentsOfFile:filePath];
                if(data) {
                    UIImage *original=[UIImage imageWithData:data];
                    UIImage *small = [UIImage imageWithCGImage:original.CGImage scale:0.1 orientation:original.imageOrientation];
                    cell.imageView.image=small;
                    if([indexPath row] == 0) {
                    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
                    }
                }
            } else {
                
                NSString *pictureUrl = [NSString stringWithFormat:@"%@%@%@", SERVER, UPLOADS, picture];
                NSURL *url = [NSURL URLWithString:pictureUrl];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                 {
                     
                     if(error == nil) {
                         
                         [data writeToFile:filePath atomically:YES];
                         UIImage *original=[UIImage imageWithData:data];
                         UIImage *small = [UIImage imageWithCGImage:original.CGImage scale:1.0 orientation:original.imageOrientation];
                         cell.imageView.image=small;
                         if([indexPath row] == 0) {
                         cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
                         }
                         
                     }
                     
                 }];
                
            }
            
        } else {
            cell.imageView.image = [UIImage imageNamed: @"cover.jpg"];
        }
        
        
    }
    
    // Configure the cell
    
    return cell;
}

-(void)onTick:(NSTimer *)timer {
    //do smth
    
    if(_indexBanner == _countBanner) {
        _indexBanner = 0;
    }
    
    NSDictionary *cv = @{
                         DB_COL_TYPE: DB_STREAM_TYPE_MESSAGE
                         };
    NSMutableArray *arr = [[DbHelper getSharedInstance] retrieveRecords:cv];
    
    if(arr.count > 0) {
        
        NSDictionary *cvStreams = arr[3];
        NSString *_idStream = [cvStreams objectForKey:DB_COL_ID];
        cv = @{
               DB_COL_TYPE: DB_RECORD_TYPE_ITEM,
               DB_COL_FOREIGN_KEY: _idStream
               };
        
        NSMutableArray *arrItems = [[DbHelper getSharedInstance] retrieveRecords:cv];
        NSDictionary *cvItems = [arrItems objectAtIndex:_indexBanner];
        NSString *_idItem = [cvItems objectForKey:DB_COL_ID];
        NSString *title = [cvItems objectForKey:DB_COL_TITLE];
        NSString *sub = [cvItems objectForKey:DB_COL_SUBTITLE];
        
        _labelBannerTitle.text = title;
        _labelBannerSub.text = sub;
        
        //Find pictures belonging to the item of the stream
        cv = @{
               DB_COL_TYPE: DB_RECORD_TYPE_PICTURE,
               DB_COL_FOREIGN_KEY: _idItem
               };
        
        NSMutableArray *arrPictures = [[DbHelper getSharedInstance] retrieveRecords:cv];
        if(arrPictures.count > 0) {
            
            
            NSDictionary *cvPictures = [arrPictures objectAtIndex:0];
            NSString *picture = [cvPictures objectForKey:DB_COL_PATH_ORIG];
            
            if(picture.length > 0) {
                
                NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSArray *arrPath =[picture componentsSeparatedByString: @"/"];
                NSString *fileName = [arrPath objectAtIndex:(arrPath.count - 1)];
                NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
                BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
                
                NSError *attributesError = nil;
                NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&attributesError];
                
                NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
                long long fileSize = [fileSizeNumber longLongValue];
                
                if(fileExists && fileSize > 1000) {
                    
                    NSData * data = [NSData dataWithContentsOfFile:filePath];
                    if(data) {
                        UIImage *original=[UIImage imageWithData:data];
                        UIImage *small = [UIImage imageWithCGImage:original.CGImage scale:0.1 orientation:original.imageOrientation];
                        _pictureBanner.image=small;
                    }
                } else {
                    
                    NSString *pictureUrl = [NSString stringWithFormat:@"%@%@%@", SERVER, UPLOADS, picture];
                    NSURL *url = [NSURL URLWithString:pictureUrl];
                    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
                    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                     {
                         
                         if(error == nil) {
                             
                             [data writeToFile:filePath atomically:YES];
                             UIImage *original=[UIImage imageWithData:data];
                             UIImage *small = [UIImage imageWithCGImage:original.CGImage scale:1.0 orientation:original.imageOrientation];
                             _pictureBanner.image=small;
                             _pictureBanner.contentMode = UIViewContentModeScaleAspectFill;
                             
                         }
                         
                     }];
                    
                }
                
            }
            
            
        }
        
        
    }
    
    _indexBanner++;
    
    
}

@end
