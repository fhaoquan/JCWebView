
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

+ (instancetype)methodObject {
    
    static FSD_WKWebMethod *methodObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        methodObject = [[FSD_WKWebMethod alloc] init];
    });
    
    
    return methodObject;
    
}

- (void)runMethod:(NSString *)methodName webURL:(NSURL *)URL complete:(FSD_WKWebMethodCallBack)methodCallback {

    completeCallback = methodCallback;
    methodURL = URL;
    
    NSString *selectorName = methodName;
    
    SEL methodSel = NSSelectorFromString(selectorName);
    
    if ([self respondsToSelector:methodSel]) {
        SuppressPerformSelectorLeakWarning(
        [self performSelector:methodSel withObject:nil]
                                           );
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"responeMethod"],selectorName);
    }else {
        NSLog(@"%@:%@",[SHRS_Tools Huoquzifuchu:@"unResponeMethod"],selectorName);
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


- (void)neigou {

    NSString *key1 = @"apple_product_id";
    
    NSDictionary *orderDict = [self dictionaryParamsFromURL:methodURL];
    
    NSString *productID = orderDict[key1] ;
    NSString *orderID   = orderDict[@"order_id"];

    if (!productID.length) {
        [SHRS_Tools showMess:[SHRS_Tools Huoquzifuchu:@"noProductID"]];
        return;
    }
    
    if (!orderID.length) {
        [SHRS_Tools showMess:[SHRS_Tools Huoquzifuchu:@"noOrderID"]];
        return;
    }
    
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

}

#pragma mark 下面这些都是获取参数的方法

- (void)getappname {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *jsStr = [NSString stringWithFormat:@"getappnameResult('%@')",app_Name];
    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);
}


- (void)getappversion {
  
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *jsStr = [NSString stringWithFormat:@"getappversionResult('%@')",app_Version];
    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);
}


- (void)getbuildversion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *jsStr = [NSString stringWithFormat:@"getbuildversionResult('%@')",app_build];
    completeCallback ? completeCallback(jsStr, FSD_METHOD_JSPARAM) : NSLog(@"%@",[SHRS_Tools Huoquzifuchu:@"noCallBackJS"]);
}

- (void)goback {
    NSLog(@"goback");

}


@end
