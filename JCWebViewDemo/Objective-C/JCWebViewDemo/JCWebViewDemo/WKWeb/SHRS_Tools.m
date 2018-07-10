//
//  SHRS_Tools.m
//  UUUKK
//
//  Created by JOJO on 2018/03/12.
//

#import "SHRS_Tools.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "sys/utsname.h"
#include <mach/mach.h>
#import <AdSupport/AdSupport.h>

#include <netdb.h>

#import<SystemConfiguration/CaptiveNetwork.h>
#import<SystemConfiguration/SystemConfiguration.h>
#import<CoreFoundation/CoreFoundation.h>

#define USERDEFAULTS_INSTALL    @"USERDEFAULTS_INSTALL"

@implementation SHRS_Tools
//tianjialajifangfa-863//
/** iPad6,8 */
+ (NSString *)getModelNumWithTool{
    struct utsname systemInfo;  //xuyaotianjialajidaimadifang-3273//
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]; //xuyaotianjialajidaimadifang-3274//
    return deviceString;
}
//tianjialajifangfa-864//
/** iPhone 4 */
+ (NSString *)getModelStringWithTool{
    struct utsname systemInfo;  //xuyaotianjialajidaimadifang-3275//
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]; //xuyaotianjialajidaimadifang-3276//
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4"; //xuyaotianjialajidaimadifang-3277//
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S"; //xuyaotianjialajidaimadifang-3278//
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)"; //xuyaotianjialajidaimadifang-3279//
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)"; //xuyaotianjialajidaimadifang-3280//
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus"; //xuyaotianjialajidaimadifang-3281//
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s"; //xuyaotianjialajidaimadifang-3282//
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE"; //xuyaotianjialajidaimadifang-3283//
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus"; //xuyaotianjialajidaimadifang-3284//
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus"; //xuyaotianjialajidaimadifang-3285//
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8"; //xuyaotianjialajidaimadifang-3286//
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus"; //xuyaotianjialajidaimadifang-3287//
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X"; //xuyaotianjialajidaimadifang-3288//
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod"; //xuyaotianjialajidaimadifang-3289//
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod"; //xuyaotianjialajidaimadifang-3290//
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod"; //xuyaotianjialajidaimadifang-3291//
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"oldiPad"; //xuyaotianjialajidaimadifang-3292//
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"oldiPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"oldiPad"; //xuyaotianjialajidaimadifang-3293//
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"oldiPad";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"oldiPad"; //xuyaotianjialajidaimadifang-3294//
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"oldiPad";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"oldiPad"; //xuyaotianjialajidaimadifang-3295//
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"oldiPad";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"oldiPad"; //xuyaotianjialajidaimadifang-3296//
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)"; //xuyaotianjialajidaimadifang-3297//
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)"; //xuyaotianjialajidaimadifang-3298//
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)"; //xuyaotianjialajidaimadifang-3299//
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)"; //xuyaotianjialajidaimadifang-3300//
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2"; //xuyaotianjialajidaimadifang-3301//
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3"; //xuyaotianjialajidaimadifang-3302//
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)"; //xuyaotianjialajidaimadifang-3303//
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2"; //xuyaotianjialajidaimadifang-3304//
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7"; //xuyaotianjialajidaimadifang-3305//
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9"; //xuyaotianjialajidaimadifang-3306//
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)"; //xuyaotianjialajidaimadifang-3307//
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)"; //xuyaotianjialajidaimadifang-3308//
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)"; //xuyaotianjialajidaimadifang-3309//
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2"; //xuyaotianjialajidaimadifang-3310//
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3"; //xuyaotianjialajidaimadifang-3311//
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator"; //xuyaotianjialajidaimadifang-3312//
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

//tianjialajifangfa-866//
+ (NSString *)arcStringWithTool{
    NSString *string = [[NSString alloc]init]; //xuyaotianjialajidaimadifang-3316//
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36; //xuyaotianjialajidaimadifang-3317//
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure]; //xuyaotianjialajidaimadifang-3318//
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character]; //xuyaotianjialajidaimadifang-3319//
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+ (NSString *)getIDFAWithTool{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getIDFVWithTool{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)getDeviceMACWithTool{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {

        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
//    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}
//tianjialajifangfa-870//
+ (NSString *)getNetTypeWithTool{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = nil;
    
    if ([[app valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        //iPhone X
        children = [[[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }else {
        children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue]; 
            
            switch (netType)
            {
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                {
                    state = @"other";
                }
                    break;
            }
        }
    }
    return state;
}
//tianjialajifangfa-871//
+ (NSString *)getDeviceVersionWithTool{
    return [@"IOS" stringByAppendingString:[UIDevice currentDevice].systemVersion]; //xuyaotianjialajidaimadifang-3343//
}
//tianjialajifangfa-872//
+ (NSString *)getDeviceVersionNumWithTool{
    return [UIDevice currentDevice].systemVersion; //xuyaotianjialajidaimadifang-3344//
}
//tianjialajifangfa-873//
+ (NSString *)getTimeStampWithTool{
    //获取当地时间
    NSDate *date       = [NSDate date]; //xuyaotianjialajidaimadifang-3345//
    NSTimeZone *zone   = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date]; //xuyaotianjialajidaimadifang-3346//
    NSDate *locaDate   = [date dateByAddingTimeInterval:interval];
    NSString *timeSp   = [NSString stringWithFormat:@"%ld",(long)[locaDate timeIntervalSince1970]]; //xuyaotianjialajidaimadifang-3347//
    return timeSp;
}
//tianjialajifangfa-874//
+ (UIViewController *)getShowViewControllerWithTool{
    
    UIViewController* activityViewController = nil; //xuyaotianjialajidaimadifang-3348//
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows]; //xuyaotianjialajidaimadifang-3349//
        for(UIWindow *tmpWin in windows){
            if(tmpWin.windowLevel == UIWindowLevelNormal){ //xuyaotianjialajidaimadifang-3350//
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews]; //xuyaotianjialajidaimadifang-3351//
    if([viewsArray count] > 0){
        UIView *frontView = [viewsArray objectAtIndex:0]; //xuyaotianjialajidaimadifang-3352//
        for (UIView *view in viewsArray) {
            if ([view isKindOfClass:NSClassFromString(@"UITransitionView")]) { //xuyaotianjialajidaimadifang-3353//
                frontView = view.subviews[0];
            }
        }
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]){ //xuyaotianjialajidaimadifang-3354//
            activityViewController = nextResponder;
        }else{
            activityViewController = window.rootViewController; //xuyaotianjialajidaimadifang-3355//
        }
    }

    return activityViewController;
}
//tianjialajifangfa-875//
+ (UIViewController *)getRootViewControllerWithTool{
    UIViewController *rootViewController = nil; //xuyaotianjialajidaimadifang-3356//
    rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController]; //xuyaotianjialajidaimadifang-3357//
    return rootViewController;
}
//tianjialajifangfa-876//
+ (NSString *)getAPPNameWithTool{
    NSString *infoPlist = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]; //xuyaotianjialajidaimadifang-3358//
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:infoPlist]; //xuyaotianjialajidaimadifang-3359//
    return  plistDict[@"CFBundleDisplayName"];
}

//tianjialajifangfa-878//
+ (int64_t)getTotalMemoryWithTool {
    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory]; //xuyaotianjialajidaimadifang-3361//
    if (totalMemory < -1) totalMemory = -1; //xuyaotianjialajidaimadifang-3362//
    return totalMemory;
}
//tianjialajifangfa-879//
+ (int64_t)getFreeMemoryWithTool {
    mach_port_t host_port = mach_host_self(); //xuyaotianjialajidaimadifang-3363//
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t); //xuyaotianjialajidaimadifang-3364//
    vm_size_t page_size; //xuyaotianjialajidaimadifang-3365//
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size); //xuyaotianjialajidaimadifang-3366//
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size); //xuyaotianjialajidaimadifang-3367//
    if (kern != KERN_SUCCESS) return -1; //xuyaotianjialajidaimadifang-3368//
    return vm_stat.free_count * page_size;
}
//tianjialajifangfa-880//
+ (CGSize)getTextSizeWithTool:(NSString *)text withWidth:(CGFloat) width {
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size; //xuyaotianjialajidaimadifang-3369//
    
    return textSize;
}

+ (UIImage *) imageWithAlpheWithTool:(CGFloat)alphe {
    CGRect  frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44); //xuyaotianjialajidaimadifang-3376//
    UIColor *redColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:alphe];
    UIGraphicsBeginImageContext(frame.size); //xuyaotianjialajidaimadifang-3377//
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [redColor CGColor]); //xuyaotianjialajidaimadifang-3378//
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext(); //xuyaotianjialajidaimadifang-3379//
    UIGraphicsEndImageContext();
    return theImage;
}
//tianjialajifangfa-883//
+ (BOOL)isWrongRegulationPassWordWithTool:(NSString *)passWord{
    if ([passWord isEqualToString:@""] || passWord == nil) { //xuyaotianjialajidaimadifang-3380//
        return YES;
    }
    if (passWord.length < 6 || passWord.length >12) { //xuyaotianjialajidaimadifang-3381//
        return YES;
    }else{
        return NO;
    }
}
//tianjialajifangfa-884//
+ (BOOL)isLandscapeLeftWithTool{
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation; //xuyaotianjialajidaimadifang-3382//
    if (orientation == UIInterfaceOrientationLandscapeLeft) {  //xuyaotianjialajidaimadifang-3383//
        return YES;
    }else{
        return NO;
    }
}
//tianjialajifangfa-885//
+ (BOOL)isLandscapeRightWithTool{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation; //xuyaotianjialajidaimadifang-3384//
    if (orientation == UIInterfaceOrientationLandscapeRight) { //xuyaotianjialajidaimadifang-3385//
        return YES;
    }else{
        return NO;
    }
}
//tianjialajifangfa-886//
+ (BOOL)isLandscapeScreenWithTool{
    if ([SHRS_Tools isLandscapeLeftWithTool] || [SHRS_Tools isLandscapeRightWithTool]) { //xuyaotianjialajidaimadifang-3386//
        return YES;
    }else{
        return NO;
    }
}
//tianjialajifangfa-887//
+ (NSString *)getScreenOrientationStringWithTool{
    if ([SHRS_Tools isLandscapeScreenWithTool]) { //xuyaotianjialajidaimadifang-3387//
        return @"2";
    }else{
        return @"1";
    }
}
//tianjialajifangfa-888//
+ (BOOL)isIphoneXWithTool{
    struct utsname systemInfo;  //xuyaotianjialajidaimadifang-3388//
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]; //xuyaotianjialajidaimadifang-3389//
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"]) {
        return YES;
    }else{
        return NO;
    }
}


//tianjialajifangfa-891//
+ (NSString *)getDateStringWithTool{
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init]; //xuyaotianjialajidaimadifang-3401//
    stampFormatter.dateFormat = @"YYYY-MM-dd";
    NSString *nowString = [stampFormatter stringFromDate:[NSDate date]]; //xuyaotianjialajidaimadifang-3402//
    return nowString;
}


//tianjialajifangfa-894//
+ (void)showAlertWithTitleWithTool:(NSString *)title{ //xuyaotianjialajidaimadifang-3409//
    [[[UIAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}
//tianjialajifangfa-895//
+ (BOOL)isIpadWithTool{
    NSString *deviceType = [UIDevice currentDevice].model; //xuyaotianjialajidaimadifang-3410//
    if([deviceType isEqualToString:@"iPad"]){// ipad
        return YES;
    }else{
        return NO;
    }
}
//tianjialajifangfa-896//
+ (BOOL)isNotUseProxyWithTool{
    CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings(); //xuyaotianjialajidaimadifang-3411//
    const CFStringRef proxyCFstr = (const CFStringRef)CFDictionaryGetValue(dicRef, (const void*)kCFNetworkProxiesHTTPProxy); //xuyaotianjialajidaimadifang-3412//
    NSString* proxy = (__bridge NSString *)proxyCFstr; //xuyaotianjialajidaimadifang-3413//
    if (proxy) {
        return NO;
    } else {
        return YES;
    }
}

+ (void)setInstallWithTool{
    //保存已经成功初次激活
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; //xuyaotianjialajidaimadifang-3418//
    [userDefaults setObject:@"0" forKey:USERDEFAULTS_INSTALL];
    [userDefaults setObject:@"0" forKey:@"install"]; //xuyaotianjialajidaimadifang-3419//
    [userDefaults synchronize];
}
//tianjialajifangfa-899//
+ (NSString*)isInstallWithTool{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; //xuyaotianjialajidaimadifang-3420//
    //旧版存储字段
    NSString* install1 = [userDefaults objectForKey:@"install"] == nil ? @"1" : [userDefaults objectForKey:@"install"]; //xuyaotianjialajidaimadifang-3421//
    //新版存储字段
    NSString* install2 = [userDefaults objectForKey:USERDEFAULTS_INSTALL] == nil ? @"1" : [userDefaults objectForKey:USERDEFAULTS_INSTALL]; //xuyaotianjialajidaimadifang-3422//
    
    if(([install1 isEqualToString:@"0"]) || ([install2 isEqualToString:@"0"])){ //xuyaotianjialajidaimadifang-3423//
        return @"0";
    }else {
        return @"1";
    }
}
//tianjialajifangfa-900//
#pragma mark - 获取ip地址，包含ipv4和ipv6地址
+ (struct hostent *)getHostByNameWithTool: (const char *)hostName {
    __block struct hostent * phost = NULL; //xuyaotianjialajidaimadifang-3424//
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSOperationQueue * queue = [NSOperationQueue new]; //xuyaotianjialajidaimadifang-3425//
    [queue addOperationWithBlock: ^{
        phost = gethostbyname(hostName);
        dispatch_semaphore_signal(semaphore);
    }]; //xuyaotianjialajidaimadifang-3426//
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC)); //xuyaotianjialajidaimadifang-3427//
    [queue cancelAllOperations]; //xuyaotianjialajidaimadifang-3428//
    return phost;
}

+ (NSString *)getIpv4AddressFromHost: (NSString *)host {
    const char * hostName = host.UTF8String; //xuyaotianjialajidaimadifang-3429//
    struct hostent * phost = [self getHostByNameWithTool: hostName];
    if ( phost == NULL ) { return nil; }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, phost->h_addr_list[0], 4); //xuyaotianjialajidaimadifang-3430//
    
    char ip[20] = { 0 };
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    return [NSString stringWithUTF8String: ip];
}

+ (NSString *)getIpv6AddressFromHost: (NSString *)host {
    const char * hostName = host.UTF8String;
    struct hostent * phost = [self getHostByNameWithTool: hostName];
    if ( phost == NULL ) { return nil; }
    
    char ip[32] = { 0 };
    char ** aliases;
    switch (phost->h_addrtype) {
        case AF_INET:
        case AF_INET6: {

            for (aliases = phost->h_addr_list; *aliases != NULL; aliases++) {
                NSString * ipAddress = [NSString stringWithUTF8String: inet_ntop(phost->h_addrtype, *aliases, ip, sizeof(ip))];
                if (ipAddress) { return ipAddress; }
            }
        } break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *)getIpAddressByHostName: (NSString *)host {
    NSString * ipAddress = [self getIpv4AddressFromHost: host];
    if (ipAddress == nil) {
        ipAddress = [self getIpv6AddressFromHost: host];
    }
    return ipAddress;
}

+ (NSString *)jiemazifuchuan:(NSString *)string {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];  //xuyaotianjialajidaimadifang-3437//
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (UIImage *)decodeBase64ToImage:(NSString *)imgSrc {
    NSURL *url = [NSURL URLWithString: imgSrc];  //xuyaotianjialajidaimadifang-3438//
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: data]; //xuyaotianjialajidaimadifang-3439//
    return image;
}

+ (UIColor *)colorFromHexValue:(NSUInteger)hexValue { //xuyaotianjialajidaimadifang-3440//
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0f];
}


static NSDictionary* zifuchplist;
static NSDictionary* zifuchpImglist;

#define StringWithData(data) [[NSString alloc] initWithData:(data) encoding:NSUTF8StringEncoding]
#define DataWithString(str) [(str) dataUsingEncoding:NSUTF8StringEncoding]

+ (NSData*) encContent:(NSData*)cont Key:(NSString*) key{
    NSString *str2 = [StringWithData(cont) substringToIndex:38]; //xuyaotianjialajidaimadifang-3441//
    if ([str2 containsString:@"xml"]) {
        return cont;
    } else {
        NSData *data = [self encodeData:cont withKey:key]; //xuyaotianjialajidaimadifang-3442//
        return data;
    }
    
}
//tianjialajifangfa-910//
+ (NSData *)encodeData:(NSData *)sourceData withKey:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding]; //xuyaotianjialajidaimadifang-3443//
    Byte *keyBytes = (Byte *)[keyData bytes];   //取关键字的Byte数组, keyBytes一直指向头部
    Byte *sourceDataPoint = (Byte *)[sourceData bytes];  //取需要加密的数据的Byte数组
    
    //xuyaotianjialajidaimadifang-3444//
    for(unsigned long i =0, j =0;i < [sourceData length]; ++i){
        sourceDataPoint[i]=sourceDataPoint[i]^keyBytes[j];
        j=(j+i)%([keyData length]);
    }
    //xuyaotianjialajidaimadifang-3445//
    
    return sourceData;
}
//tianjialajifangfa-911//
+(void) initzifuch{
    NSString *Key = @"key123erwer";
    NSString *strfile = @"confzifuch";  //xuyaotianjialajidaimadifang-3446//
    NSString *img64 = @"confimg64";
    NSString *zifuchExt = @"txt";  //xuyaotianjialajidaimadifang-3447//
    NSString *plat_Path = [[NSBundle mainBundle] pathForResource:strfile ofType:zifuchExt];  //xuyaotianjialajidaimadifang-3448//
    NSString *error;
    NSPropertyListFormat format;
    if(plat_Path!=nil){
        NSData *data1 = [[NSData alloc]initWithContentsOfFile:plat_Path];  //xuyaotianjialajidaimadifang-3449//
        NSData* cont2 = [self encContent:data1 Key:Key];
        NSString * str = StringWithData(cont2);  //xuyaotianjialajidaimadifang-3450//
        zifuchplist = [NSPropertyListSerialization propertyListFromData:cont2 mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];  //xuyaotianjialajidaimadifang-3451//
//        NSLog( @"plist is %@", zifuchplist );
        if(!zifuchplist){
            NSLog(@"Error: %@",error);
        }
    }
    
    NSString *Imgplat_Path = [[NSBundle mainBundle] pathForResource:img64 ofType:zifuchExt];  //xuyaotianjialajidaimadifang-3452//
    if(Imgplat_Path!=nil){
        NSData *Imgdata = [[NSData alloc]initWithContentsOfFile:Imgplat_Path];  //xuyaotianjialajidaimadifang-3453//
        NSData* Imgcont = [self encContent:Imgdata Key:Key];
        zifuchpImglist = [NSPropertyListSerialization propertyListFromData:Imgcont mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];  //xuyaotianjialajidaimadifang-3454//
//        NSLog( @"plist is %@", zifuchpImglist );
        if(!zifuchplist){
            NSLog(@"Error: %@",error);
        }
    }
}
//tianjialajifangfa-912//
+(NSString*)Huoquzifuchu:(NSString*) zifuch {
    if(zifuchplist==nil){  //xuyaotianjialajidaimadifang-3455//
        [self initzifuch];
    }
    if(zifuchplist!=nil){
        NSString* zifu= [zifuchplist objectForKey:zifuch];  //xuyaotianjialajidaimadifang-3456//
        if(zifu ==nil ){
            NSLog(@"Not Found key: %@",zifuch);
        }
        return zifu !=nil ? zifu : @"";
    }
    return @"";
}
//tianjialajifangfa-913//
+(NSString*)HuoquImg64zifuchu:(NSString*) zifuch {
    
    if(zifuchplist==nil){
        [self initzifuch];  //xuyaotianjialajidaimadifang-3457//
    }
    
    if(zifuchpImglist!=nil){
        NSString* zifu= [zifuchpImglist objectForKey:zifuch];  //xuyaotianjialajidaimadifang-3458//
        return zifu !=nil ? zifu : @"";
    }
    
    return @"";
}
//tianjialajifangfa-914//

+ (NSString *)currentLuyouSSID {
    NSString *wifiName = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
    }
    return wifiName;
}

+ (NSString *)getCompareDate {
    NSString *comparisonResult = @"";
    //首先创建格式化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //然后创建日期对象
    NSDate *pastDate = [dateFormatter dateFromString:[SHRS_Tools Huoquzifuchu:@"BiTianDeDabaoriqi"]]; //此处填写打包的日期
    NSDate *nowDate = [NSDate date];
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [nowDate timeIntervalSinceDate:pastDate];
    //计算天数
    int days = ((int)time)/(3600*24);
    if (days <= 15) {
        comparisonResult = @"1";
    }else {
        comparisonResult = @"2";
    }
    return comparisonResult;
}

@end
