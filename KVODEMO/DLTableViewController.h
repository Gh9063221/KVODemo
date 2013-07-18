//
//  DLTableViewController.h
//  KVODEMO
//
//  Created by zht on 13-7-18.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *items;

// KVO - array accessors
- (void)insertObject:(id)anObject inItemsAtIndex:(NSUInteger)idx;
- (id)objectInItemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromItemsAtIndex:(NSUInteger)idx;

@end
