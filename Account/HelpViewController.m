//
//  HelpViewController.m
//  Account
//
//  Created by wang zhe on 8/9/13.
//
//

#import "HelpViewController.h"
#import "Common.h"
#import "WebViewController.h"

@interface HelpViewController ()
{
    Common *common;
}

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"帮      助";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    
    
    // Do any additional setup after loading the view from its nib.
    //设置电话号码可以点击拨打
    self.httpURL.userInteractionEnabled = YES;
    self.commonProblem.userInteractionEnabled = YES;
    self.connectUs.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *httpURL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(httpURLAction:)];
    UITapGestureRecognizer *commonProblem = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commonProblemAction:)];
    UITapGestureRecognizer *connectUs = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(connectUsAction:)];
    
    [self.httpURL addGestureRecognizer:httpURL];
    [self.commonProblem addGestureRecognizer:commonProblem];
    [self.connectUs addGestureRecognizer:connectUs];
    
 
    
}


-(void)httpURLAction:(id)sender
{
    NSString *tel = [NSString stringWithFormat:@"tel:%@",@"073185589427"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:tel];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];

    
}

//联系我们
- (void)connectUsAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://support@dongway.com.cn"]];
}

-(void)commonProblemAction:(id)sender
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.dongway.com.cn/help/reserve.htm"]];
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webViewController.urlString = @"http://www.dongway.com.cn/help/reserve.htm";
    webViewController.title = @"常见问题";
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
