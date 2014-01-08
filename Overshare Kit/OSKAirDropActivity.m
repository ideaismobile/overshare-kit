//
//  OSKAirDropActivity.m
//  Overshare
//
//  Created by Jared Sinclair on 10/21/13.
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

#import "OSKAirDropActivity.h"

#import "UIDevice+OSKHardware.h"
#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

@interface OSKAirDropActivity ()

@end

@implementation OSKAirDropActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType {
    return OSKShareableContentItemType_AirDrop;
}

+ (BOOL)isAvailable {
    return [[UIDevice currentDevice] osk_airDropIsAvailable];
}

+ (NSString *)activityType {
    return OSKActivityType_iOS_AirDrop;
}

+ (NSString *)activityName {
    return OSKLocalizedString(@"AirDrop", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom {
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone) {
        image = [UIImage imageNamed:@"osk-airDropIcon-60.png"];
    } else {
        image = [UIImage imageNamed:@"osk-airDropIcon-76.png"];
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
    return OSKPublishingViewControllerType_System;
}

- (BOOL)isReadyToPerform {
    return ([self airdropItem].items.count > 0);
}

- (void)performActivity:(OSKActivityCompletionHandler)completion {
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

#pragma mark - Convenience

- (OSKAirDropContentItem *)airdropItem {
    return (OSKAirDropContentItem *)self.contentItem;
}

@end

