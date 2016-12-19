//
//  WAMDataSource.m
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/18.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import "WAMDataSource.h"

@interface WAMDataSource ()

@property (nonatomic, strong) NSMutableArray<WAMSectionInfo *> *mSectionInfos;

@end

@implementation WAMDataSource

#pragma mark - public methods

#pragma mark -- Initialization

+ (instancetype)dataSourceWithSectionInfos:(NSArray<WAMSectionInfo *> *)sectionInfos {
    return [[self alloc] initWithSectionInfos:sectionInfos];
}

- (instancetype)initWithSectionInfos:(NSArray<WAMSectionInfo *> *)sectionInfos {
    NSAssert([sectionInfos isKindOfClass:[NSArray class]], @"sections should valid");
    
    if (self = [super init]) {
        self.mSectionInfos = [NSMutableArray arrayWithArray:sectionInfos];
    }
    return self;
}

#pragma mark -- Index search

- (NSUInteger)indexOfSectionInfoWithAlias:(NSString *)alias {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    __block NSUInteger index = NSNotFound;
    [self.mSectionInfos enumerateObjectsUsingBlock:^(WAMSectionInfo *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.alias isEqualToString:alias]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

- (NSIndexPath *)indexPathOfCellInfoWithAlias:(NSString *)alias {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    __block NSIndexPath *indexPath = nil;
    [self.mSectionInfos enumerateObjectsUsingBlock:^(WAMSectionInfo *obj, NSUInteger idx, BOOL *stop) {
        NSUInteger index = [obj indexOfCellInfoWithAlias:alias];
        if (index != NSNotFound) {
            indexPath = [NSIndexPath indexPathForRow:index inSection:idx];
            *stop = YES;
        }
    }];
    return indexPath;
}

#pragma mark -- Append

- (BOOL)appendingSectionInfo:(WAMSectionInfo *)sectionInfo {
    NSAssert([sectionInfo isKindOfClass:[WAMSectionInfo class]], @"sectionInfo should be valid");
    
    [self.mSectionInfos addObject:sectionInfo];
    return YES;
}

- (BOOL)appendingSectionInfo:(WAMSectionInfo *)sectionInfo atIndex:(NSUInteger)index {
    if (index > self.mSectionInfos.count) {
        return NO;
    }
    [self.mSectionInfos insertObject:sectionInfo atIndex:index];
    return YES;
}

#pragma mark -- Delete

- (BOOL)removeSectionInfo:(WAMSectionInfo *)sectionInfo {
    NSAssert([sectionInfo isKindOfClass:[WAMSectionInfo class]], @"sectionInfo should be valid");
    
    if (![self.mSectionInfos containsObject:sectionInfo]) {
        return NO;
    }
    [self.mSectionInfos removeObject:sectionInfo];
    return YES;
}

- (BOOL)removeSectionInfoAtIndex:(NSUInteger)index {
    if (index >= self.mSectionInfos.count) {
        return NO;
    }
    [self.mSectionInfos removeObjectAtIndex:index];
    return YES;
}

- (BOOL)removeSectionInfoWithAlias:(NSString *)alias {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    __block NSUInteger index = NSNotFound;
    [self.mSectionInfos enumerateObjectsUsingBlock:^(WAMSectionInfo *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.alias isEqualToString:alias]) {
            index = idx;
            [self.mSectionInfos removeObject:obj];
            *stop = YES;
        }
    }];
    return index != NSNotFound;
}

#pragma mark -- Replace

- (BOOL)replaceSectionInfo:(WAMSectionInfo *)originalSectionInfo with:(WAMSectionInfo *)sectionInfo {
    NSAssert([originalSectionInfo isKindOfClass:[WAMSectionInfo class]], @"originalSectionInfo should be valid");
    NSAssert([sectionInfo isKindOfClass:[WAMSectionInfo class]], @"sectionInfo should be valid");
    
    if (![self.mSectionInfos containsObject:originalSectionInfo]) {
        return NO;
    }
    return [self replaceSectionInfoAtIndex:[self.mSectionInfos indexOfObject:originalSectionInfo] with:sectionInfo];
}

- (BOOL)replaceSectionInfoAtIndex:(NSUInteger)index with:(WAMSectionInfo *)sectionInfo {
    NSAssert([sectionInfo isKindOfClass:[WAMSectionInfo class]], @"sectionInfo should be valid");
    
    if (index >= self.mSectionInfos.count) {
        return NO;
    }
    [self.mSectionInfos replaceObjectAtIndex:index withObject:sectionInfo];
    return YES;
}

- (BOOL)replaceSectionInfoWithAlias:(NSString *)alias with:(WAMSectionInfo *)sectionInfo {
    NSAssert([alias isKindOfClass:[NSString class]], @"alias should be valid");
    
    __block NSUInteger index = NSNotFound;
    [self.mSectionInfos enumerateObjectsUsingBlock:^(WAMSectionInfo *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.alias isEqualToString:alias]) {
            index = idx;
            *stop = YES;
        }
    }];
    return [self replaceSectionInfoAtIndex:index with:sectionInfo];
}

#pragma mark - getter (public)

- (NSArray<WAMSectionInfo *> *)sectionInfos {
    return self.mSectionInfos.copy;
}

@end
