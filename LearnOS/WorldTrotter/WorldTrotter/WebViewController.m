//
//  WebViewController.m
//  WorldTrotter
//
//  Created by 王籽涵 on 2020/7/2.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property(nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (void)loadView {
    self.webView = [[WKWebView alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    if (self.webView.title == nil) {
        [self.webView reload];
        NSLog(@"loading web...");
    }
    NSLog(@"web loaded.");
    
    self.view = self.webView;
//    [self.view addSubview:self.webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"WebViewController has loaded its view.");
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
