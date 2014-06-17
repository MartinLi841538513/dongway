//
//  RegisterViewController.m
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import "RegisterViewController.h"
#import "userViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "Login.h"
#import "StateModel.h"
#import "UserInfosModel.h"
#import "GlobalVariateModel.h"

@interface RegisterViewController ()
{
    BOOL agreeRegisterProtocol;
    int prewTag ;  //编辑上一个UITextField的TAG,需要在XIB文件中定义或者程序中添加，不能让两个控件的TAG相同
    float prewMoveY; //编辑的时候移动的高度
    NSDictionary *theNewUserDictionary;
    BOOL internetStatusBool;
    UIKeyboardViewController *keyBoardController;
    StateModel *stateModel;
    UserInfosModel *userInfosModel;
    GlobalVariateModel *globalVariateModel;
    Common *common;
}

@end

@implementation RegisterViewController



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
    
    self.title = @"注册";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:NO];//显示导航栏
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    //选择复选框
    agreeRegisterProtocol = YES;
    self.registerProtocolCheckbox.userInteractionEnabled = YES;
    self.registerProtocolCheck.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *registerProtocolCheck = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerProtocolCheckboxAction:)];
    UITapGestureRecognizer *registerProtocolCheckbox = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerProtocolCheckboxAction:)];
    [self.registerProtocolCheck addGestureRecognizer:registerProtocolCheck];
    [self.registerProtocolCheckbox addGestureRecognizer:registerProtocolCheckbox];
    
    //注册协议可点击
    self.registerProtocol.userInteractionEnabled = YES;
    UITapGestureRecognizer *registerProtocol = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerProtocolAction:)];
    [self.registerProtocol addGestureRecognizer:registerProtocol];
    
    stateModel = [[StateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    
    self.scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *scrollViewAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.scrollView addGestureRecognizer:scrollViewAction];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    NSLog(@"UINavigationController(Magic)");
    LoginViewController *loginViewController = [[LoginViewController alloc] init];

    return loginViewController;
}

//点击注册协议的checkbox called
-(void)registerProtocolCheckboxAction:(UITapGestureRecognizer *) sender
{
    if(agreeRegisterProtocol == NO)
    {
        self.registerProtocolCheckbox.image = [UIImage imageNamed:@"checkbuttonyes.PNG"];
        agreeRegisterProtocol = YES;
    }
    else if(agreeRegisterProtocol == YES)
    {
        self.registerProtocolCheckbox.image = [UIImage imageNamed:@"checkbuttonno.PNG"];
        agreeRegisterProtocol = NO;
    }
}

//点击注册协议called
-(void)registerProtocolAction:(UITapGestureRecognizer *) sender
{
    //选择日期
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:@"阅读完毕"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    //    actionSheet.userInteractionEnabled = YES;
    //setup UITextField for the UIActionSheet
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 330)];

        text.editable = NO;
    text.layer.masksToBounds = YES; //没这句话它圆不起来
    text.layer.cornerRadius = 8.0; //设置图片圆角的尺度
    //    [text setKeyboardType:UIKeyboardTypeAlphabet];
    //    [text setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [actionSheet addSubview:text];
    [actionSheet showInView:self.view.window];
    text.text = @"懂味网服务条款\n欢迎您使用懂味网为你提供的各项服务，懂味网将为您提供长沙地区的餐饮信息，当用户完成注册，则与本公司达成协议，用户必须遵守以下服务条款，同时可以享受懂味网提供的各种服务。用户应随时关注本服务条款的修改，如果您继续使用服务表示您已经接受修改后的条款。本公司对本服务条款有最终的解释权和修订权。\n一、懂味网运用自己的操作系统，为会员提供餐饮消费信息、优惠信息等网络服务。懂味网保留随时修改或中断服务而不需知照会员的权利。懂味网行使修改或中断服务的权利，不需要对会员或第三方负责。长沙懂之味信息科技有限公司会根据发展需要修改服务条款，懂味网服务条款一旦发生变动，会在用户进入下一步使用前的页面提示修改的内容。如果用户同意，请点击“同意服务条款”，如果不同意，则及时取消您的使用服务资格。\n二、会员注册义务,在注册过程中，您需要要求，真实、准确填写您的资料。用户名的注册与使用应符合网络道德，遵守国家法律法规。注册成功后，您需要保护自己的账号和密码，并对您的用户名和密码发生的所有活动承担责任。因会员本人而造成的任何损失，由会员本人负责。用户若发现任何非法使用用户帐号或安全漏洞的情况，应当立即通告长沙懂之味信息科技有限公司；对该行为造成的损失，我公司不承担任何责任。\n三、会员的权利与义务\n1、您有权根据本服务条款及懂味网公告上的相关规则对站内商户发布真实的图片和真实的评价信息；\n2、您有权帮助懂味网完善商户电话、交通等信息\n3、您必须保证在使用懂味网的各项服务中遵守中华人民共和国的法律法规、遵守网络道德；\n4、您发布的信息不得侵犯他人的知识产权或其他合法利益；\n5、您有权修改您个人账户中可修改信息；\n四、我公司的权利和义务\n1、我公司有义务在维护懂味网整个平台的正常运行，并努力提升和改进技术；\n2、本公司没有义务对所有会员的注册资料、行为及其他事项进行事先审查；\n3、对于您在懂味网上的不当行为或任何我公司认为应当终止服务的情况，我公司有权删除信息或终止服务，且无须征得您的同意；\n4、我公司有权对您的注册资料及在口碑网上的行为进行查阅，发现注册资料存在问题或有合理理由怀疑相关行为不当的，有权向您发出询问及要求修正；\n5、本公司网可能通过使用您的个人信息，向您提供服务，包括但不限于向您发出活动和服务信息等；\n6、本公司保留删除站内各类不符合规定点评而不通知会员的权利\n五、您授予本公司的许可使用权\n您授予本公司永久的、免费的、完整的许可使用权利（并且有权对该权利进行再授权），使我公司有权使用、复制、修改、发布、翻译、分发您的资料或制作其派生作品，以已知或日后开发的任何形式、媒体或技术，将您的资料纳入其他作品里。\n六、隐私权\n懂味网承诺不公开您您的注册信息及其他个人信息。但在下列情况下，我公司有权全部或部分披露您的信息。\n1、经您同意，向第三方披露；\n2、根据法律的规定，或应行政机关、司法机关要求，向第三人或行政机关、司法机关披露\n3、如您是权利人并针对他人在懂味网上侵犯您利益的行为提起投诉，应被投诉人要求，向被投诉人披露；\n4、权利人认为您在懂味网上的行为侵犯其合法权利并提出投诉的，可向权利人披露；\n5、为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\n6、您出现违反懂味网网站规则或者中国有关法律法规情况，，需要向第三方披露的；\n7、根据法律法规和懂味网网站规则，其他本网站认为适合披露的。\n七、免责声明\n您将对您发布的信息及其他在懂味网上发生的任何行为承担法律责任，懂味网对此不负任何责任。\n八、管辖\n因本协议或本公司服务所引起的或与其有关的任何争议，应向湖南省长沙市岳麓区人民法院提起诉讼并适用中华人民共和国法律。";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)sendCodeNumber:(id)sender {
    if(self.phoneNumber.text == nil)
        self.phoneNumber.text = @"";
    NSString *phoneNumber = self.phoneNumber.text;
    //判断手机号码是否合法
    if([self isValidateMobile:phoneNumber])
    {
        //填写手机号码，发送到该手机验证码
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [stateModel sendCodeStateWithPhoenNumberSource:phoneNumber];
            NSString *state = stateModel.state;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                if([state isEqualToString:@"1"])
                {
                    //发送成功
                    [SVProgressHUD showSuccessWithStatus:@"发送成功，注意查收!"];
                    return;
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"发送失败，再试一试吧!"];
                    return;
                }
                
            });
        });
    }
    //如果不合法，则给出提示，并返回
    else
    {
        [SVProgressHUD showErrorWithStatus:@"号码输入有误!"];
        return;
    }
    

}

- (IBAction)userRegister:(id)sender {
    NSString *username = self.username.text;
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    NSString *passwordConfirm = self.passwordConfirm.text;
    NSString *phoneNumber = self.phoneNumber.text;
    
    //username长度控制在1-30
    if(!([username length]>=1&&[username length]<=30))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"用户名的长度为1-30位 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.username becomeFirstResponder];
        return;
    }
    //username由字母，汉字或数字组成
    else if(![self isValidateUsername:username])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"用户名只能包括中英文和数字!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.username becomeFirstResponder];
        return;
    }
    else if(!([password length]>=6&&[password length]<=12))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"密码的长度为6-12位 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.password becomeFirstResponder];
        return;
    }
    else if(![self isValidatePassword:password])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"密码只能是数字和英文字符 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.password becomeFirstResponder];
        return;
    }
    else if([password isEqualToString:passwordConfirm] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"两次输入的密码不一样 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.passwordConfirm becomeFirstResponder];
        return;
    }
    //邮件格式
    else if(![self isValidateEmail:email])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"请输入正确的邮件 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.email becomeFirstResponder];
        return;
    }
    //电话格式
    else if(!([phoneNumber length] == 11))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"手机号码的长度都是11位的哦 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.phoneNumber becomeFirstResponder];
        return;
    }
    else if(![self isValidateMobile:phoneNumber])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"手机号不合法 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.phoneNumber becomeFirstResponder];
        return;
    }
    //是否同意注册协议
    else if(agreeRegisterProtocol == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦!" message:@"你要同意注册协议才能注册 !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else
    {
        //验证码是否一样
        [SVProgressHUD show];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSString *source = self.phoneNumber.text;
            NSString *code = self.authenticode.text;
            NSString *userName = self.username.text;
            [stateModel checkCodeStateWithCode:code andPhoneNumberSource:source andUsername:userName];
            float checkState = [stateModel.state floatValue];
            NSArray *theNewUserArray;
            if(checkState > 0)
            {
                [userInfosModel setUserInfosWithUsername:userName andPassword:password andPhoneNumber:phoneNumber andEmail:email];
                theNewUserArray = userInfosModel.userInfos;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                if(checkState <= 0)
                {
                    [SVProgressHUD showErrorWithStatus:@"验证码输入错误!"];
                    [self.authenticode becomeFirstResponder];
                    return;
                }
                if([theNewUserArray count] > 0) //注册成功
                {
                    theNewUserDictionary = [theNewUserArray objectAtIndex:0];
                    UIActionSheet *succeedRegister = [[UIActionSheet alloc] initWithTitle:@"注册成功,是否进入登录状态？" delegate:self cancelButtonTitle:@"否" destructiveButtonTitle:@"是!" otherButtonTitles:nil];
                    [succeedRegister showInView:self.view.window];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"用户名已存在!"];
                    return;
                }
                
            });
        });
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet destructiveButtonIndex])
    {
        UserViewController *userView = [[UserViewController alloc] init];
        [globalVariateModel setUserInfos:theNewUserDictionary];
        [globalVariateModel setIsLogin:@"yes"];
        self.hidesBottomBarWhenPushed = NO;
        userView.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:userView animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }
    else if(buttonIndex == [actionSheet cancelButtonIndex])
    {
        return;
    }
}

- (IBAction)backgroundTap:(id)sender {
    [self.username resignFirstResponder];
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
    [self.passwordConfirm resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    [self.authenticode resignFirstResponder];
}

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头11个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//密码只能是数字＋字母
-(BOOL)isValidatePassword:(NSString *)password
{
    NSString *passwordRegex = @"^[0-9a-zA-Z]{6,12}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [passwordTest evaluateWithObject:password];
}

//username只能由中文，英语，数字组成
-(BOOL)isValidateUsername:(NSString *)username
{
    NSString *usernameRegex = @"^[0-9a-zA-Z\u4e00-\u9fa5]{1,30}$";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",usernameRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [usernameTest evaluateWithObject:username];
}
@end








