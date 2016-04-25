//
//  LoginViewController.h
//  Project
//
//  Created by MAC on 12/07/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "webViewController.h"
@class AppDelegate;
@interface LoginViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>{
    
    UIImageView *logo;
    UITextField *usernameTxt;
    UITextField *passwordTxt;
    UIScrollView *scrollViewer;
    AppDelegate *delObj;
    UILabel *errorLabel;
    
}

@end
