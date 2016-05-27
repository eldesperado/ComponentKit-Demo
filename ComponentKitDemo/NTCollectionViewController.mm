//
//  NTCollectionViewController.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTCollectionViewController.h"
#import "NTItemContext.h"
#import "NTItemModelController.h"
#import "NTNetworkImageDownloader.h"
#import <ComponentKit/ComponentKit.h>

@interface NTCollectionViewController ()

@property(strong, nonatomic) CKCollectionViewDataSource *dataSource;
@property(strong, nonatomic)
    CKComponentFlexibleSizeRangeProvider *sizeRangeProvider;
@property(strong, nonatomic) NTItemModelController *itemModelController;
@property(strong, nonatomic) NTNetworkImageDownloader *networkImageDownloader;

@end

@implementation NTCollectionViewController

static NSString *const reuseIdentifier = @"Cell";

#pragma mark - Initialization
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self == nil) {
    return self;
  }

  _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider
      providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
  _itemModelController = [[NTItemModelController alloc] init];
  _networkImageDownloader = [[NTNetworkImageDownloader alloc] init];

  return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
  [super viewDidLoad];

  // Setup Collection View
  self.collectionView.delegate = self;

  // Create a new Item Context
  NTItemContext *context = [[NTItemContext alloc]
      initWithImageDownloader:self.networkImageDownloader];

  // Create a new Datasource
  self.dataSource = [[CKCollectionViewDataSource alloc]
           initWithCollectionView:self.collectionView
      supplementaryViewDataSource:nil
                componentProvider:[self class]
                          context:context
        cellConfigurationFunction:nil];
    
  // Insert a new section
    CKArrayControllerSections sections;
    sections.insert(0);
    [self.dataSource enqueueChangeset:{sections, {}} constrainedSize:{}];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
  return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                forIndexPath:indexPath];

  // Configure the cell

  return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted
 during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView
 shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView
 shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for
 the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView
 shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
        return NO;
 }

 - (BOOL)collectionView:(UICollectionView *)collectionView
 canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath
 withSender:(id)sender {
        return NO;
 }

 - (void)collectionView:(UICollectionView *)collectionView
 performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath
 withSender:(id)sender {

 }
 */

@end
