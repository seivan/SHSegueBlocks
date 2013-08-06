//
//  SHEnumerationTests.h
//  Example
//
//  Created by Seivan Heidari on 7/22/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>




#pragma mark - <SHTestsFastEnumerationBlocks>
@protocol SHTestsFastEnumerationBlocks <NSObject>
@required
-(void)testEach;
-(void)testMap;
-(void)testReduce;
-(void)testFind;
-(void)testFindAll;
-(void)testReject;
-(void)testAll;
-(void)testAny;
-(void)testNone;
@end

#pragma mark - <SHTestsFastEnumerationProperties>
@protocol SHTestsFastEnumerationProperties <NSObject>
@required
-(void)testIsEmtpy;
-(void)testToArray;
-(void)testToSet;
-(void)testToOrderedSet;
-(void)testToDictionary;
-(void)testToMapTableWeakToWeak;
-(void)testToMapTableWeakToStrong;
-(void)testToMapTableStrongToStrong;
-(void)testToMapTableStrongToWeak;
-(void)testToHashTableWeak;
-(void)testToHashTableStrong;
-(void)testAvg;
-(void)testSum;
-(void)testMax;
-(void)testMin;

@end

#pragma mark - <SHTestsFastEnumerationOrderedBlocks>
@protocol SHTestsFastEnumerationOrderedBlocks <NSObject>
@required
-(void)testEachWithIndex;
@end

#pragma mark - <SHTestsFastEnumerationOrderedProperties>
@protocol SHTestsFastEnumerationOrderedProperties <NSObject>
@required
-(void)testFirstObject;
-(void)testLastObject;
@end

#pragma mark - <SHTestsFastEnumerationOrdered>
@protocol SHTestsFastEnumerationOrdered <NSObject>
@required
-(void)testReverse;
@end

#pragma mark - <SHTestsMutableFastEnumerationBlocks>
@protocol SHTestsMutableFastEnumerationBlocks <NSObject>
@required
-(void)testModifyMap;
-(void)testModifyFindAll;
-(void)testModifyReject;
@end

#pragma mark - <SHTestsMutableFastEnumerationOrdered>
@protocol SHTestsMutableFastEnumerationOrdered <NSObject>
@required
-(void)testModifyReverse;
-(void)testPopObjectAtIndex;
-(void)testPopFirstObject;
-(void)testPopLastObject;
@end

#pragma mark - <SHTestsHelpers>
@protocol SHTestsHelpers <NSObject>
@required
-(void)assertMapTableWithMapTable:(NSMapTable *)theMapTable;
-(void)assertHashTableWithMapTable:(NSHashTable *)theHashTable;
@end
