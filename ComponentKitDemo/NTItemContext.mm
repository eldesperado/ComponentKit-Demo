//
//  NTItemContext.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/26/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemContext.h"

@implementation NTItemContext

- (instancetype)initWithImageDownloader:(NTNetworkImageDownloader *)imageDownloader {
    if (self == [super init]) {
        _imageDownloader = imageDownloader;
    }
    return self;
}

@end
