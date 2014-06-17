//
//  SXFeastActivityViewController.m
//  Account
//
//  Created by Sam Xie on 8/15/13.
//
//

#import "FeastActivityViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SXFeastActivityCell.h"
#import "DWActivitiessModel.h"
#import "SVProgressHUD.h"
#import "Common.h"
#import "WebViewController.h"

@interface FeastActivityViewController() {
    NSArray *dWActivities;
    NSArray *dWPreviousActivities;
    NSArray *dWCurrentActivities;
    DWActivitiessModel *dWActivitiesModel;
    Common *common;
}

@end

@implementation FeastActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    common = [[Common alloc] init];
    
    [common returnButton:self];
    
    self.title = @"试吃活动";
    
    
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.tintColor = [UIColor redColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.segmentedControl setFrame:CGRectMake(20, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height+10, 280, 30)];
    }
    else
    {
        [self.segmentedControl setFrame:CGRectMake(20, 10, 280, 30)];
    }
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = [[UIImageView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    dWActivitiesModel = [[DWActivitiessModel alloc] init];
    
    self.tableView.hidden = YES;
    self.tip.hidden = YES;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [dWActivitiesModel setDWActivitiesWithStatus:@"1"];
        dWCurrentActivities = dWActivitiesModel.DWActivities;
        dWActivities = dWCurrentActivities;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityIndicatorView stopAnimating];
            
            if([dWActivities count]<1)
            {
                [SVProgressHUD showImage:nil status:@"暂时没有活动了"];
                self.tableView.hidden = YES;
                self.tip.hidden = NO;
            }
            else
            {
                self.tableView.hidden = NO;
                self.tip.hidden = YES;
                [self.tableView reloadData];
                [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            }
            
        });
    });
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.tableView setFrame:CGRectMake(0, self.segmentedControl.frame.origin.y+self.segmentedControl.frame.size.height+5, 320, self.view.frame.size.height-110)];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)changeActivityTable:(id)sender {
    
    if ([sender selectedSegmentIndex] == 0)
    {
        if (dWCurrentActivities == nil)
        {
            self.tableView.hidden = YES;
            self.tip.hidden = YES;
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
            
            [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                [dWActivitiesModel setDWActivitiesWithStatus:@"1"];
                dWCurrentActivities = dWActivitiesModel.DWActivities;
                dWActivities = dWCurrentActivities;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [activityIndicatorView stopAnimating];
                    if([dWActivities count]<1)
                    {
                        [SVProgressHUD showImage:nil status:@"暂时没有活动了"];
                        self.tableView.hidden = YES;
                        self.tip.hidden = NO;
                        self.tip.text = @"没有当前活动,敬请期待!";
                    }
                    else
                    {
                        self.tableView.hidden = NO;
                        self.tip.hidden = YES;
                    }
                    [self.tableView reloadData];
                    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

                });
            });
        }
        else
        {
            dWActivities = dWCurrentActivities;
            [self.tableView reloadData];
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }
    }
    else {
        if (dWPreviousActivities == nil) {
            self.tableView.hidden = YES;
            self.tip.hidden = YES;
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
            
            [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [dWActivitiesModel setDWActivitiesWithStatus:@"3"];
                
                dWPreviousActivities = dWActivitiesModel.DWActivities;
                dWActivities = dWPreviousActivities;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [activityIndicatorView stopAnimating];
                    if([dWActivities count]<1)
                    {
                        [SVProgressHUD showImage:nil status:@"暂时没有活动了"];
                        self.tableView.hidden = YES;
                        self.tip.hidden = NO;
                        self.tip.text = @"加载数据失败!";
                    }
                    else
                    {
                        self.tableView.hidden = NO;
                        self.tip.hidden = YES;
                    }
                    [self.tableView reloadData];
                    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
                });
            });
        } else {
            dWActivities = dWPreviousActivities;
            [self.tableView reloadData];
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dWActivities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"FeastActivityCellIdentifier";
    SXFeastActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SXFeastActivityCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary* dWActivitiesDictByRow = [dWActivities objectAtIndex:row];
    [dWActivitiesModel setPropertysWithDictionary:dWActivitiesDictByRow];
    cell.titleInCell.text = dWActivitiesModel.title;
    cell.activityTimeInCell.text = [dWActivitiesModel.time substringWithRange:NSMakeRange(0, 19)];
    cell.addressInCell.text = dWActivitiesModel.address;
    cell.peopleNumberInCell.text = dWActivitiesModel.peopleNum;
    if ([dWActivitiesModel.status isEqualToString:@"1"]) {
        cell.statusInCell.text = @"活动正在进行";
    }
    else
    {
        cell.statusInCell.text = @"活动已结束";
    }
    
    //用小图，节省流量
    NSString *imageUrlThumbs;
    imageUrlThumbs =[dWActivitiesModel.imageUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
    imageUrlThumbs =[dWActivitiesModel.imageUrl stringByReplacingOccurrencesOfString:@".png" withString:@".thumbs.png"];
    [cell.imageViewInCell setImageWithURL:[NSURL URLWithString:imageUrlThumbs] placeholderImage:[UIImage imageNamed:@"logoLoading.jpg"]];
    
    
    cell.contentInCell.text = dWActivitiesModel.content;
    CGSize newContentInCellFrame = [cell.contentInCell.text sizeWithFont:[UIFont systemFontOfSize:10.f] constrainedToSize:CGSizeMake(307.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    cell.contentInCell.frame = CGRectMake(cell.contentInCell.frame.origin.x, cell.contentInCell.frame.origin.y, newContentInCellFrame.width, newContentInCellFrame.height+1);
    NSString *createTime = [NSString stringWithFormat:@"发布时间:%@",[dWActivitiesModel.createTime substringWithRange:NSMakeRange(0, 19)]];
    cell.createTimeInCell.text = createTime;
    cell.createTimeInCell.frame = CGRectMake(4.0f, newContentInCellFrame.height + 134, 176.0f, 10.f);
    cell.priseImageView.frame = CGRectMake(184, newContentInCellFrame.height+128, 15, 15);
    cell.priseLabel.frame = CGRectMake(203, newContentInCellFrame.height+123, 41, 31);
    cell.shareImageView.frame = CGRectMake(249, newContentInCellFrame.height+130, 30, 13);
    cell.shareLabel.frame = CGRectMake(277, newContentInCellFrame.height+123, 29, 31);
    cell.shareWith.frame = CGRectMake(230, newContentInCellFrame.height+88, 76, 61);
    
    cell.priseImageView.userInteractionEnabled = YES;
    cell.priseLabel.userInteractionEnabled = YES;
    cell.shareImageView.userInteractionEnabled = YES;
    cell.shareLabel.userInteractionEnabled = YES;
    cell.shareWith.userInteractionEnabled = YES;
    
    cell.priseImageView.tag = row;
    cell.priseLabel.tag = row;
    cell.shareImageView.tag = row;
    cell.shareLabel.tag = row;
    cell.shareWith.tag = row;
    
    UITapGestureRecognizer *priseImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priseAction:)];
    UITapGestureRecognizer *shareImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    UITapGestureRecognizer *priseLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priseAction:)];
    UITapGestureRecognizer *shareLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    UITapGestureRecognizer *shareWith = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    
    [cell.priseImageView addGestureRecognizer:priseImageView];
    [cell.priseLabel addGestureRecognizer:priseLabel];
    [cell.shareImageView addGestureRecognizer:shareImageView];
    [cell.shareLabel addGestureRecognizer:shareLabel];
    [cell.shareWith addGestureRecognizer:shareWith];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [dWActivitiesModel setPropertysWithDictionary:[dWActivities objectAtIndex:[indexPath row]]];
    NSString *string = dWActivitiesModel.content;
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:10.f] constrainedToSize:CGSizeMake(307.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    return 150.0f + size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dWActivitiesModel.BBSUrl]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    [dWActivitiesModel setPropertysWithDictionary:[dWActivities objectAtIndex:[indexPath section]]];
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webViewController.urlString = dWActivitiesModel.BBSUrl;
    webViewController.title = @"活动详情";
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

#pragma mark - self private method
//scale image to specific size
- (UIImage *) image:(UIImage *)unScaledImage scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [unScaledImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//赞一个
-(void)priseAction:(UITapGestureRecognizer *)sender
{
    NSUInteger row = sender.view.tag;
    NSDictionary* dWActivitiesDictByRow = [dWActivities objectAtIndex:row];
    [dWActivitiesModel setPropertysWithDictionary:dWActivitiesDictByRow];
    [SVProgressHUD showErrorWithStatus:@"缺少api"];
}

//分享
-(void)shareAction:(UITapGestureRecognizer *)sender
{
    NSUInteger row = sender.view.tag;
    NSDictionary* dWActivitiesDictByRow = [dWActivities objectAtIndex:row];
    [dWActivitiesModel setPropertysWithDictionary:dWActivitiesDictByRow];
    NSString *URL = dWActivitiesModel.BBSUrl;
    NSString *content = [NSString stringWithFormat:@"小伙伴们呀，懂味免费试吃大餐活动，一起去不啦!!!%@",URL];
    NSURL *url = [NSURL URLWithString:dWActivitiesModel.imageUrl];
    NSString *title = dWActivitiesModel.title;
    NSString *description = dWActivitiesModel.content;
    description = [common description_83:description];
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:content
                                               defaultContent:content
                                                        image:[ShareSDK pngImageWithImage:image]
                                                        title:title
                                                          url:URL
                                                  description:description
                                                    mediaType:SSPublishContentMediaTypeNews];

            [common shareContent:publishContent andViewController:self];
            
        });
    });
    
}

@end
