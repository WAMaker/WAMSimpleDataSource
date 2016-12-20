//
//  WAMSectionInfo.m
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/17.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import "WAMSectionInfo.h"
#import "WAMCellInfo+Private.h"

static CGFloat const kSectionHeaderFooterDefaultH = 0.1;

@interface WAMSectionInfo ()

@property (nonatomic, strong) NSMutableArray<WAMCellInfo *> *mCellInfos;

@end

@implementation WAMSectionInfo

#pragma mark - public methods

#pragma mark -- Initialization

+ (instancetype)infoWithCellInfos:(NSArray<WAMCellInfo *> *)cellInfos alias:(NSString *)alias {
    return [[self alloc] initWithCellInfos:cellInfos alias:alias];
}

- (instancetype)initWithCellInfos:(NSArray<WAMCellInfo *> *)cellInfos alias:(NSString *)alias {
    NSAssert([cellInfos isKindOfClass:[NSArray class]], @"cellInfos should be valid");
    
    if (self = [self init]) {
        self.alias = alias;
        [self.mCellInfos addObjectsFromArray:cellInfos];
    }
    return self;
}

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        self.sectionHeaderHeight = kSectionHeaderFooterDefaultH;
        self.sectionFooterHeight = kSectionHeaderFooterDefaultH;
    }
    return self;
}

#pragma mark - setter (public)

- (void)setSectionHeaderHeight:(CGFloat)sectionHeaderHeight {
    _sectionHeaderHeight = sectionHeaderHeight;
    if (sectionHeaderHeight <= 0) {
        _sectionHeaderHeight = kSectionHeaderFooterDefaultH;
    }
}

- (void)setSectionFooterHeight:(CGFloat)sectionFooterHeight {
    _sectionFooterHeight = sectionFooterHeight;
    if (sectionFooterHeight <= 0) {
        _sectionFooterHeight = kSectionHeaderFooterDefaultH;
    }
}

#pragma mark - getter (public)

- (NSArray<WAMCellInfo *> *)cellInfos {
    return self.mCellInfos.copy;
}

#pragma mark - getter (private)

- (NSMutableArray<WAMCellInfo *> *)mCellInfos {
    if (_mCellInfos == nil) {
        _mCellInfos = @[].mutableCopy;
    }
    return _mCellInfos;
}

@end

@implementation WAMSectionInfo (IndexSearch)

- (NSUInteger)indexOfCellInfoWithAlias:(NSString *)alias {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    __block NSUInteger index = NSNotFound;
    [self.mCellInfos enumerateObjectsUsingBlock:^(WAMCellInfo *cellInfo, NSUInteger idx, BOOL *stop) {
        if ([cellInfo.alias isEqualToString:alias]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

@end

@implementation WAMSectionInfo (Append)

- (BOOL)appendingCellInfo:(WAMCellInfo *)cellInfo {
    NSAssert(cellInfo.valid, @"cellInfo should be valid");
    
    [self.mCellInfos addObject:cellInfo];
    return YES;
}

- (BOOL)appendingCellInfo:(WAMCellInfo *)cellInfo atIndex:(NSUInteger)index {
    NSAssert(cellInfo.valid, @"cellInfo should be valid");
    
    if (index > self.mCellInfos.count) {
        return NO;
    }
    [self.mCellInfos insertObject:cellInfo atIndex:index];
    return YES;
}

@end

@implementation WAMSectionInfo (Delete)

- (BOOL)removeCellInfo:(WAMCellInfo *)cellInfo {
    NSAssert(cellInfo.valid, @"cellInfo should be valid");
    
    if (![self.mCellInfos containsObject:cellInfo]) {
        return NO;
    }
    [self.mCellInfos removeObject:cellInfo];
    return YES;
}

- (BOOL)removeCellInfoAtIndex:(NSUInteger)index {
    if (self.mCellInfos.count <= index) {
        return NO;
    }
    return [self removeCellInfo:[self.mCellInfos objectAtIndex:index]];
}

- (BOOL)removeCellInfoWithAlias:(NSString *)alias {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    __block BOOL success = NO;
    [self.mCellInfos enumerateObjectsUsingBlock:^(WAMCellInfo *cellInfo, NSUInteger idx, BOOL *stop) {
        if ([cellInfo.alias isEqualToString:alias]) {
            success = YES;
            [self removeCellInfo:cellInfo];
            *stop = YES;
        }
    }];
    return success;
}

@end

@implementation WAMSectionInfo (Replace)

- (BOOL)replaceCellInfo:(WAMCellInfo *)originalCellInfo with:(WAMCellInfo *)cellInfo {
    NSAssert(originalCellInfo.valid, @"originalCellInfo should be valid");
    NSAssert(cellInfo.valid, @"cellInfo should be valid");
    
    if (![self.mCellInfos containsObject:originalCellInfo]) {
        return NO;
    }
    NSUInteger index = [self.mCellInfos indexOfObject:originalCellInfo];
    [self.mCellInfos replaceObjectAtIndex:index withObject:cellInfo];
    return YES;
}

- (BOOL)replaceCellInfoAtIndex:(NSUInteger)index with:(WAMCellInfo *)cellInfo {
    if (index >= self.mCellInfos.count) {
        return NO;
    }
    return [self replaceCellInfo:[self.mCellInfos objectAtIndex:index] with:cellInfo];
}

- (BOOL)replaceCellInfoWithAlias:(NSString *)alias with:(WAMCellInfo *)cellInfo {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    NSUInteger index = [self indexOfCellInfoWithAlias:alias];
    if (index == NSNotFound) {
        return NO;
    }
    return [self replaceCellInfo:[self.mCellInfos objectAtIndex:index] with:cellInfo];
}

@end
