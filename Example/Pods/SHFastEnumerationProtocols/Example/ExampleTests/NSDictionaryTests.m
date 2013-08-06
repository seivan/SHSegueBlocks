//
//  NSDictionaryTests.m
//  Example
//
//  Created by Seivan Heidari on 7/25/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHFastEnumerationTests.h"

#import "NSDictionary+SHFastEnumerationProtocols.h"



@interface NSDictionaryTests : SenTestCase
<SHTestsFastEnumerationBlocks,
SHTestsFastEnumerationProperties
>

@property(nonatomic,strong) NSDictionary        * subject;
@property(nonatomic,strong) NSMutableDictionary * matching;

@end


@interface NSDictionaryTests (Mutable)
<SHTestsMutableFastEnumerationBlocks>
@end

@interface NSDictionaryTests (Private)
<SHTestsHelpers>
@end


@implementation NSDictionaryTests


-(void)setUp; {
  [super setUp];

  self.subject = @{@"one" : @"1", @"two" : @"2", @"three" : @"3", @"oneX" : @"1X"};
  
  self.matching = @{}.mutableCopy;
}

-(void)tearDown; {
  [super tearDown];
  
  self.subject = nil;
  self.matching = nil;
}

#pragma mark - <SHTestsFastEnumerationBlocks>
-(void)testEach;{
  [self.subject SH_each:^(id obj) {
    [self.matching setObject:[self.subject objectForKey:obj] forKey:obj];
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
  
  for (id obj in self.matching) STAssertNotNil([self.subject objectForKey:obj], nil);
  
}

-(void)testReduce;{
  NSMutableString * expected = @"".mutableCopy;
  for (id obj in self.subject) [expected appendFormat:@"%@", obj];
  
  NSMutableArray * keys = @[].mutableCopy;
  NSMutableString  * matched = [self.subject SH_reduceValue:@"".mutableCopy withBlock:^id(NSMutableString * memo, id obj) {
    [keys addObject:obj];
    [memo appendFormat:@"%@", obj];
    return memo;
  }];
  
  for (id obj in keys) STAssertNotNil([self.subject objectForKey:obj], nil);

  STAssertEqualObjects(expected, matched, nil);
}

-(void)testFind;{
  __block NSInteger counter = 0;
  
  id value = [self.subject SH_find:^BOOL(id obj) {
    counter +=1;
    return (counter == self.subject.count);
  }];
  
  
  STAssertEquals(self.subject.count, (NSUInteger)counter, nil);
  STAssertNotNil([self.subject objectForKey:value], nil);
  
}

-(void)testFindAll;{
  __block NSInteger counter = 0;
  
  self.matching = [self.subject SH_findAll:^BOOL(id obj) {
    counter +=1;
    return (counter < self.subject.count-1);
  }].mutableCopy;
  
  for (id obj in self.matching) STAssertNotNil([self.subject objectForKey:obj], nil);

  STAssertTrue(self.matching.count > 0, nil);
  STAssertTrue(self.matching.count < self.subject.count-1, nil);
  
}

-(void)testReject;{
  __block NSInteger counter = 0;
  
  self.matching = [self.subject SH_reject:^BOOL(id obj) {
    counter +=1;
    return (counter < self.subject.count-1);
  }].mutableCopy;
  
  for (id obj in self.matching) STAssertNotNil([self.subject objectForKey:obj], nil);
  STAssertTrue(self.matching.count > 0, nil);
  STAssertTrue(self.matching.count < self.subject.count-1, nil);
}

-(void)testAll;{
  
  self.matching = self.subject.mutableCopy;
  BOOL testAllTrue = [self.subject SH_all:^BOOL(id obj) {
    return [self.matching objectForKey:obj] != nil ;
  }];
  
  NSMutableDictionary * subject =  self.subject.mutableCopy;
  [subject addEntriesFromDictionary:@{@"asd" : @"xxx"}];
  
  BOOL testAllNotAllTrue = [subject SH_all:^BOOL(id obj) {
    return [self.matching objectForKey:obj] != nil ;
  }];
  
  STAssertTrue(testAllTrue, nil);
  STAssertFalse(testAllNotAllTrue, nil);
  
  
}

-(void)testAny;{
  self.matching = self.subject.mutableCopy;
  
  BOOL testAllTrue = [self.subject SH_any:^BOOL(id obj) {
    return [self.matching objectForKey:obj] != nil ;
  }];
  
  
  BOOL testAllNotAllTrue = [self.subject SH_any:^BOOL(id obj) {
    return NO ;
  }];
  
  STAssertTrue(testAllTrue, nil);
  STAssertFalse(testAllNotAllTrue, nil);
  
  
  
  
}

-(void)testNone; {
  self.matching = self.subject.mutableCopy;
  BOOL testAllTrue = [self.subject SH_none:^BOOL(id obj) {
    return [self.matching objectForKey:obj] == nil ;
  }];
  
  
  BOOL testAllNotAllTrue = [self.subject SH_none:^BOOL(id obj) {
    return [self.matching objectForKey:obj] != nil ;
  }];
  
  STAssertTrue(testAllTrue, nil);
  STAssertFalse(testAllNotAllTrue, nil);

  
  
}

#pragma mark - <SHTestsFastEnumerationProperties>
-(void)testIsEmtpy; {
  STAssertFalse(self.subject.SH_isEmpty, nil);
  STAssertTrue(self.matching.SH_isEmpty, nil);
  BOOL isEmpty = self.matching.count == 0;
  STAssertEquals(isEmpty, self.matching.SH_isEmpty, nil);
}

-(void)testToArray; {
  NSArray * matching = self.subject.SH_toArray;
  NSArray * subject  = [self.subject SH_reduceValue:@[].mutableCopy
                                         withBlock:^id(NSMutableArray * memo, id obj) {
                                           
                                           [memo addObject:@[obj, [self.subject objectForKey:obj]]];
                                           return memo;
  }];

  STAssertTrue([matching isKindOfClass:[NSArray class]], nil);
  STAssertTrue(matching.count > 0, nil);
  STAssertEqualObjects(subject, matching, nil);
}

-(void)testToSet; {
  NSSet * matching = self.subject.SH_toSet;
  NSSet * subject  = [self.subject SH_reduceValue:[NSMutableSet set]
                                          withBlock:^id(NSMutableSet * memo, id obj) {
                                            
                                            [memo addObject:
                                             [NSSet setWithArray:@[obj,
                                                                   [self.subject objectForKey:obj]]
                                              ]];
                                            return memo;
                                          }];
  
  STAssertTrue([matching isKindOfClass:[NSSet class]], nil);
  STAssertTrue(matching.count > 0, nil);
  STAssertEqualObjects(subject, matching, nil);
}

-(void)testToOrderedSet; {
  NSOrderedSet * matching = self.subject.SH_toOrderedSet;
  NSOrderedSet * subject  = [self.subject SH_reduceValue:[NSMutableOrderedSet orderedSet]
                                        withBlock:^id(NSMutableOrderedSet * memo, id obj) {
                                          
                                          [memo addObject:
                                           [NSMutableOrderedSet orderedSetWithArray:@[obj,
                                            [self.subject objectForKey:obj]]
                                            ]];
                                          return memo;
                                        }];
  
  STAssertTrue([matching isKindOfClass:[NSOrderedSet class]], nil);
  STAssertTrue(matching.count > 0, nil);
  STAssertEqualObjects(subject, matching, nil);


}

-(void)testToDictionary; {
  STAssertTrue([self.subject.SH_toDictionary isKindOfClass:[NSDictionary class]], nil);
  STAssertTrue(self.subject.SH_toDictionary.count > 0, nil);
    
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
  // Need to figure out how to test weak references.
//  [self assertHashTableWithMapTable:self.subject.SH_toHashTableWeak];
}

-(void)testToHashTableStrong; {
  [self assertHashTableWithMapTable:self.subject.SH_toHashTableStrong];
}


-(void)testAvg; {
  self.subject =  @{@"key1" : @(1) , @"key2" : @(3)};
  STAssertEqualObjects(self.subject.SH_collectionAvg, @(2), nil);
  
}

-(void)testSum; {
  self.subject =  @{@"key1" : @(1) , @"key2" : @(3)};
  STAssertEqualObjects(self.subject.SH_collectionSum, @(4), nil);
  
}

-(void)testMax; {
  self.subject =  @{@"key1" : @(1) , @"key2" : @(3)};
  STAssertEqualObjects(self.subject.SH_collectionMax, @(3), nil);
  
}

-(void)testMin; {
  self.subject =  @{@"key1" : @(1) , @"key2" : @(3)};
  STAssertEqualObjects(self.subject.SH_collectionMin, @(1), nil);
  
}

@end

@implementation NSDictionaryTests (Mutable)

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
  
  for (id obj in self.matching) STAssertNotNil([self.subject objectForKey:obj], nil);
  
  
  
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
  
  for (id obj in self.matching) STAssertNotNil([self.subject objectForKey:obj], nil);  
  
  
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
  
  for (id obj in self.matching) STAssertNotNil([self.subject objectForKey:obj], nil);
}


@end


@implementation NSDictionaryTests (Private)
-(void)assertMapTableWithMapTable:(NSMapTable *)theMapTable; {
  
  STAssertTrue([theMapTable isKindOfClass:[NSMapTable class]], nil);
  STAssertTrue(theMapTable.count > 0, nil);
  STAssertTrue(self.subject.count > 0, nil);
  [self.subject SH_each:^(id obj) {
    STAssertNotNil([theMapTable objectForKey:obj], nil);
  }];
  
}


-(void)assertHashTableWithMapTable:(NSHashTable *)theHashTable; {
  NSHashTable * subject  = [self.subject SH_reduceValue:[[NSHashTable alloc]
                                                         initWithOptions:NSPointerFunctionsStrongMemory
                                                         capacity:20]
                                        withBlock:^id(NSHashTable * memo, id obj) {
                                          NSHashTable * table = [[NSHashTable alloc]
                                                                     initWithOptions:NSPointerFunctionsStrongMemory
                                                                     capacity:20];


                                          [table addObject:obj];
                                          [table addObject:[self.subject objectForKey:obj]];
                                          [memo addObject:table];
                                          return memo;
                                        }];
  
  STAssertTrue([theHashTable isKindOfClass:[NSHashTable class]], nil);
  STAssertTrue(theHashTable.count > 0, nil);
  STAssertEqualObjects(subject, theHashTable, nil);
}


@end