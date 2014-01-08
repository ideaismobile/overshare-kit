//
//  OSKSafariActivity.m
//  Overshare
//
//  Created by Jared Sinclair on 10/15/13.
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

#import "OSKSafariActivity.h"

#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

@implementation OSKSafariActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType {
    return OSKShareableContentItemType_WebBrowser;
}

+ (BOOL)isAvailable {
    return YES;
}

+ (NSString *)activityType {
    return OSKActivityType_iOS_Safari;
}

+ (NSString *)activityName {
    return OSKLocalizedString(@"Safari", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom {
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone) {
        image = [UIImage imageNamed:@"osk-safariIcon-60.png"];
    } else {
        image = [UIImage imageNamed:@"osk-safariIcon-76.png"];
    }
    return image;
}

+ (OSKAuthenticationMethod)authenticationMethod {
    return OSKAuthenticationMethod_None;
}

+ (BOOL)requiresApplicationCredential {
    return NO;
}

+ (OSKPublishingViewControllerType)publishingViewControllerType {
    return OSKPublishingViewControllerType_None;
}

- (BOOL)isReadyToPerform {
    return ([[UIApplication sharedApplication] canOpenURL:[self browserItem].url]);
}

- (void)performActivity:(OSKActivityCompletionHandler)completion {
    [[UIApplication sharedApplication] openURL:[self browserItem].url];
    if (completion) {
        completion(self, YES, nil);
    }
}

+ (BOOL)canPerformViaOperation {
    return NO;
}

- (OSKActivityOperation *)operationForActivityWithCompletion:(OSKActivityCompletionHandler)completion {
    return nil;
}

- (OSKWebBrowserContentItem *)browserItem {
    return (OSKWebBrowserContentItem *)self.contentItem;
}

@end





