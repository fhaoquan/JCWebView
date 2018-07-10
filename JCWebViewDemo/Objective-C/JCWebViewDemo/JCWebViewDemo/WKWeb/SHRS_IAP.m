//
//  SHRS_IAP.m
//  UUUKK
//
//  Created by  on 2018/03/12.
//

#import "SHRS_IAP.h"
#import <StoreKit/StoreKit.h>
@interface SHRS_IAP()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic,copy) NSString * receiptStatus;//获取苹果交易串方式  1原型(服务器需要base)  2非原型(服务器不base)
@end

@implementation SHRS_IAP

+ (instancetype)shardIAP{
    static SHRS_IAP *iapMananger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iapMananger = [[SHRS_IAP alloc]init];
    });
    return iapMananger;
}

/** 下单 */
+ (void)maiProductOnIap:(NSString *)productId andDingdanId:(NSString *)dingdanId{
    //判断用户是否禁用内购功能
    if ([SKPaymentQueue  canMakePayments]){
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:[SHRS_IAP shardIAP]];
        
        [SHRS_IAP shardIAP].orderId = dingdanId;
        [SHRS_IAP shardIAP].productId = productId;
         [SHRS_IAP shardIAP].receiptStatus = @"1";//默认走正常充值流程
        NSSet *s_pid = [NSSet setWithObject:productId];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:s_pid];
        request.delegate = [SHRS_IAP shardIAP];
        [request start];
        [SHRS_ProgressHUD showProgressHudLoading:@"正在获取苹果内购数据..." andView:[SHRS_Tools getRootViewControllerWithTool].view];
    }else{
        [SHRS_ProgressHUD showProgressHudLoading:@"请在\"访问限制\"内开启\n\"App内购买项目\""andView:[SHRS_Tools getRootViewControllerWithTool].view]; //xuyaotianjialajidaimadifang-3144//
    }
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    for (SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchased:{
                NSString *receipt = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
                [SHRS_IAP doSuccessIapReceiptOnIap:receipt tranId:transaction.transactionIdentifier];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [SHRS_IAP deleServerOrderIdOnIap:[SHRS_IAP shardIAP].orderId];
                [self failedTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    [SHRS_ProgressHUD hiddenProgressHud];
    NSString *errorMessage = error.userInfo[@"NSLocalizedDescription"];
    [SHRS_ProgressHUD showProgressHudTitle:errorMessage andView:[SHRS_Tools getRootViewControllerWithTool].view]; //
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    [SHRS_ProgressHUD hiddenProgressHud];
//    NSLog(@"向苹果商店请求订单结果回调");
    if (response.products.count == 0){
        NSArray *produsts = response.invalidProductIdentifiers;
        NSString *productIDs = [produsts componentsJoinedByString:@"\n"];
        NSString *productError = [NSString stringWithFormat:@"没找到内购产品，先去看看你的产品ID是不是正确的吧，瞄这里：\n%@",productIDs];
        [SHRS_ProgressHUD showProgressHudTitle:productError andView:[SHRS_Tools getRootViewControllerWithTool].view];
        return;
    }
    //获取到内购列表
    [SHRS_IAP WriteServerOrderIdOnIap:[SHRS_IAP shardIAP].orderId]; //xuyaotianjialajidaimadifang-3157//
    SKPayment *payment = [SKPayment paymentWithProduct:response.products[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment]; //xuyaotianjialajidaimadifang-3158//
}

- (void)failedTransaction: (SKPaymentTransaction *)transaction{
    NSDictionary *maiDict = [NSDictionary dictionary];
    if(transaction.error.code == SKErrorPaymentCancelled) {
        //  用户取消
        maiDict = @{@"code":@"2",
                    @"message":@"用户取消"};
    }else {
        //在这类显示除用户取消之外的错误信息  交易错误
        maiDict = @{@"code":@"3",
                    @"message":@"交易错误"};
    }
    
//    NSLog(@"交易失败:%@",transaction.error);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_MAISUCCESS object:nil userInfo:maiDict];
}

+ (void)doSuccessIapReceiptOnIap:(NSString *)receipt tranId:(NSString *)tranid{
    if ([SHRS_IAP QueryTranidOnIap:tranid]){
//        NSLog(@"订单已存在,无需再校验");
        return;
    }
//        NSLog(@"苹果交易数据 -- %@",receipt);
    NSDictionary *dict = @{@"order_id":[SHRS_IAP shardIAP].orderId,
                           @"receiptStatus": [SHRS_IAP shardIAP].receiptStatus,
                           @"game_pkg":[SHRS_Configuration shareConfiguration].zzx_gamePkg,
                           @"apple_receipt":receipt
                           };
    [SHRS_NetWorkRequest requestCommonParam:dict andCommonUrl:[SHRS_RequestURL getIapReceiptURL] success:^(NSDictionary *result) {
//        NSLog(@"成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功成功%@",result);
        [SHRS_IAP deleServerOrderIdOnIap:[SHRS_IAP shardIAP].orderId];
        NSDictionary *maiDict = [NSDictionary dictionary];
        float amount = 0.00;
        if ([[result objectForKey:@"amount"] floatValue] != 0.){
                amount = [[result objectForKey:@"amount"] floatValue];
        }
        [SHRS_IAP WriteTranIdOnIap:tranid];
        maiDict = @{@"code":@"0",
                @"message":@"交易成功"};
            
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_MAISUCCESS object:nil userInfo:maiDict];
    } fail:^(NSDictionary *result) {
        NSDictionary *maiDict = [NSDictionary dictionary];
        maiDict = @{@"code":@"1",
                    @"message":@"订单校验失败"};
         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_MAISUCCESS object:nil userInfo:maiDict];
    } error:^(NSError *error) {
        
    }];

}

#pragma mark - 补单
#define ITMS_SANDBOX_VERIFY_RECEIPT_URL @"https://sandbox.itunes.apple.com/verifyReceipt"
#define ITMS_VERIFY_RECEIPT_URL @"https://buy.itunes.apple.com/verifyReceipt"
+ (void)appStoreReceiptOnIap:(NSString *)orderId{
    [SHRS_IAP shardIAP].orderId = orderId;
    NSLog(@"%@",orderId);
    NSURL *a_url = [[NSBundle mainBundle] appStoreReceiptURL];
    if (a_url == nil){
        [SHRS_IAP deleServerOrderIdOnIap:[SHRS_IAP shardIAP].orderId];
        return;
    }
    NSData *a_receipt = [NSData dataWithContentsOfURL:a_url];
    if (a_receipt == nil){
        [SHRS_IAP deleServerOrderIdOnIap:[SHRS_IAP shardIAP].orderId];
        return;
    }
    NSString *str_receipt = [a_receipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    NSLog(@"获取苹果沙盒交易数据 -- %@",str_receipt);
    if (str_receipt == nil || [str_receipt isEqualToString:@""]){
        return;
    }
    [SHRS_NetWorkRequest requestIAPParam:@{@"receipt-data":str_receipt} andCommonUrl:ITMS_VERIFY_RECEIPT_URL success:^(NSDictionary *result) {
        [SHRS_IAP fillOnIap:result receipt:str_receipt];
    } fail:^(NSDictionary *result) {
        
    } error:^(NSError *error) {
        
    }];
}

+ (void)fillOnIap:(NSDictionary *)receiptDict receipt:(NSString *)str_receipt{
    if ([receiptDict count] == 0){
        [SHRS_IAP deleServerOrderIdOnIap: [SHRS_IAP shardIAP].orderId];
        return;
    }
    int iap_result = -1;
    iap_result = [[receiptDict objectForKey:@"status"] intValue];
    switch (iap_result){
        case 0:{//正常结果
            NSArray *in_app = [[receiptDict objectForKey:@"receipt"] objectForKey:@"in_app"];
            if (in_app == nil || in_app.count == 0){
                [SHRS_IAP deleServerOrderIdOnIap: [SHRS_IAP shardIAP].orderId];
                return;
            }
            NSDictionary *in_dict = in_app[0];
            NSString *tranid = [in_dict objectForKey:@"transaction_id"];
            if ([SHRS_IAP QueryTranidOnIap:tranid]){
//                NSLog(@"订单已存在,请重新下单");
                [SHRS_IAP deleServerOrderIdOnIap: [SHRS_IAP shardIAP].orderId];
                return;
            }
            [SHRS_IAP shardIAP].receiptStatus = @"2";
            [SHRS_IAP doSuccessIapReceiptOnIap:str_receipt tranId:tranid];
            
        }
            break;
        case 21007:{//交易收据是sanbox
            NSDictionary *sanbox_dict = [SHRS_IAP appStore_postOnIap:ITMS_SANDBOX_VERIFY_RECEIPT_URL receipt:str_receipt];
            [SHRS_IAP fillOnIap:sanbox_dict receipt:str_receipt];
        }
            break;
    }
}
//tianjialajifangfa-847//
+ (NSDictionary *)appStore_postOnIap:(NSString *)url receipt:(NSString *)str_receipt{
    NSString *mmmload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", str_receipt];
    NSData *mmmmloadData = [mmmload dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.];
    request.HTTPMethod = @"POST";
    request.HTTPBody = mmmmloadData;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; //xuyaotianjialajidaimadifang-3189//
    if (result == nil){
//        NSLog(@"验证失败");
        return nil;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"获取苹果收据 ：%@",dict);
    return dict;
}

#pragma mark - 订单数据操作
//苹果交易数据库路径，存储交易相关信息
+ (NSString *)ServerPathIap{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"GZSERVERID.plist"];
//    NSLog(@"服务器订单id存放地址 %@",path);
    return path;
}

+ (NSString *)TranPathIap{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"GZTRANID.plist"];
//    NSLog(@"苹果产品id存放地址 %@",path);
    return path;
}

+ (NSArray *)ReadServerOrderIdsIap{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP ServerPathIap]];
//    NSLog(@"读取本地订单  --  %@",array);
    return array;
}

+ (NSArray *)ReadTranIDsIap{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP TranPathIap]];
//    NSLog(@"读取本地苹果订单  --  %@",array);
    return array;
}

+ (void)WriteServerOrderIdOnIap:(NSString *)orderId{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP ServerPathIap]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    for (NSString *string in result){
        if ([string isEqualToString:orderId]){
//            NSLog(@"orderId 已存在 %@",result);
            return;
        }
    }
    [result insertObject:orderId atIndex:0];
    if ([result count] == 4){
        [result removeLastObject];
    }
    BOOL bl = [result writeToFile:[SHRS_IAP ServerPathIap] atomically:YES];
    if (bl){
//        NSLog(@"成功写入order %@",result);
    }
}

+ (void)WriteTranIdOnIap:(NSString *)tranId{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP TranPathIap]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    for (NSString *string in array){
        if ([string isEqualToString:tranId]){
//            NSLog(@"tranid 已存在 %@",result);
            return;
        }
    }
    [result insertObject:tranId atIndex:0];
    if ([result count]>10){
        [result removeLastObject];
    }
    BOOL bl = [result writeToFile:[SHRS_IAP TranPathIap] atomically:YES];
    if (bl){
//        NSLog(@"成功写入tran %@",result);
    }
}

+ (void)deleServerOrderIdOnIap:(NSString *)orderId{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP ServerPathIap]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    [result removeObject:orderId];
    BOOL bl = [result writeToFile:[SHRS_IAP ServerPathIap] atomically:YES];
    if (bl){
//        NSLog(@"成功删除order %@",result);
    }
}

+ (BOOL)QueryTranidOnIap:(NSString *)tranId{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP TranPathIap]];
    for (NSString *string in array){
        if ([string isEqualToString:tranId]){
            return YES;
        }
    }
    return NO;
}

+ (void)deleTranIdOnIap:(NSString *)tranId{
    NSArray *array = [NSArray arrayWithContentsOfFile:[SHRS_IAP TranPathIap]];
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    [result removeObject:tranId];
    BOOL bl = [result writeToFile:[SHRS_IAP TranPathIap] atomically:YES];
    if (bl){
//        NSLog(@"成功删除tran %@",result);
    }
}

@end
