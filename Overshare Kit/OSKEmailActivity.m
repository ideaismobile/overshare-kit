//
//  OSKEmailActivity.m
//  Overshare
//
//   
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

#import "OSKEmailActivity.h"

@import MessageUI;

#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

@implementation OSKEmailActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType {
    return OSKShareableContentItemType_Email;
}

+ (BOOL)isAvailable {
    return [MFMailComposeViewController canSendMail];
}

+ (NSString *)activityType {
    return OSKActivityType_iOS_Email;
}

+ (NSString *)activityName {
    return OSKLocalizedString(@"Email", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom {
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone) {
        image = [UIImage imageNamed:@"osk-mailIcon-60.png"];
    } else {
        image = [UIImage imageNamed:@"osk-mailIcon-76.png"];
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
    return [(OSKEmailContentItem *)self.contentItem body].length > 0;
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
