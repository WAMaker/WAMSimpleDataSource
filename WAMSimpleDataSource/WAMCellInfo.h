//
//  WAMCellInfo.h
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/17.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAMCellInfo : NSObject

@property (nonatomic, readonly, copy, nullable) NSString *reuseIdentifier;

@property (nonatomic, readonly, weak, nullable) __kindof UITableViewCell *cell;

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *detail;
@property (nonatomic, copy, nullable) NSString *alias;

///---------------------
/// @name Initialization
///---------------------

+ (instancetype)infoWithReuseIdentifier:(NSString *)reuseIdentifier
                                  title:(nullable NSString *)title
                                 detail:(nullable NSString *)detail
                                  alias:(nullable NSString *)alias;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                                  title:(nullable NSString *)title
                                 detail:(nullable NSString *)detail
                                  alias:(nullable NSString *)alias;

+ (instancetype)infoWithSelfDefineCell:(__kindof UITableViewCell *)cell
                                 alias:(nullable NSString *)alias;
- (instancetype)initWithSelfDefineCell:(__kindof UITableViewCell *)cell
                                 alias:(nullable NSString *)alias;

@end

NS_ASSUME_NONNULL_END
