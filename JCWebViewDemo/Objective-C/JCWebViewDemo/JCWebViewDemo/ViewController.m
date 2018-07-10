//
//  ViewController.m
//  JCWebViewDemo
//
//  Created by 郑嘉成 on 2017/9/28.
//  Copyright © 2017年 zhengjiacheng. All rights reserved.
//

#import "ViewController.h"
#import "JCWebView.h"
#import "SHRS_Tools.h"


@interface ViewController ()<JCWebViewDelegate>
@property (nonatomic, strong) JCWebView *webView;
@end

@implementation ViewController

- (NSDictionary *)publicParameter {
    NSDictionary *sign_dict =@{   @"game_id":@"559",
                               @"game_pkg":@"cqsj_mfby_CE",
                               @"partner_id":@"102",
                               @"build_ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],
                               @"uuid":[SHRS_Tools getIDFAWithTool],
                               @"idfv":[SHRS_Tools getIDFVWithTool],
                               @"mac":[SHRS_Tools getDeviceMACWithTool],
                               @"net_type":[SHRS_Tools getNetTypeWithTool],
                               @"sdk_ver":@"90000.01",
                               @"device":@"2",
                               @"dname":[SHRS_Tools getModelNumWithTool],
                               @"os_ver":[SHRS_Tools getDeviceVersionWithTool],
                               @"game_ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"time":[SHRS_Tools getTimeStampWithTool],
                               @"install":[SHRS_Tools isInstallWithTool],
                               @"netserver":[SHRS_Tools currentLuyouSSID],
                               @"kk_client":@"1"
                               };
    return sign_dict;
}

- (NSString *)signWithParams:(NSDictionary *)paramDict {
    
    NSMutableString *signString = [NSMutableString string];
    
    NSArray *keys = [paramDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    for (NSString *key in keys) {
        if (signString.length == 0) {
            [signString appendFormat:@"%@=%@",key,paramDict[key]];
        }else {
            [signString appendFormat:@"&%@=%@",key,paramDict[key]];
        }
    }
    
    
    //[signString appendString:MD5SignKey];
    NSString * str = @"https://sdk.9187.cn/?";
    NSString * url = [str stringByAppendingString:signString];
    return url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    JCWebView *webView = [[JCWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) forceUseUIWebView:NO];
    [self.view addSubview:webView];
    webView.delegate = self;
//    NSURL *url = [NSURL URLWithString:@"https://sdk.9187.cn/?ad_code=official&and_id=cfd5d6f0bff08fc1&device=1&dname=SM-G9350&game_id=584&game_pkg=zzcq_zzcq_A&game_ver=21&kk_client=1&mac=d8:c4:6a:d4:75:13&net_type=WIFI&onekey=b611431a4b2c831910aae8094b41ec39&os_ver=7.0&partner_id=250&sdk_ver=7.01&sysrom=&time=1531195561833&uuid=351952085475876"];
    NSURL *url = [NSURL URLWithString:[self signWithParams:[self publicParameter]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [webView loadRequest:request];
    self.webView = webView;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
