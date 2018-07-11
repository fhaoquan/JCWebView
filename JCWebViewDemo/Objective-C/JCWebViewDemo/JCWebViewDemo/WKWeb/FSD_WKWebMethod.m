
#import "FSD_WKWebMethod.h"


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)



static FSD_WKWebMethodCallBack completeCallback = nil;
static NSURL *methodURL = nil;

@implementation FSD_WKWebMethod

//add method on this line-181//

//add method on this line-182//

+ (instancetype)methodObject {
    
    static FSD_WKWebMethod *methodObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        methodObject = [[FSD_WKWebMethod alloc] init];
    });
    
    //Add Garbage Func Here-39//
    
    return methodObject;
    
}

//add method on this line-183//

//add method on this line-184//

//add method on this line-185//


- (void)runMethod:(NSString *)methodName webURL:(NSURL *)URL complete:(FSD_WKWebMethodCallBack)methodCallback {
    
    //Add Garbage Func Here-40//
    
    completeCallback = methodCallback;
    methodURL = URL;
    
    NSString *selectorName = methodName;
    
    SEL methodSel = NSSelectorFromString(selectorName);
    
    if ([self respondsToSelector:methodSel]) {
        //Add Garbage Func Here-41//
        SuppressPerformSelectorLeakWarning(
                                           [self performSelector:methodSel withObject:nil]
                                           );
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"responeMethod"],selectorName);
    }else {
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"unResponeMethod"],selectorName);
        //Add Garbage Func Here-42//
    }
    
}

- (NSDictionary *)dictionaryParamsFromURL:(NSURL *)paramURL {
    
    if (!paramURL) {
        NSLog(@"paramURL is nil");
    }

    
    NSMutableDictionary *tempDict   = [NSMutableDictionary dictionary];
    NSArray *params                 =[paramURL.query componentsSeparatedByString:@"&"];
    
    for (NSString *paramStr in params) {
        NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
        if (dicArray.count > 1) {
            NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [tempDict setObject:decodeValue forKey:dicArray[0]];
        }
    }
    return (NSDictionary *)tempDict;
}

#pragma mark SDK的接口


- (void)login {

}

- (void)logout {
    

}

- (void)createrole {

}

- (void)entergame {

}


- (void)roleuplevel {

}


- (void)neigou {
    
    //Add Garbage Func Here-64//
    
    NSString *key1 = @"apple_product_id";
    
    NSDictionary *orderDict = [self dictionaryParamsFromURL:methodURL];
    
    NSString *productID = orderDict[key1] ;
    NSString *orderID   = orderDict[@"order_id"];
    
    //Add Garbage Func Here-65//
    
    if (!productID.length) {
        [SHRS_Tools showMess:[SHRS_Tools Huoquzifuchu:@"noProductID"]];
        return;
    }
    
    if (!orderID.length) {
        [SHRS_Tools showMess:[SHRS_Tools Huoquzifuchu:@"noOrderID"]];
        return;
    }
    
    
    //Add Garbage Func Here-66//
    
    NSString *tuHaoName     = @"FSD_TuHaoMain";
    NSString *tuHaoMethod   = @"xlhm_youQianYaoMai:OrderId:";
    
    Class tuHaoClass    = NSClassFromString(tuHaoName);
    SEL tuHaoSelector   = NSSelectorFromString(tuHaoMethod);
    
    if ([tuHaoClass respondsToSelector:tuHaoSelector]) {
        void (*func)(id, SEL,id,id) = (void(*)(id,SEL,id,id))[tuHaoClass methodForSelector:tuHaoSelector];
        func(tuHaoClass, tuHaoSelector,productID,orderID);
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"responeMethod"],tuHaoMethod);
    }else {
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"unResponeMethod"],tuHaoMethod);
    }
    
    //Add Garbage Func Here-67//
    
}

//add method on this line-209//

//add method on this line-210//

//add method on this line-211//

//add method on this line-212//

#pragma mark 下面这些都是获取参数的方法
- (void)getpkg {
    
//    NSString *jsStr = [NSString stringWithFormat:@"getpkgResult('%@')",[SHRS_Tools Platform_GetAppConfig].gamePkg];
//    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);

}


- (void)getchannelid {
    
    //Add Garbage Func Here-69//
//
//    NSString *jsStr = [NSString stringWithFormat:@"getchannelidResult('%@')",[FSD_PlatfToolService Platform_GetAppConfig].ad_code];
//    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[FSD_PlatfToolService Huoquzifuchu:@"noCallBackJS"]);
    
    //Add Garbage Func Here-70//
}


//add method on this line-215//

//add method on this line-216//


- (void)getgameid {
    
    //Add Garbage Func Here-71//
    
//    NSString *jsStr = [NSString stringWithFormat:@"getgameidResult('%@')",[FSD_PlatfToolService Platform_GetAppConfig].gameId];
//    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[FSD_PlatfToolService Huoquzifuchu:@"noCallBackJS"]);
//
   //Add Garbage Func Here-72//
}

//add method on this line-217//

//add method on this line-218//

- (void)getsdkpartnerid {
    
    //Add Garbage Func Here-73//
    
//    NSString *jsStr = [NSString stringWithFormat:@"getsdkpartneridResult('%@')",[FSD_PlatfToolService Platform_GetAppConfig].partnerId];
//    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[FSD_PlatfToolService Huoquzifuchu:@"noCallBackJS"]);
//
    //Add Garbage Func Here-74//
}

//add method on this line-219//

//add method on this line-220//

- (void)getappname {
    
    //Add Garbage Func Here-75//
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *jsStr = [NSString stringWithFormat:@"getappnameResult('%@')",app_Name];
    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);
    
    //Add Garbage Func Here-76//
}


- (void)getappversion {
  
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *jsStr = [NSString stringWithFormat:@"getappversionResult('%@')",app_Version];
    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);
    
    //Add Garbage Func Here-78//
}

//add method on this line-222//

//add method on this line-223//

- (void)getbuildversion {
    
    //Add Garbage Func Here-79//
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *jsStr = [NSString stringWithFormat:@"getbuildversionResult('%@')",app_build];
    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);
    
    //Add Garbage Func Here-80//
}

//add method on this line-224//

//add method on this line-225//

//add method on this line-226//

//add method on this line-227//

- (void)goback {
    NSLog(@"goback");
    
    //Add Garbage Func Here-81//
    
//     completeCallback ? completeCallback(nil, FSD_METHOD_GOBACK) : NSLog(@"%@",[FSD_PlatfToolService Huoquzifuchu:@"noCallBackJS"]);
    
    //Add Garbage Func Here-82//
}

//add method on this line-228//

//add method on this line-229//

//add method on this line-230//

@end
