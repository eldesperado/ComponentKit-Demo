//
//  NTItem.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/26/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItem.h"

@implementation NTItem
- (instancetype)initWithTitle:(NSString *)title
               imageURLString:(NSString *)imageURLString
                        style:(NTItemComponentType)style {
    if (self = [super init]) {
        _itemId = [[NSUUID UUID] UUIDString];
        _title = [title copy];
        _imageURL = [NSURL URLWithString:imageURLString];
        _style = style;
    }
    return self;
}
@end
