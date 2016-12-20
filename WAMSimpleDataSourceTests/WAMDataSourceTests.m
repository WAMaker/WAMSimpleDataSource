//
//  WAMDataSourceTests.m
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/19.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WAMDataSource.h"
#import "WAMTestsConstant.h"

@interface WAMDataSourceTests : XCTestCase

@property (nonatomic, strong) WAMCellInfo    *cellInfo;
@property (nonatomic, strong) WAMSectionInfo *sectionOne;
@property (nonatomic, strong) WAMSectionInfo *sectionTwo;
@property (nonatomic, strong) WAMDataSource  *dataSource;

@end

@implementation WAMDataSourceTests

- (void)setUp {
    [super setUp];
    
    self.cellInfo = [WAMCellInfo infoWithReuseIdentifier:kCellReuseIdentifier title:nil detail:nil alias:kCellAlias];
    
    self.sectionOne = [WAMSectionInfo infoWithCellInfos:@[self.cellInfo] alias:kSectionAlias];
    self.sectionTwo = [WAMSectionInfo infoWithCellInfos:@[] alias:nil];
    
    self.dataSource = [WAMDataSource dataSourceWithSectionInfos:@[self.sectionOne, self.sectionTwo]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDataSourceInitialization {
    XCTAssertNotNil(self.dataSource);
    XCTAssertNotNil(self.dataSource.sectionInfos);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 2);
}

- (void)testIndexSearch {
    XCTAssertEqual([self.dataSource indexOfSectionInfoWithAlias:kSectionAlias], 0);
    XCTAssertEqual([self.dataSource indexOfSectionInfoWithAlias:kNotFoundAlias], NSNotFound);
    
    XCTAssertEqual([self.dataSource indexPathOfCellInfoWithAlias:kCellAlias], [NSIndexPath indexPathForRow:0 inSection:0]);
    XCTAssertNil([self.dataSource indexPathOfCellInfoWithAlias:kNotFoundAlias]);
}

- (void)testAppend {
    WAMSectionInfo *sectionInfo = [WAMSectionInfo infoWithCellInfos:@[self.cellInfo] alias:nil];
    
    XCTAssertTrue([self.dataSource appendingSectionInfo:sectionInfo]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 3);
    XCTAssertEqual(self.dataSource.sectionInfos.lastObject, sectionInfo);
}

- (void)testAppendAtIndex {
    WAMSectionInfo *sectionInfo = [WAMSectionInfo infoWithCellInfos:@[self.cellInfo] alias:nil];
    
    XCTAssertFalse([self.dataSource appendingSectionInfo:sectionInfo atIndex:kUnvalidIndex]);
    
    XCTAssertTrue([self.dataSource appendingSectionInfo:sectionInfo atIndex:0]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 3);
    XCTAssertEqual([self.dataSource.sectionInfos objectAtIndex:0], sectionInfo);
}

- (void)testRemove {
    XCTAssertFalse([self.dataSource removeSectionInfo:[WAMSectionInfo infoWithCellInfos:@[] alias:nil]]);
    
    XCTAssertTrue([self.dataSource removeSectionInfo:self.sectionOne]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 1);
    XCTAssertEqual(self.dataSource.sectionInfos.lastObject, self.sectionTwo);
}

- (void)testRemoveAtIndex {
    XCTAssertFalse([self.dataSource removeSectionInfoAtIndex:kUnvalidIndex]);
    
    XCTAssertTrue([self.dataSource removeSectionInfoAtIndex:1]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 1);
    XCTAssertEqual(self.dataSource.sectionInfos.firstObject, self.sectionOne);
}

- (void)testRemoveWithAlias {
    XCTAssertFalse([self.dataSource removeSectionInfoWithAlias:kNotFoundAlias]);
    
    XCTAssertTrue([self.dataSource removeSectionInfoWithAlias:kSectionAlias]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 1);
    XCTAssertEqual(self.dataSource.sectionInfos.firstObject, self.sectionTwo);
}

- (void)testReplace {
    WAMSectionInfo *sectionInfo = [WAMSectionInfo infoWithCellInfos:@[] alias:nil];
    
    XCTAssertFalse([self.dataSource replaceSectionInfo:sectionInfo with:sectionInfo]);
    
    XCTAssertTrue([self.dataSource replaceSectionInfo:self.sectionTwo with:sectionInfo]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 2);
    XCTAssertEqual([self.dataSource.sectionInfos objectAtIndex:1], sectionInfo);
}

- (void)testReplaceAtIndex {
    WAMSectionInfo *sectionInfo = [WAMSectionInfo infoWithCellInfos:@[] alias:nil];
    
    XCTAssertFalse([self.dataSource replaceSectionInfoAtIndex:kUnvalidIndex with:sectionInfo]);
    
    XCTAssertTrue([self.dataSource replaceSectionInfoAtIndex:0 with:sectionInfo]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 2);
    XCTAssertEqual([self.dataSource.sectionInfos objectAtIndex:0], sectionInfo);
}

- (void)testReplaceWithAlias {
    WAMSectionInfo *sectionInfo = [WAMSectionInfo infoWithCellInfos:@[] alias:nil];
    
    XCTAssertFalse([self.dataSource replaceSectionInfoWithAlias:kNotFoundAlias with:sectionInfo]);
    
    XCTAssertTrue([self.dataSource replaceSectionInfoWithAlias:kSectionAlias with:sectionInfo]);
    XCTAssertEqual(self.dataSource.sectionInfos.count, 2);
    XCTAssertEqual([self.dataSource.sectionInfos objectAtIndex:0], sectionInfo);
}

@end
