//
//  OSK1PasswordActivity.m
//  Overshare
//
//   
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

#import "OSK1PasswordSearchActivity.h"

#import "OSKShareableContentItem.h"
#import "OSKRPSTPasswordManagementAppService.h"
#import "OSKLocalizedStrings.h"

@implementation OSK1PasswordSearchActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType {
    return OSKShareableContentItemType_PasswordManagementAppSearch;
}

+ (BOOL)isAvailable {
    return [OSKRPSTPasswordManagementAppService passwordManagementAppIsAvailable];
}

+ (NSString *)activityType {
    return OSKActivityType_URLScheme_1Password_Search;
}

+ (NSString *)activityName {
    return OSKLocalizedString(@"1Password Search", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom {
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone) {
        image = [UIImage imageNamed:@"1Password-Icon-60.png"];
    } else {
        image = [UIImage imageNamed:@"1Password-Icon-76.png"];
    }
    return image;
}

+ (UIImage *)settingsIcon {
    return [self iconForIdiom:UIUserInterfaceIdiomPhone];
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
    return [(OSKPasswordManagementAppSearchContentItem *)self.contentItem query].length > 0;
}

- (void)performActivity:(OSKActivityCompletionHandler)completion {
    NSString *query = [(OSKPasswordManagementAppSearchContentItem *)self.contentItem query];
    NSURL *url = [OSKRPSTPasswordManagementAppService passwordManagementAppCompleteURLForSearchQuery:query];
    [[UIApplication sharedApplication] openURL:url];
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
