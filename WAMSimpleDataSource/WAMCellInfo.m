//
//  WAMCellInfo.m
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/17.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import "WAMCellInfo.h"

@interface WAMCellInfo ()

@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;

@property (nonatomic, readwrite, weak) __kindof UITableViewCell *cell;

@end

@implementation WAMCellInfo

#pragma mark - public methods

+ (instancetype)infoWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title detail:(NSString *)detail alias:(NSString *)alias {
    return [[self alloc] initWithReuseIdentifier:reuseIdentifier title:title detail:detail alias:alias];
}

- (instancetype)initWithReuseIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail alias:(NSString *)alias {
    NSAssert([identifier isKindOfClass:[NSString class]], @"identifier should be valid");
    
    if (self = [super init]) {
        self.reuseIdentifier = identifier;
        self.title  = title;
        self.detail = detail;
        self.alias  = alias;
    }
    return self;
}

+ (instancetype)infoWithSelfDefineCell:(__kindof UITableViewCell *)cell alias:(NSString *)alias {
    return [[self alloc] initWithSelfDefineCell:cell alias:alias];
}

- (instancetype)initWithSelfDefineCell:(__kindof UITableViewCell *)cell alias:(NSString *)alias {
    NSAssert([cell isKindOfClass:[UITableViewCell class]], @"cell should be valid");
    
    if (self = [super init]) {
        self.cell  = cell;
        self.alias = alias;
    }
    return self;
}

@end
