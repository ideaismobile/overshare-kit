//
//  OSKCopyToPasteboardActivity.m
//  Overshare
//
//   
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

#import "OSKCopyToPasteboardActivity.h"

#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

@interface OSKCopyToPasteboardActivity ()

@property (strong, nonatomic, readonly) OSKCopyToPasteboardContentItem *pasteboardItem;

@end

@implementation OSKCopyToPasteboardActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType {
    return OSKShareableContentItemType_CopyToPasteboard;
}

+ (BOOL)isAvailable {
    return YES;
}

+ (NSString *)activityType {
    return OSKActivityType_iOS_CopyToPasteboard;
}

+ (NSString *)activityName {
    return OSKLocalizedString(@"Copy", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom {
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone) {
        image = [UIImage imageNamed:@"osk-copyIcon-yellow-60.png"];
    } else {
        image = [UIImage imageNamed:@"osk-copyIcon-yellow-76.png"];
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
    return self.pasteboardItem.text.length > 0;
}

- (void)performActivity:(OSKActivityCompletionHandler)completion {
    [[UIPasteboard generalPasteboard] setString:self.pasteboardItem.text];
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

- (OSKCopyToPasteboardContentItem *)pasteboardItem {
    return (OSKCopyToPasteboardContentItem *)self.contentItem;
}

@end






