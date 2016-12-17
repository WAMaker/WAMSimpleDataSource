//
//  WAMSectionInfo.h
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/17.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAMCellInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface WAMSectionInfo : NSObject

@property (nonatomic, readonly, copy) NSArray<WAMCellInfo *> *cellInfos;

@property (nonatomic, copy, nullable) NSString *alias;

///---------------------
/// @name section header
///---------------------

@property (nonatomic, copy, nullable) NSString *sectionHeaderText;
@property (nonatomic, assign) CGFloat sectionHeaderHeight; // default is 0.1

///---------------------
/// @name section footer
///---------------------

@property (nonatomic, copy, nullable) NSString *sectionFooterText;
@property (nonatomic, assign) CGFloat sectionFooterHeight; // default is 0.1

///---------------------
/// @name Initialization
///---------------------

+ (instancetype)infoWithCellInfos:(NSArray<WAMCellInfo *> *)cellInfos
                            alias:(nullable NSString *)alias;
- (instancetype)initWithCellInfos:(NSArray<WAMCellInfo *> *)cellInfos
                            alias:(nullable NSString *)alias;

///-------------
/// @name Search
///-------------

- (NSUInteger)indexOfCellInfoWithAlias:(NSString *)alias;

///-------------
/// @name Append
///-------------

- (BOOL)appendingCellInfo:(WAMCellInfo *)cellInfo;
- (BOOL)appendingCellInfo:(WAMCellInfo *)cellInfo atIndex:(NSUInteger)index;

///-------------
/// @name Delete
///-------------

- (BOOL)removeCellInfo:(WAMCellInfo *)cellInfo;
- (BOOL)removeCellInfoAtIndex:(NSUInteger)index;
- (BOOL)removeCellInfoWithAlias:(NSString *)alias;

@end

NS_ASSUME_NONNULL_END
