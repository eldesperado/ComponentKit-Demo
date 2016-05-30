//
//  NTOverlayBackgroundComponent.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/30/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTOverlayBackgroundComponent.h"

@implementation NTOverlayBackgroundComponent

+ (instancetype)newWithItem:(NTItem *)item
                         context:(NTItemContext *)context {
    return [super newWithComponent:
            [CKOverlayLayoutComponent
             newWithComponent:
             [CKNetworkImageComponent
              newWithURL:item.imageURL
              imageDownloader:context.imageDownloader
              scenePath:nil
              size:{}
              options:{
                  .defaultImage = defaultImage()
              }
              attributes:{}]
             overlay:overlayComponent()]];
}
static UIImage *defaultImage()
{
    static UIImage *defaultImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = CGSizeMake(100.0, 100.0);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillRect(context, CGRectMake(0.f, 0.f, size.width, size.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        defaultImage = image;
    });
    
    return defaultImage;
}

static CKComponent *overlayComponent()
{
    return [CKComponent
            newWithView:{
                [UIView class],
                {{@selector(setBackgroundColor:),
                    [[UIColor blackColor] colorWithAlphaComponent:0.3]}}
            }
            size:{}];
}

@end
