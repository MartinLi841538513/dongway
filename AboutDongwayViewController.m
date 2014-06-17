//
//  AboutDongwayViewController.m
//  Account
//
//  Created by dongway on 13-11-5.
//
//

#import "AboutDongwayViewController.h"
#import "Common.h"

@interface AboutDongwayViewController ()
{
    Common *common;
}

@end

@implementation AboutDongwayViewController

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
    
    
    self.title = @"关于懂味";
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    self.appVersion.text = [NSString stringWithFormat:@"懂味%@",nowVersion];
    self.scrollview.scrollEnabled = YES;
    [self.scrollview setContentSize:CGSizeMake(320, 600)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
