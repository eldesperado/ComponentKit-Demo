//
//  NTItemsPage.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/26/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemsPage.h"

@implementation NTItemsPage

- (instancetype)initWithItems:(NSArray *)items position:(NSInteger)position {
  if (self = [super init]) {
    _items = items;
    _position = position;
  }
  return self;
}

@end
