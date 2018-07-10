
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^IsNotAllowBlock)(BOOL isNotAllowBlock);
@interface SHRS_Tools : NSObject
/** iPad6,8 */
+ (NSString *)getModelNumWithTool;
/** iPhone 4 */
+ (NSString *)getModelStringWithTool;
/** idfa */
+ (NSString *)getIDFAWithTool;
/** idfv */
+ (NSString *)getIDFVWithTool;
/** mac地址 */
+ (NSString *)getDeviceMACWithTool;
/** 网络状态 */
+ (NSString *)getNetTypeWithTool;
/** 系统版本  9.1 */
+ (NSString *)getDeviceVersionWithTool;
/** 时间戳 */
+ (NSString *)getTimeStampWithTool;
/** 获得窗口最上层的控制器*/
+ (UIViewController *)getShowViewControllerWithTool;
/** 获取根视图控制器 */
+ (UIViewController *)getRootViewControllerWithTool;
/** app名字  */
+ (NSString *)getAPPNameWithTool;
/** 9.1 */
+ (NSString *)getDeviceVersionNumWithTool;

/** 设备总内存 */
+ (int64_t)getTotalMemoryWithTool;
/** 设备空余内存 */
+ (int64_t)getFreeMemoryWithTool;
/** 计算文字长度 */
+ (CGSize)getTextSizeWithTool:(NSString *)text withWidth:(CGFloat) width;

+ (UIImage *) imageWithAlpheWithTool:(CGFloat)alphe;
/** 判断是不是小于6大于12  是的话就是违反了规则 */
+ (BOOL)isWrongRegulationPassWordWithTool:(NSString *)passWord;
+ (BOOL)isIphoneXWithTool;
+ (BOOL)isLandscapeLeftWithTool;
+ (BOOL)isLandscapeRightWithTool;



/** 展示alert提示 */
+ (void)showAlertWithTitleWithTool:(NSString *)title;
/** 是不是横屏 */
+ (BOOL)isLandscapeScreenWithTool;
+ (BOOL)isIpadWithTool;
/** 判断是不是代理 */
+ (BOOL)isNotUseProxyWithTool;

+ (NSString *)isInstallWithTool;
+ (void)setInstallWithTool;
/**  1是竖屏   2   是横屏 */
+ (NSString *)getScreenOrientationStringWithTool;
/** 通过host获取ip地址，包括ipv4和ipv6地址 */
+ (NSString *)getIpAddressByHostName:(NSString *)host;
//+ (NSString *)jiemazifuchuan:(NSString *)string;
+ (UIImage *)decodeBase64ToImage:(NSString *)imgSrc;
+ (UIColor *)colorFromHexValue:(NSUInteger)hexValue;
//埋点
///** 开始的时间 */
//+ (void)dj_startTimeData:(NSString *)keyString;
///** 获取间隔时间 */
//+ (double)dj_getSecondTimeNumber:(NSString *)keyString;
+(NSString*)HuoquImg64zifuchu:(NSString*) zifuch;
+(NSString*)Huoquzifuchu:(NSString*) zifuch;

+ (NSString *)currentLuyouSSID;
+ (NSString *)getCompareDate;

@end
