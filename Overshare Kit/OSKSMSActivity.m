//
//  OSKSMSActivity.m
//  Overshare
//
//   
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

@import MessageUI;

#import "OSKSMSActivity.h"

#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

@implementation OSKSMSActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType {
    return OSKShareableContentItemType_SMS;
}

+ (BOOL)isAvailable {
    return [MFMessageComposeViewController canSendText];
}

+ (NSString *)activityType {
    return OSKActivityType_iOS_SMS;
}

+ (NSString *)activityName {
    return OSKLocalizedString(@"Message", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom {
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone) {
        image = [UIImage imageNamed:@"osk-messagesIcon-60.png"];
    } else {
        image = [UIImage imageNamed:@"osk-messagesIcon-76.png"];
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
    return [(OSKSMSContentItem *)self.contentItem body].length > 0;
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

@end




