//
//  NTItem.h
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/26/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NTItem : NSObject

@property(strong, nonatomic, readonly) NSString *itemId;
@property(copy, nonatomic, readonly) NSString *title;
@property(strong, nonatomic, readonly) NSURL *imageURL;

- (instancetype)initWithTitle:(NSString *)title imageURLString:(NSString *)imageURLString;

@end
