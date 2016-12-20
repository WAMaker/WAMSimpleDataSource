//
//  WAMDataSource.h
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/18.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAMSectionInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface WAMDataSource : NSObject

@property (nonatomic, readonly, copy) NSArray<WAMSectionInfo *> *sectionInfos;

///---------------------
/// @name Initialization
///---------------------

+ (instancetype)dataSourceWithSectionInfos:(NSArray<WAMSectionInfo *> *)sectionInfos;
- (instancetype)initWithSectionInfos:(NSArray<WAMSectionInfo *> *)sectionInfos;

@end

@interface WAMDataSource (IndexSearch)

- (NSUInteger)indexOfSectionInfoWithAlias:(NSString *)alias;
- (nullable NSIndexPath *)indexPathOfCellInfoWithAlias:(NSString *)alias;

@end

@interface WAMDataSource (Append)

- (BOOL)appendingSectionInfo:(WAMSectionInfo *)sectionInfo;
- (BOOL)appendingSectionInfo:(WAMSectionInfo *)sectionInfo atIndex:(NSUInteger)index;

@end

@interface WAMDataSource (Delete)

- (BOOL)removeSectionInfo:(WAMSectionInfo *)sectionInfo;
- (BOOL)removeSectionInfoAtIndex:(NSUInteger)index;
- (BOOL)removeSectionInfoWithAlias:(NSString *)alias;

@end

@interface WAMDataSource (Replace)

- (BOOL)replaceSectionInfo:(WAMSectionInfo *)originalSectionInfo with:(WAMSectionInfo *)sectionInfo;
- (BOOL)replaceSectionInfoAtIndex:(NSUInteger)index with:(WAMSectionInfo *)sectionInfo;
- (BOOL)replaceSectionInfoWithAlias:(NSString *)alias with:(WAMSectionInfo *)sectionInfo;

@end

NS_ASSUME_NONNULL_END
