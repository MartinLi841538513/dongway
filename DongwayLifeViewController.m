//
//  DongwayLifeViewController.m
//  Account
//
//  Created by dongway on 13-11-5.
//
//

#import "DongwayLifeViewController.h"
#import "Common.h"
#import "WebViewController.h"

@interface DongwayLifeViewController ()
{
    Common *common;
}

@end

@implementation DongwayLifeViewController

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
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"懂味生活";
    self.checkDetail.userInteractionEnabled = YES;
    UITapGestureRecognizer *checkDetailButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkDetailAction:)];
    [self.checkDetail addGestureRecognizer:checkDetailButton];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.bgView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height, 320, 500)];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkDetailAction:(id)sender
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://app.dongway.com.cn/"]];
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webViewController.urlString = @"http://app.dongway.com.cn/";
    webViewController.title = @"懂味生活";
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
