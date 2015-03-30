//
//  BLCLoginViewController.m
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-28.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCLoginViewController.h"
#import "BLCDatasource.h"



@interface BLCLoginViewController ()  <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;


@end

@implementation BLCLoginViewController


NSString *const BLCLoginViewControllerDidGetAccessTokenNotification = @"BLCLoginViewControllerDidGetAccessTokenNotification";


-(NSString *)redirectURI {
    return @"http://bloc.io";
}

-(void)loadView  {
    
    UIWebView *webView      = [[UIWebView alloc]init];
    webView.delegate            = self;
    
    self.webView                    = webView;
    self.view                           = webView;
    
 }


- (void)viewDidLoad  {
    
    [super viewDidLoad];
    
    
    NSString *urlString     = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token", [BLCDatasource instagramClientID], [self redirectURI]];
    NSURL *url                  = [NSURL URLWithString:urlString];
    
    if (url) {
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
    }
    
    // Do any additional setup after loading the view.
    // Creating the back button bar item
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(buttonPressed:)];
    bar.title = @"Back";
    [self.navigationItem setLeftBarButtonItem:bar];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];

}



-(void)dealloc {
    
    [self clearInstagramCookies];
    
    self.webView.delegate = nil;
    
}

- (void) clearInstagramCookies {
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        NSRange domainRange = [cookie.domain rangeOfString:@"instagram.com"];
        if(domainRange.location != NSNotFound) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}


- (void) webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.webView canGoBack]) {
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    } else {
        [self.navigationItem.leftBarButtonItem setEnabled:NO];
    }
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    if ([urlString hasPrefix:[self redirectURI]]) {
        // This contains our auth token
        NSRange rangeOfAccessTokenParameter = [urlString rangeOfString:@"access_token="];
        NSUInteger indexOfTokenStarting = rangeOfAccessTokenParameter.location + rangeOfAccessTokenParameter.length;
        NSString *accessToken = [urlString substringFromIndex:indexOfTokenStarting];
        [[NSNotificationCenter defaultCenter] postNotificationName:BLCLoginViewControllerDidGetAccessTokenNotification object:accessToken];
        return NO;
    }
    
    return YES;
}

-(void)buttonPressed: (UIBarButtonItem *)buttonPressed{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    
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
