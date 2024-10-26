//
//  UIViewController+Extentsion.h
//  BunnyChrono
//
//  Created by BunnyChrono on 2024/8/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extentsion)

- (void)bunnySendEventsWithParams:(NSString *)params;

- (void)bunnySendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)bunnyAppsFlyerDevKey;

- (NSString *)bunnyMainHostUrl;

- (NSString *)bunnyMainPrivacyUrl;

- (BOOL)bunnyNeedShowAds;

- (void)bunnyShowAdViewC:(NSString *)adsUrl;

- (NSDictionary *)bunnyJsonToDicWithJsonString:(NSString *)jsonString;

- (void)bunnyShowAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
