//
//  BunnyChronoPriPolicyController.h
//  BunnyChrono
//
//  Created by BunnyChrono on 2024/10/26.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Photos/Photos.h>
#import "UIViewController+Extentsion.h"

NS_ASSUME_NONNULL_BEGIN

@interface BunnyChronoPriPolicyController : UIViewController<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate, WKDownloadDelegate>
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
