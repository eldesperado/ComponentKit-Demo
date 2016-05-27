//
//  NTNetworkImageDownloader.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTNetworkImageDownloader.h"
#import <UIKit/UIKit.h>

@implementation NTNetworkImageDownloader {
    NSMutableDictionary *_taskCache;
    NSCache *_imagesCache;
    NSLock *_lock;
}

#pragma mark - Initialization
- (instancetype)init {
    self = [super init];
    if (self == nil) { return self; }
    
    _taskCache = [NSMutableDictionary dictionary];
    _imagesCache = [NSCache new];
    _imagesCache.countLimit = 15;
    _lock = [NSLock new];
    
    return self;
}

#pragma mark - CKNetworkImageDownloading
- (id)downloadImageWithURL:(NSURL *)URL
                 scenePath:(id)scenePath
                    caller:(id)caller
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError *error))completion
{
    // Handle already cached image
    UIImage *image = [_imagesCache objectForKey:URL.absoluteString];
    if (image != nil) {
        dispatch_async(callbackQueue, ^{
            if (completion) {
                completion(image.CGImage, nil);
            }
        });
        
        return nil;
    }
    
    // Get the image
    NSString *downloadIdentifier = [[NSUUID UUID] UUIDString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        UIImage *image = nil;
        if (error == nil) {
            image = [[UIImage alloc] initWithData:data];
            
            if (image != nil) {
                [_imagesCache setObject:image forKey:URL.absoluteString];
            }
        }
        
        dispatch_async(callbackQueue, ^{
            
            [_lock lock];
            // Check if the task is still in the cache or was already cancelled
            BOOL taskWasCancelled = (_taskCache[downloadIdentifier] == nil);
            [_taskCache removeObjectForKey:downloadIdentifier];
            [_lock unlock];
            
            if (completion && !taskWasCancelled) {
                completion(image.CGImage, error);
            }
            
        });
    }];
    
    [_lock lock];
    // Cache task for cancelling
    _taskCache[downloadIdentifier] = task;
    [_lock unlock];
    
    [task resume];
    
    
    return downloadIdentifier;
}

- (void)cancelImageDownload:(id)download
{
    [_lock lock];
    // Get image from cache and cancel if necessary
    NSURLSessionDataTask *task = _taskCache[download];
    [_taskCache removeObjectForKey:download];
    [_lock unlock];
    
    [task cancel];
}

@end
