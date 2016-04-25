//
//  LoginViewController.m
//  Project
//
//  Created by MAC on 12/07/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    delObj=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    UIImageView *backgroundImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundImage.image=[UIImage imageNamed:@"background@2x.png"];
    [self.view addSubview:backgroundImage];
    
      
    logo=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-190)/2, 75, 381/2,261/2)];
    logo.image=[UIImage imageNamed:@"logo_img@@2x.png"];
    [self.view addSubview:logo];
    
    UIColor *color = [UIColor colorWithRed:127.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:1.0];

    
    
    
    scrollViewer = [[UIScrollView alloc] init];
    scrollViewer.showsHorizontalScrollIndicator=NO;
    scrollViewer.showsVerticalScrollIndicator=NO;
    scrollViewer.backgroundColor=[UIColor clearColor];
    scrollViewer.delegate=self;
    [self.view addSubview:scrollViewer];
    scrollViewer.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrollViewer.contentSize = CGSizeMake(320, self.view.frame.size.height);
    
    
    
    
    UIImageView *error_img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_error@2x.png"]];
    error_img.frame=CGRectMake(20,280-35, self.view.frame.size.width-40, 35);
    [scrollViewer addSubview:error_img];
    
    errorLabel=[[UILabel alloc] initWithFrame:CGRectMake(25,280-35, self.view.frame.size.width-40, 35)];
    errorLabel.backgroundColor=[UIColor clearColor];
    errorLabel.textColor=[UIColor whiteColor];
    [scrollViewer addSubview:errorLabel];
    
    
    UIImageView *firstImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email_txt@2x.png"]];
    firstImg.frame=CGRectMake(20,280, self.view.frame.size.width-40, 101/2);
    [scrollViewer addSubview:firstImg];
    
    
    usernameTxt=[[UITextField alloc] init];
    usernameTxt.frame=CGRectMake(25,282, self.view.frame.size.width-50, 101/2);
    usernameTxt.tag=1;
    usernameTxt.delegate=self;
    usernameTxt.borderStyle=UITextBorderStyleNone;
    usernameTxt.textAlignment=NSTextAlignmentLeft;
    usernameTxt.returnKeyType = UIReturnKeyNext;
    usernameTxt.keyboardType=UIKeyboardTypeEmailAddress;
    [usernameTxt setAutocorrectionType:UITextAutocorrectionTypeNo];
    usernameTxt.autocapitalizationType=UITextAutocapitalizationTypeWords;
    usernameTxt.font=[UIFont fontWithName:@"Arial" size:25];
    usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    [scrollViewer addSubview:usernameTxt];
    
    
    
    UIImageView *passwordImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email_txt@2x.png"]];
    passwordImg.frame=CGRectMake(20,329, self.view.frame.size.width-40, 101/2);
    [scrollViewer addSubview:passwordImg];
    
    
    passwordTxt=[[UITextField alloc] init];
    passwordTxt.frame=CGRectMake(25,332, self.view.frame.size.width-40, 101/2);
    passwordTxt.tag=2;
    passwordTxt.delegate=self;
    passwordTxt.borderStyle=UITextBorderStyleNone;
    passwordTxt.textAlignment=NSTextAlignmentLeft;
    passwordTxt.returnKeyType = UIReturnKeyNext;
    passwordTxt.keyboardType=UIKeyboardTypeEmailAddress;
    [passwordTxt setAutocorrectionType:UITextAutocorrectionTypeNo];
    passwordTxt.autocapitalizationType=UITextAutocapitalizationTypeWords;
    passwordTxt.font=[UIFont fontWithName:@"Arial" size:25];
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    passwordTxt.secureTextEntry=YES;
    [scrollViewer addSubview:passwordTxt];
    
    
    
    
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(20, self.view.frame.size.height-100, self.view.frame.size.width-40, 61.5);
    [loginBtn setImage:[UIImage imageNamed:@"login_img.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    [scrollViewer addSubview:loginBtn];
    

    
    
   
    
}

#pragma mark This Function used to call the login api.
-(void)loginPressed{
    if ([self loginValidation]) {
        
        [delObj showView];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loginUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WebServiceResponse:) name:@"loginUser" object:nil];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setValue:usernameTxt.text forKey:@"username"];
    [dict setValue:passwordTxt.text forKey:@"password"];
    [delObj PostWebServer:dict type:@"loginUser"];
        
        
    }
}

#pragma mark This used to check the Validation.

-(BOOL)loginValidation{
    
    if(usernameTxt.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter Email"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if(passwordTxt.text.length<1)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter Password"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (passwordTxt.text.length>0)
    {
        NSRange range = [passwordTxt.text rangeOfString:@" "];
        if(range.location == NSNotFound)
        {
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please remove spaces from password"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
            
        }
    }
    
    
    return YES;
}


#pragma mark This Function used to get the api response.
-(void)WebServiceResponse:(NSNotification *)dictionary{
    NSDictionary *dict=[dictionary userInfo];
    NSLog(@"dict----%@",dict);
    [delObj hideView];

    if ([dict objectForKey:@"message"]) {
        
        errorLabel.text=[dict valueForKey:@"message"];
    }
    else{
        
        errorLabel.text=nil;
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loginUser" object:nil];
        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"auth_token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"email"] forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"redirect_to"] forKey:@"redirect_to"];
        webViewController *filter=[[webViewController alloc] init];
        [self.navigationController pushViewController:filter animated:YES];
    }

    
    
    
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:@"Start" context:nil];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView setAnimationDelegate:self];
    scrollViewer.transform=CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 0);
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return TRUE;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    if (self.view.frame.size.height==480) {
        scrollViewer.transform=CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , -50);

    }
    
    
    return YES;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
