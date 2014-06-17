//
//  WebViewController.m
//  Account
//
//  Created by dongway on 13-12-4.
//
//

#import "WebViewController.h"
#import "SVProgressHUD.h"
#import "Common.h"

@interface WebViewController ()
{
    Common *common;
}

@end

@implementation WebViewController

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
    // Do any additional setup after loading the view from its nib.
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   

    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.webView loadRequest:request];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];                                  
            [self.webView setScalesPageToFit:YES];
        });
    });


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

@end
