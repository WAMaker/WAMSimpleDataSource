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

@end

@interface WAMSectionInfo (IndexSearch)

- (NSUInteger)indexOfCellInfoWithAlias:(NSString *)alias;

@end

@interface WAMSectionInfo (Append)

- (BOOL)appendingCellInfo:(WAMCellInfo *)cellInfo;
- (BOOL)appendingCellInfo:(WAMCellInfo *)cellInfo atIndex:(NSUInteger)index;

@end

@interface WAMSectionInfo (Delete)

- (BOOL)removeCellInfo:(WAMCellInfo *)cellInfo;
- (BOOL)removeCellInfoAtIndex:(NSUInteger)index;
- (BOOL)removeCellInfoWithAlias:(NSString *)alias;

@end

@interface WAMSectionInfo (Replace)

- (BOOL)replaceCellInfo:(WAMCellInfo *)originalCellInfo with:(WAMCellInfo *)cellInfo;
- (BOOL)replaceCellInfoAtIndex:(NSUInteger)index with:(WAMCellInfo *)cellInfo;
- (BOOL)replaceCellInfoWithAlias:(NSString *)alias with:(WAMCellInfo *)cellInfo;

@end

NS_ASSUME_NONNULL_END
