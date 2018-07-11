

#import <Foundation/Foundation.h>
#import "SHRS_Tools.h"

typedef NS_ENUM(NSUInteger, FSD_METHOD_CODE) {
    FSD_METHOD_CALLBACK = 300,
    FSD_METHOD_LOGIN,
    FSD_METHOD_LOGOUT,
    FSD_METHOD_CREATE,
    FSD_METHOD_ENTER,
    FSD_METHOD_LEVELUP,
    FSD_METHOD_ORDER,
    FSD_METHOD_JSPARAM,
    FSD_METHOD_GOBACK,
};

typedef void(^FSD_WKWebMethodCallBack)(NSString *callbackJS,FSD_METHOD_CODE methodCode);

@interface FSD_WKWebMethod : NSObject

+ (instancetype)methodObject;

- (void)runMethod:(NSString *)methodName webURL:(NSURL *)URL complete:(FSD_WKWebMethodCallBack)methodCallback;

@end
