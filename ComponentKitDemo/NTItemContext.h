//
//  NTItemContext.h
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/26/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NTNetworkImageDownloader.h"

@interface NTItemContext : NSObject
@property (strong, nonatomic, readonly) NTNetworkImageDownloader *imageDownloader;

- (instancetype)initWithImageDownloader:(NTNetworkImageDownloader *)imageDownloader;
@end
