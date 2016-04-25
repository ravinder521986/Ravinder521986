//
//  LoginViewController_ipad.h
//  
//
//  Created by MAC on 23/04/16.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebViewController_ipad.h"
@class AppDelegate;
@interface LoginViewController_ipad : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    UIImageView *logo;
    UITextField *usernameTxt;
    UITextField *passwordTxt;
    UIScrollView *scrollViewer;
    AppDelegate *delObj;
    UILabel *errorLabel;

}
@end
