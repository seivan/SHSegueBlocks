//
//  NSSetTests.m
//  Example
//
//  Created by Seivan Heidari on 7/25/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHFastEnumerationTests.h"

#import "NSSet+SHFastEnumerationProtocols.h"


@interface NSSetTests : SenTestCase
<SHTestsFastEnumerationBlocks,
SHTestsFastEnumerationProperties>
@property(nonatomic,strong) NSSet           * subject;
@property(nonatomic,strong) NSMutableSet    * matching;

@end


@interface NSSetTests (Private)
<SHTestsHelpers>
@end

@interface NSSetTests (Mutable)
<SHTestsMutableFastEnumerationBlocks>
@end

@implementation NSSetTests


-(void)setUp; {
  [super setUp];
  
  
  self.subject =  [NSSet setWithArray:@[@"one", @"1", @"two",@"2", @"three", @"3", @"one", @"1"]];
  
  self.matching = [NSMutableSet set];
}

-(void)tearDown; {
  [super tearDown];
  
  self.subject = nil;
  self.matching = nil;
}

#pragma mark - <SHTestsFastEnumerationBlocks>
-(void)testEach;{
  [self.subject SH_each:^(id obj) {
    [self.matching addObject:obj];
  }];
  
  STAssertEqualObjects(self.subject, self.matching, nil);
  
}

-(void)testMap;{
  __block NSInteger skipOne = 0;
  self.matching = [self.subject SH_map:^id(id obj) {
    skipOne += 1;
    if(skipOne == 1)
      return nil;
    else
      return obj;
  }].mutableCopy;
  
  self.subject = [self.subject SH_map:^id(id obj) {
    return obj;
  }];
  
  
  STAssertTrue(self.matching.count < self.subject.count, nil);
  STAssertFalse(self.matching.SH_isEmpty, nil);
  
  for (id obj in self.matching)
    STAssertTrue([self.subject containsObject:obj], nil);
  
}

-(void)testReduce;{
  NSMutableString * expected = @"".mutableCopy;
  for (id obj in self.subject) [expected appendFormat:@"%@", obj];
  
  NSMutableString  * matched = [self.subject SH_reduceValue:@"".mutableCopy withBlock:^id(NSMutableString * memo, id obj) {
    [memo appendFormat:@"%@", obj];
    return memo;
  }];
  
  STAssertEqualObjects(expected, matched, nil);
}

-(void)testFind;{
  __block NSInteger counter = 0;
  
  id value = [self.subject SH_find:^BOOL(id obj) {
    counter +=1;
    return (counter == self.subject.count);
  }];
  
  
  STAssertEquals(self.subject.count, (NSUInteger)counter, nil);
  STAssertTrue([self.subject containsObject:value], nil);
  
}

-(void)testFindAll;{
  __block NSInteger counter = 0;
  
  self.matching = [self.subject SH_findAll:^BOOL(id obj) {
    counter +=1;
    return (counter < self.subject.count-1);
  }].mutableCopy;
  
  for (id obj in self.matching) {
    STAssertTrue([self.subject containsObject:obj], nil);
  }
  STAssertTrue(self.matching.count > 0, nil);
  STAssertTrue(self.matching.count < self.subject.count-1, nil);
  
}

-(void)testReject;{
  __block NSInteger counter = 0;
  
  self.matching = [self.subject SH_reject:^BOOL(id obj) {
    counter +=1;
    return (counter < self.subject.count-1);
  }].mutableCopy;
  
  for (id obj in self.matching) {
    STAssertTrue([self.subject containsObject:obj], nil);
  }
  STAssertTrue(self.matching.count > 0, nil);
  STAssertTrue(self.matching.count < self.subject.count-1, nil);
}

-(void)testAll;{
  
  self.matching = self.subject.mutableCopy;
  BOOL testAllTrue = [self.subject SH_all:^BOOL(id obj) {
    return [self.matching containsObject:obj];
  }];
  
  NSMutableSet * subject = self.subject.mutableCopy;
  [subject addObject:@"---"];
  self.subject = subject.copy;
  
  BOOL testAllNotAllTrue = [self.subject SH_all:^BOOL(id obj) {
    return [self.matching containsObject:obj];
  }];
  
  STAssertTrue(testAllTrue, nil);
  STAssertFalse(testAllNotAllTrue, nil);
  
  
}

-(void)testAny;{
  self.matching = self.subject.mutableCopy;
  
  BOOL testAllTrue = [self.subject SH_any:^BOOL(id obj) {
    return [self.matching containsObject:obj];
  }];
  
  
  NSMutableArray * matching = self.matching.SH_toArray.mutableCopy;
  [matching removeLastObject];
  [matching removeLastObject];
  BOOL testAllNotAllTrue = [self.subject SH_any:^BOOL(id obj) {
    return [matching containsObject:obj];
  }];
  
  STAssertTrue(testAllTrue, nil);
  STAssertTrue(testAllNotAllTrue, nil);
  
  
  
  
}

-(void)testNone; {
  self.matching = self.subject.mutableCopy;
  
  BOOL testAllTrue = [self.subject SH_none:^BOOL(id obj) {
    return NO;
  }];
  
  BOOL testAllFalse = [self.subject SH_none:^BOOL(id obj) {
    return YES;
  }];
  
  self.matching = @[].mutableCopy;
  
  if(testAllTrue) [self.matching addObject:@(1)];
  if(testAllFalse == NO) [self.matching addObject:@(2)];
  
  NSArray * matching = (NSArray * )self.matching;
  STAssertTrue([matching containsObject:@(1)], nil);
  STAssertTrue([matching containsObject:@(2)], nil);
  
  
}

#pragma mark - <SHTestsFastEnumerationProperties>
-(void)testIsEmtpy; {
  STAssertFalse(self.subject.SH_isEmpty, nil);
  STAssertTrue(self.matching.SH_isEmpty, nil);
  BOOL isEmpty = self.matching.count == 0;
  STAssertEquals(isEmpty, self.matching.SH_isEmpty, nil);
}

-(void)testToArray; {
  NSArray     * matching = self.subject.SH_toArray;
  NSArray     * subject  = self.subject.allObjects;
  
  STAssertTrue([matching isKindOfClass:[NSArray class]], nil);
  STAssertEqualObjects(subject, matching, nil);
}

-(void)testToSet; {
  STAssertTrue([self.subject.SH_toSet isKindOfClass:[NSSet class]], nil);
  STAssertTrue(self.subject.SH_toSet.count > 0, nil);
  
  for (id obj in self.subject.SH_toSet)
    STAssertTrue([self.subject containsObject:obj], nil);
  
}

-(void)testToOrderedSet; {
  STAssertTrue([self.subject.SH_toOrderedSet  isKindOfClass:[NSOrderedSet class]], nil);
  STAssertTrue(self.subject.SH_toOrderedSet.count > 0, nil);
  
  [self.subject.SH_toOrderedSet enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *_) {
    STAssertTrue([self.subject containsObject:obj], nil);
  }];
  
  
}

-(void)testToDictionary; {
  STAssertTrue([self.subject.SH_toDictionary isKindOfClass:[NSDictionary class]], nil);
  STAssertTrue(self.subject.SH_toDictionary.count > 0, nil);
  
  [self.subject.SH_toDictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber * key, id obj, BOOL *stop) {
    [self.subject containsObject:obj];
    STAssertTrue([self.subject containsObject:obj], nil);
    STAssertNotNil(self.subject.objectEnumerator.allObjects[key.integerValue], nil);
  }];
  
}

-(void)testToMapTableWeakToWeak; {
  [self assertMapTableWithMapTable:self.subject.SH_toMapTableWeakToWeak];
  
}

-(void)testToMapTableWeakToStrong; {
  [self assertMapTableWithMapTable:self.subject.SH_toMapTableWeakToStrong];
}

-(void)testToMapTableStrongToStrong; {
  [self assertMapTableWithMapTable:self.subject.SH_toMapTableStrongToStrong];
}

-(void)testToMapTableStrongToWeak; {
  [self assertMapTableWithMapTable:self.subject.SH_toMapTableStrongToWeak];
}

-(void)testToHashTableWeak; {
  [self assertHashTableWithMapTable:self.subject.SH_toHashTableWeak];
}

-(void)testToHashTableStrong; {
  [self assertHashTableWithMapTable:self.subject.SH_toHashTableStrong];
}

-(void)testAvg; {
  self.matching = [NSMutableSet setWithArray:@[@(0),@(1),@(2),@(3),@(4),@(5)]];
  self.subject  = [NSSet setWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5"]];
  STAssertEqualObjects([self.subject valueForKeyPath:@"@avg.self"],
                       self.matching.SH_collectionAvg, nil);
}

-(void)testSum; {
  self.matching = [NSMutableSet setWithArray:@[@(0),@(1),@(2),@(3),@(4),@(5)]];
  self.subject  = [NSSet setWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5"]];
  STAssertEqualObjects([self.subject valueForKeyPath:@"@sum.self"],
                       self.matching.SH_collectionSum, nil);
  
}

-(void)testMax; {
  self.matching = [NSMutableSet setWithArray:@[@(0),@(1),@(2),@(3),@(4),@(5)]];
  self.subject  = [NSSet setWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5"]];
  
  STAssertEqualObjects([self.subject valueForKeyPath:@"@max.self"], self.subject.SH_collectionMax, nil);
  STAssertEqualObjects([self.matching valueForKeyPath:@"@max.self"], self.matching.SH_collectionMax, nil);
  
}

-(void)testMin; {
  self.matching = [NSMutableSet setWithArray:@[@(0),@(1),@(2),@(3),@(4),@(5)]];
  self.subject  = [NSSet setWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5"]];
  
  STAssertEqualObjects([self.subject valueForKeyPath:@"@min.self"], self.subject.SH_collectionMin, nil);
  STAssertEqualObjects([self.matching valueForKeyPath:@"@min.self"], self.matching.SH_collectionMin, nil);
}


@end

@implementation NSSetTests (Mutable)

#pragma mark - <SHTestsMutableFastEnumerationBlocks>
-(void)testModifyMap; {
  __block NSInteger counter = 0;
  self.matching = self.subject.mutableCopy;
  [self.matching SH_modifyMap:^id(id obj) {
    counter +=1;
    if(counter == 1)
      return obj;
    else
      return nil;
  }];
  
  
  NSInteger expectedCount = 1;
  STAssertTrue(self.matching.count < self.subject.count, nil);
  STAssertEquals(self.matching.count, (NSUInteger)expectedCount, nil);
  
  for (id obj in self.matching) {
    STAssertTrue([self.subject containsObject:obj], nil);
  }
  
  
  
}

-(void)testModifyFindAll; {
  __block NSInteger counter = 0;
  self.matching = self.subject.mutableCopy;
  [self.matching SH_modifyFindAll:^BOOL(id obj) {
    counter +=1;
    if(counter == 1)
      return YES;
    else
      return NO;
  }];
  
  
  NSInteger expectedCount = 1;
  STAssertTrue(self.matching.count < self.subject.count, nil);
  STAssertEquals(self.matching.count, (NSUInteger)expectedCount, nil);
  
  for (id obj in self.matching) {
    STAssertTrue([self.subject containsObject:obj], nil);
  }
  
  
  
}

-(void)testModifyReject; {
  
  __block NSInteger counter = 0;
  self.matching = self.subject.mutableCopy;
  [self.matching SH_modifyReject:^BOOL(id obj) {
    counter +=1;
    if(counter == 1)
      return YES;
    else
      return NO;
  }];
  
  
  NSInteger expectedCount = 1;
  STAssertTrue(self.matching.count < self.subject.count, nil);
  STAssertEquals(self.matching.count, self.subject.count-expectedCount, nil);
  
  for (id obj in self.matching) {
    STAssertTrue([self.subject containsObject:obj], nil);
  }
}


@end


@implementation NSSetTests (Private)
-(void)assertMapTableWithMapTable:(NSMapTable *)theMapTable; {
  
  STAssertTrue([theMapTable isKindOfClass:[NSMapTable class]], nil);
  STAssertTrue(theMapTable.count > 0, nil);
  STAssertTrue(self.subject.count > 0, nil);
  [self.subject SH_each:^(id obj) {
    [theMapTable.objectEnumerator.allObjects containsObject:obj];
  }];
  
}


-(void)assertHashTableWithMapTable:(NSHashTable *)theHashTable; {
  STAssertTrue([theHashTable isKindOfClass:[NSHashTable class]], nil);
  STAssertTrue(theHashTable.count > 0, nil);
  STAssertTrue(self.subject.count > 0, nil);
  [self.subject SH_each:^(id obj) {
    STAssertTrue([theHashTable containsObject:obj], nil);
  }];
  
}


@end