//
//  OSKShareableContent.m
//  Overshare
//
//   
//  Copyright (c) 2013 Overshare Kit. All rights reserved.
//

#import "OSKShareableContent.h"

#import "OSKShareableContentItem.h"
#import "OSKLocalizedStrings.h"

@implementation OSKShareableContent

+ (instancetype)contentFromText:(NSString *)text {
    NSParameterAssert(text.length);
    
    OSKShareableContent *content = [[OSKShareableContent alloc] init];
    
    content.title = text;
        
    OSKMicroblogPostContentItem *microblogPost = [[OSKMicroblogPostContentItem alloc] init];
    microblogPost.text = text;
    content.microblogPostItem = microblogPost;
    
    OSKCopyToPasteboardContentItem *copyURLToPasteboard = [[OSKCopyToPasteboardContentItem alloc] init];
    copyURLToPasteboard.text = text;
    content.pasteboardItem = copyURLToPasteboard;
    
    OSKEmailContentItem *emailItem = [[OSKEmailContentItem alloc] init];
    emailItem.body = text;
    content.emailItem = emailItem;
    
    OSKSMSContentItem *smsItem = [[OSKSMSContentItem alloc] init];
    smsItem.body = text;
    content.smsItem = smsItem;
    
    OSKToDoListEntryContentItem *toDoList = [[OSKToDoListEntryContentItem alloc] init];
    toDoList.title = text;
    content.toDoListItem = toDoList;
    
    OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
    airDrop.items = @[text];
    content.airDropItem = airDrop;
    
    return content;
}

+ (instancetype)contentFromURL:(NSURL *)url {
    NSParameterAssert(url.absoluteString.length);
    
    OSKShareableContent *content = [[OSKShareableContent alloc] init];
    NSString *absoluteString = url.absoluteString;

    content.title = absoluteString;
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    OSKMicroblogPostContentItem *microblogPost = [[OSKMicroblogPostContentItem alloc] init];
    microblogPost.text = absoluteString;
    content.microblogPostItem = microblogPost;
    
    OSKCopyToPasteboardContentItem *copyURLToPasteboard = [[OSKCopyToPasteboardContentItem alloc] init];
    copyURLToPasteboard.text = absoluteString;
    copyURLToPasteboard.alternateActivityName = OSKLocalizedString(@"Copy URL", nil);
    content.pasteboardItem = copyURLToPasteboard;
    
    OSKEmailContentItem *emailItem = [[OSKEmailContentItem alloc] init];
    emailItem.body = absoluteString;
    emailItem.subject = [NSString stringWithFormat:OSKLocalizedString(@"Link from %@", nil), appName];
    content.emailItem = emailItem;
    
    OSKSMSContentItem *smsItem = [[OSKSMSContentItem alloc] init];
    smsItem.body = absoluteString;
    content.smsItem = smsItem;
    
    OSKReadLaterContentItem *readLater = [[OSKReadLaterContentItem alloc] init];
    readLater.url = url;
    content.readLaterItem = readLater;
    
    OSKToDoListEntryContentItem *toDoList = [[OSKToDoListEntryContentItem alloc] init];
    toDoList.title = [NSString stringWithFormat:OSKLocalizedString(@"Look into link from %@", nil), appName];
    toDoList.notes = absoluteString;
    content.toDoListItem = toDoList;
    
    OSKLinkBookmarkContentItem *linkBookmarking = [[OSKLinkBookmarkContentItem alloc] init];
    linkBookmarking.url = url;
    linkBookmarking.tags = @[appName];
    linkBookmarking.markToRead = YES;
    content.linkBookmarkItem = linkBookmarking;
    
    OSKWebBrowserContentItem *browserItem = [[OSKWebBrowserContentItem alloc] init];
    browserItem.url = url;
    content.webBrowserItem = browserItem;
    
    OSKPasswordManagementAppSearchContentItem *passwordSearchItem = [[OSKPasswordManagementAppSearchContentItem alloc] init];
    passwordSearchItem.query = [url host];
    content.passwordSearchItem = passwordSearchItem;
    
    OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
    airDrop.items = @[url];
    content.airDropItem = airDrop;
    
    return content;
}

+ (instancetype)contentFromMicroblogPost:(NSString *)text authorName:(NSString *)authorName canonicalURL:(NSString *)canonicalURL images:(NSArray *)images {
    OSKShareableContent *content = [[OSKShareableContent alloc] init];
    
    content.title = [NSString stringWithFormat:OSKLocalizedString(@"Post by %@: “%@”", nil), authorName, text];
    
    OSKMicroblogPostContentItem *microblogPost = [[OSKMicroblogPostContentItem alloc] init];
    microblogPost.text = [NSString stringWithFormat:OSKLocalizedString(@"“%@” (Via @%@) %@", nil), text, authorName, canonicalURL];
    microblogPost.images = images;
    content.microblogPostItem = microblogPost;
    
    OSKCopyToPasteboardContentItem *copyTextToPasteboard = [[OSKCopyToPasteboardContentItem alloc] init];
    copyTextToPasteboard.text = text;
    copyTextToPasteboard.alternateActivityName = OSKLocalizedString(@"Copy Text", nil);
    content.pasteboardItem = copyTextToPasteboard;
    
    OSKCopyToPasteboardContentItem *copyURLToPasteboard = [[OSKCopyToPasteboardContentItem alloc] init];
    copyURLToPasteboard.text = canonicalURL;
    copyURLToPasteboard.alternateActivityName = OSKLocalizedString(@"Copy URL", nil);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        copyURLToPasteboard.alternateActivityIcon = [UIImage imageNamed:@"osk-copyIcon-purple-76.png"];
    } else {
        copyURLToPasteboard.alternateActivityIcon = [UIImage imageNamed:@"osk-copyIcon-purple-60.png"];
    }
    
    content.additionalItems = @[copyURLToPasteboard];
    
    OSKEmailContentItem *emailItem = [[OSKEmailContentItem alloc] init];
    emailItem.body = [NSString stringWithFormat:OSKLocalizedString(@"“%@”\n\n(Via @%@)\n\n%@", nil), text, authorName, canonicalURL];
    emailItem.subject = OSKLocalizedString(@"Clipper Ships Sail On the Ocean", nil);
    emailItem.attachments = images.copy;
    content.emailItem = emailItem;
    
    OSKSMSContentItem *smsItem = [[OSKSMSContentItem alloc] init];
    smsItem.body = microblogPost.text;
    smsItem.attachments = images;
    content.smsItem = smsItem;
    
    OSKReadLaterContentItem *readLater = [[OSKReadLaterContentItem alloc] init];
    readLater.url = [NSURL URLWithString:canonicalURL];
    content.readLaterItem = readLater;
    
    OSKToDoListEntryContentItem *toDoList = [[OSKToDoListEntryContentItem alloc] init];
    toDoList.title = [NSString stringWithFormat:OSKLocalizedString(@"Look into message from %@", nil), authorName];
    toDoList.notes = [NSString stringWithFormat:@"%@\n\n%@", text, canonicalURL];
    content.toDoListItem = toDoList;
    
    OSKLinkBookmarkContentItem *linkBookmarking = [[OSKLinkBookmarkContentItem alloc] init];
    linkBookmarking.url = readLater.url;
    linkBookmarking.notes = [NSString stringWithFormat:@"%@\n\n%@", text, canonicalURL];
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    linkBookmarking.tags = @[appName];
    linkBookmarking.markToRead = YES;
    content.linkBookmarkItem = linkBookmarking;
    
    OSKWebBrowserContentItem *browserItem = [[OSKWebBrowserContentItem alloc] init];
    browserItem.url = readLater.url;
    content.webBrowserItem = browserItem;
    
    OSKPasswordManagementAppSearchContentItem *passwordSearchItem = [[OSKPasswordManagementAppSearchContentItem alloc] init];
    passwordSearchItem.query = [[NSURL URLWithString:canonicalURL] host];
    content.passwordSearchItem = passwordSearchItem;
    
    if (images.count) {
        OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
        airDrop.items = images;
        content.airDropItem = airDrop;
    }
    else if (canonicalURL.length) {
        OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
        airDrop.items = @[canonicalURL];
        content.airDropItem = airDrop;
    }
    else if (text.length) {
        OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
        airDrop.items = @[text];
        content.airDropItem = airDrop;
    }
    
    return content;
}

+ (instancetype)contentFromImages:(NSArray *)images caption:(NSString *)caption {
    OSKShareableContent *content = [[OSKShareableContent alloc] init];
    
    content.title = (caption.length) ? caption : OSKLocalizedString(@"Share", nil);
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    OSKMicroblogPostContentItem *microblogPost = [[OSKMicroblogPostContentItem alloc] init];
    microblogPost.text = caption;
    microblogPost.images = images;
    content.microblogPostItem = microblogPost;
    
    OSKCopyToPasteboardContentItem *copyTextToPasteboard = [[OSKCopyToPasteboardContentItem alloc] init];
    copyTextToPasteboard.text = caption;
    content.pasteboardItem = copyTextToPasteboard;
    
    OSKEmailContentItem *emailItem = [[OSKEmailContentItem alloc] init];
    emailItem.body = caption;
    emailItem.attachments = images.copy;
    content.emailItem = emailItem;
    
    OSKSMSContentItem *smsItem = [[OSKSMSContentItem alloc] init];
    smsItem.body = caption;
    smsItem.attachments = images;
    content.smsItem = smsItem;
    
    OSKToDoListEntryContentItem *toDoList = [[OSKToDoListEntryContentItem alloc] init];
    toDoList.title = [NSString stringWithFormat:OSKLocalizedString(@"Look into stuff from %@", nil), appName];
    toDoList.notes = caption;
    content.toDoListItem = toDoList;
    
    if (images.count) {
        OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
        airDrop.items = images;
        content.airDropItem = airDrop;
    }
    else if (caption.length) {
        OSKAirDropContentItem *airDrop = [[OSKAirDropContentItem alloc] init];
        airDrop.items = @[caption];
        content.airDropItem = airDrop;
    }
    
    return content;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTitle:OSKLocalizedString(@"Share", nil)];
    }
    return self;
}

@end
