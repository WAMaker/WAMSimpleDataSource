# WAMSimpleDataSource

[![Build Status](https://travis-ci.org/WAMaker/WAMSimpleDataSource.svg?branch=master)](https://travis-ci.org/WAMaker/WAMSimpleDataSource)
[![codecov](https://codecov.io/gh/WAMaker/WAMSimpleDataSource/branch/master/graph/badge.svg)](https://codecov.io/gh/WAMaker/WAMSimpleDataSource)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/WAMSimpleDataSource.svg)](https://img.shields.io/cocoapods/v/WAMSimpleDataSource.svg)


An easier way to create static table view data source.

## Installation with CocoaPods

To integrate WAMSimpleDataSource into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'WAMSimpleDataSource', '~> 0.1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

In order to make codes clear and reduce hard codes, **WAMCellInfo** and **WAMSectionInfo** are both able to set alias (nullable according to your decision) for index searching, appending, replacing and removing.

#### WAMCellInfo

`WAMCellInfo` is a class holding the basic infomation for your cell. You can create a cell info with reuseIdentifier like this:

```objective-c
WAMCellInfo *cellInfo = [WAMCellInfo infoWithReuseIdentifier:@"identifier" title:nil detail:nil alias:@"infoWithReuseIdentifier"];
```

or with you customized cell:

```objective-c
WAMCellInfo *cellInfo = [WAMCellInfo infoWithSelfDefineCell:self.customizedCell alias:@"infoWithSelfDefineCell"];
```

#### WAMSectionInfo

WAMSectionInfo holds all cellInfos in the same section. You can simply add cellInfos to the sectionInfo:

```objective-c
WAMSectionInfo *sectionInfo = [WAMSectionInfo infoWithCellInfos:@[cellInfoZero, cellInfoOne] alias:@"sectionAlias"];
```

##### Index search

Searching index for a cellInfo with specific alias is easy (if index is not found in the sectionInfo, function will return NSNotFound):

```objective-c
NSUInteger index = [sectionInfo indexOfCellInfoWithAlias:@"forkYou"];
```

##### Append

```objective-c
[sectionInfo appendingCellInfo:cellInfo];

if ([sectionInfo appendingCellInfo:cellInfo atIndex:2333]) {
    // do something
} else {
    // do something
}
```

##### Delete

```objective-c
[sectionInfo removeCellInfo:cellInfo];
[sectionInfo removeCellInfoAtIndex:0];
[sectionInfo removeCellInfoWithAlias:@"forkYou"];
```

##### Replace

```objective-c
[sectionInfo replaceCellInfo:originalCellInfo with:cellInfo];
[sectionInfo replaceCellInfoAtIndex:0 with:cellInfo];
[sectionInfo replaceCellInfoWithAlias:@"forkYou" with:cellInfo];
```

#### WAMDataSource

See a simple demo below on how to use `WAMDataSource` in your codes (For more detailed information please look into `WAMCellInfo`, `WAMSectionInfo` and `WAMDataSource` header files):

```objective-c
#pragma mark - Initialization

static NSString *const kReuseIdentifier     = @"tableViewCellIdentifier";
static NSString *const kIdentifierCellAlias = @"kIdentifierCellAlias";
static NSString *const kSelfDefineCellAlias = @"kSelfDefineCellAlias";

static NSString *const kSectionZeroAlias = @"kSectionZeroAlias";
static NSString *const kSectionOneAlias  = @"kSectionOneAlias";

WAMSectionInfo *zero = [WAMSectionInfo infoWithCellInfos:@[
        [WAMCellInfo infoWithSelfDefineCell:self.customizedCell alias:kSelfDefineCellAlias]
    ] alias:kSectionZeroAlias];

WAMSectionInfo *one = [WAMSectionInfo infoWithCellInfos:@[
        [WAMCellInfo infoWithReuseIdentifier:kReuseIdentifier title:nil detail:nil alias:kIdentifierCellAlias]
    ] alias:@"oneSectionAlias"];

self.dataSource = [WAMDataSource dataSourceWithSectionInfos:@[zero, one]];

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionInfos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.sectionInfos[section].cellInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WAMCellInfo *cellInfo = self.dataSource.sectionInfos[indexPath.section].cellInfos[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfo.identifier forIndexPath:indexPath];

    if ([cellInfo.alias isEqualToString:kSelfDefineCellAlias]) {
        // do something
    } else if ([[self.dataSource indexPathOfCellInfoWithAlias:kIdentifierCellAlias] isEqual:indexPath]) {
        // do something
    }
    .
    .
    .

    return cell;
}

```

## Unit Tests

WAMSimpleDataSource includes unit tests within the WAMSimpleDataSourceTests directory. These tests can be run simply.

## License

WAMSimpleDataSource is released under the MIT license. See LICENSE for details.
