//
//  WebViewController_ipad.m
//  
//
//  Created by MAC on 23/04/16.
//
//

#import "WebViewController_ipad.h"

@interface WebViewController_ipad ()

@end

@implementation WebViewController_ipad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    delObj=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [delObj showView];
    
    
    UIImageView *backgroundImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundImage.image=[UIImage imageNamed:@"background@2x.png"];
    backgroundImage.userInteractionEnabled=YES;
    [self.view addSubview:backgroundImage];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Logout" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width-100, 15, 100.0, 40.0);
    [self.view addSubview:button];
    

    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width  ,self.view.frame.size.height-64)];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]valueForKey:@"redirect_to"]]];
    [req addValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"token"] forHTTPHeaderField:@"X-AUTH-TOKEN"];
    [req addValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] forHTTPHeaderField:@"X-USER-EMAIL"];
    [webview loadRequest:req];
    webview.delegate=self;
    [self.view addSubview:webview];
    
    

    
}
-(void)aMethod:(id)sender{
    
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [delObj hideView];

    
   // NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                    //  @"document.body.innerHTML"];
    
    
  //  NSLog(@"html-----%@",html);
    
  //  NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
   // NSLog(@"%@",[(NSHTTPURLResponse*)resp.response allHeaderFields]);
  //
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [delObj hideView];

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
