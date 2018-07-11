

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface FSD_TuHaoMain : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

+(void)xlhm_youQianYaoMai:(NSString *)pid OrderId:(NSString *)orderId;

+(void)xlhm_checkTheReceipt:(NSString *)orderId;
@end
