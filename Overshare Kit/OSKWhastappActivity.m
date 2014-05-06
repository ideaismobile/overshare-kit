//
//  OSKWhastappActivity.m
//  Overshare
//
//  Created by Flávio Caetano on 5/6/14.
//  Copyright (c) 2014 Overshare Kit. All rights reserved.
//

#import "OSKWhastappActivity.h"

#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

static NSString * OSKWhatsappActivity_BaseURL = @"whatsapp://";
static NSString * OSKWhatsappActivity_SendURL = @"send?text=%@";

@implementation OSKWhastappActivity

- (instancetype)initWithContentItem:(OSKShareableContentItem *)item {
    self = [super initWithContentItem:item];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Methods for OSKActivity Subclasses

+ (NSString *)supportedContentItemType
{
    return OSKShareableContentItemType_WebBrowser;
}

+ (BOOL)isAvailable
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:OSKWhatsappActivity_BaseURL]];
}

+ (NSString *)activityType
{
    return OSKActivityType_URLScheme_Whatsapp;
}

+ (NSString *)activityName
{
    return OSKLocalizedString(@"Whatsapp", nil);
}

+ (UIImage *)iconForIdiom:(UIUserInterfaceIdiom)idiom
{
    UIImage *image = nil;
    if (idiom == UIUserInterfaceIdiomPhone)
    {
        image = [UIImage imageNamed:@"whatsapp-60"];
    }
    else
    {
        image = [UIImage imageNamed:@"whatsapp-76"];
    }
    
    return image;
}

+ (UIImage *)settingsIcon
{
    return [self iconForIdiom:UIUserInterfaceIdiomPhone];
}

+ (OSKAuthenticationMethod)authenticationMethod
{
    return OSKAuthenticationMethod_None;
}

+ (BOOL)requiresApplicationCredential
{
    return NO;
}

+ (OSKPublishingViewControllerType)publishingViewControllerType
{
    return OSKPublishingViewControllerType_None;
}

- (BOOL)isReadyToPerform
{
    return [self browserItem].url.absoluteString.length > 0;
}

- (void)performActivity:(OSKActivityCompletionHandler)completion
{
    NSURL *contentURL      = [self browserItem].url;
    NSString *fullQuery    = [NSString stringWithFormat:OSKWhatsappActivity_SendURL, contentURL.absoluteString];
    NSString *encodedQuery = [fullQuery stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL             = [NSURL URLWithString:[OSKWhatsappActivity_BaseURL stringByAppendingString:encodedQuery]];
    
    if (URL)
    {
        [[UIApplication sharedApplication] openURL:URL];
        
        if (completion)
        {
            completion(self, YES, nil);
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:@"OSKWhatsappActivity" code:400 userInfo:@{NSLocalizedFailureReasonErrorKey:@"Invalid URL, unable to send new message to Whatsapp."}];
        if (completion)
        {
            completion(self, NO, error);
        }
    }
}

+ (BOOL)canPerformViaOperation
{
    return NO;
}

- (OSKActivityOperation *)operationForActivityWithCompletion:(OSKActivityCompletionHandler)completion
{
    return nil;
}

#pragma mark - Convenience

- (OSKWebBrowserContentItem *)browserItem
{
    return (OSKWebBrowserContentItem *)self.contentItem;
}

@end
