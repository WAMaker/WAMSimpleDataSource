//
//  WAMSectionInfoTests.m
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/17.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WAMSectionInfo.h"
#import "WAMTestsConstant.h"

@interface WAMSectionInfoTests : XCTestCase

@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, strong) WAMCellInfo *identifierCellInfo;
@property (nonatomic, strong) WAMCellInfo *selfDefineCellInfo;
@property (nonatomic, strong) WAMSectionInfo *sectionInfo;

@end

@implementation WAMSectionInfoTests

- (void)setUp {
    [super setUp];
    
    self.identifierCellInfo = [WAMCellInfo infoWithReuseIdentifier:kCellReuseIdentifier title:kCellTitle detail:nil alias:kCellAlias];
    
    self.cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentifier];
    self.selfDefineCellInfo = [WAMCellInfo infoWithSelfDefineCell:self.cell alias:nil];
    
    self.sectionInfo = [WAMSectionInfo infoWithCellInfos:@[self.identifierCellInfo, self.selfDefineCellInfo] alias:kSectionAlias];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSectionInfoInitialization {
    XCTAssertNotNil(self.sectionInfo);
    XCTAssertNotNil(self.sectionInfo.cellInfos);
    
    XCTAssertEqual(self.sectionInfo.cellInfos.count, 2);
    
    XCTAssertNil(self.sectionInfo.sectionHeaderText);
    XCTAssertEqual(self.sectionInfo.sectionHeaderHeight, 0.1);
    
    XCTAssertNil(self.sectionInfo.sectionFooterText);
    XCTAssertEqual(self.sectionInfo.sectionFooterHeight, 0.1);
}

- (void)testSetSectionInfoHeaderFooterText {
    self.sectionInfo.sectionHeaderText = @"kHeaderText";
    self.sectionInfo.sectionFooterText = @"kFooterText";
    
    XCTAssertEqual(self.sectionInfo.sectionHeaderText, @"kHeaderText");
    XCTAssertEqual(self.sectionInfo.sectionFooterText, @"kFooterText");
}

- (void)testSetSectionInfoHeaderFooterHeight {
    self.sectionInfo.sectionHeaderHeight = -100;
    self.sectionInfo.sectionFooterHeight = -233;
    XCTAssertEqual(self.sectionInfo.sectionHeaderHeight, 0.1);
    XCTAssertEqual(self.sectionInfo.sectionFooterHeight, 0.1);
    
    self.sectionInfo.sectionHeaderHeight = 233;
    self.sectionInfo.sectionFooterHeight = 100;
    XCTAssertEqual(self.sectionInfo.sectionHeaderHeight, 233);
    XCTAssertEqual(self.sectionInfo.sectionFooterHeight, 100);
}

- (void)testIndexSearch {
    XCTAssertEqual([self.sectionInfo indexOfCellInfoWithAlias:kCellAlias], 0);
    XCTAssertEqual([self.sectionInfo indexOfCellInfoWithAlias:kNotFoundAlias], NSNotFound);
}

- (void)testAppend {
    WAMCellInfo *cellInfo = [WAMCellInfo infoWithSelfDefineCell:self.cell alias:nil];
    
    XCTAssertTrue([self.sectionInfo appendingCellInfo:cellInfo]);
    XCTAssertEqual(self.sectionInfo.cellInfos.count, 3);
    XCTAssertEqual(self.sectionInfo.cellInfos.lastObject, cellInfo);
}

- (void)testInsert {
    WAMCellInfo *cellInfo = [WAMCellInfo infoWithSelfDefineCell:self.cell alias:nil];
    
    XCTAssertFalse([self.sectionInfo appendingCellInfo:cellInfo atIndex:233]);
    
    XCTAssertTrue([self.sectionInfo appendingCellInfo:cellInfo atIndex:0]);
    XCTAssertEqual(self.sectionInfo.cellInfos.count, 3);
    XCTAssertEqual(self.sectionInfo.cellInfos.firstObject, cellInfo);
}

- (void)testRemove {
    XCTAssertTrue([self.sectionInfo removeCellInfo:self.identifierCellInfo]);
    XCTAssertEqual(self.sectionInfo.cellInfos.count, 1);
    XCTAssertEqual(self.sectionInfo.cellInfos.lastObject, self.selfDefineCellInfo);
    
    WAMCellInfo *cellInfo = [WAMCellInfo infoWithSelfDefineCell:self.cell alias:nil];
    XCTAssertFalse([self.sectionInfo removeCellInfo:cellInfo]);
}

- (void)testRemoveAtIndex {
    XCTAssertFalse([self.sectionInfo removeCellInfoAtIndex:2333]);
    
    XCTAssertTrue([self.sectionInfo removeCellInfoAtIndex:0]);
    XCTAssertEqual(self.sectionInfo.cellInfos.count, 1);
    XCTAssertEqual(self.sectionInfo.cellInfos.lastObject, self.selfDefineCellInfo);
}

- (void)testRemoveWithAlias {
    XCTAssertTrue([self.sectionInfo removeCellInfoWithAlias:kCellAlias]);
    XCTAssertEqual(self.sectionInfo.cellInfos.count, 1);
    XCTAssertEqual(self.sectionInfo.cellInfos.lastObject, self.selfDefineCellInfo);
    
    XCTAssertFalse([self.sectionInfo removeCellInfoWithAlias:kNotFoundAlias]);
}

@end
