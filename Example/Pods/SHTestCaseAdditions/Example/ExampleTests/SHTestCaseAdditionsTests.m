//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/30/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHTestCaseAdditions.h"
#import "SHKeyValueObserverBlocks.h"
#import "SHFastEnumerationProtocols.h"


@interface SHTestCaseAdditionsTests : SenTestCase
@property(nonatomic,strong) NSArray * sampleArray;
@property(nonatomic,strong) NSSet   * sampleSet;
@end

@implementation SHTestCaseAdditionsTests

-(void)setUp;{
  [super setUp];
  NSMutableArray * mutableArray = @[].mutableCopy;
  NSMutableSet   * mutableSet   = @[].SH_toSet.mutableCopy;

  self.sampleArray = mutableArray.SH_toArray;
  self.sampleSet   = mutableSet.SH_toSet;
}

-(void)tearDown;{
  [super tearDown];
}

-(void)testSH_runLoopUntilTestPassesWithBlock_withTimeOut; {
  NSString * keyPath   = @"sampleSet";
  __block BOOL didPass = NO;

  [self SH_addObserverForKeyPaths:@[keyPath].SH_toSet withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    didPass = YES;
  }];

  double delayInSeconds = 2;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [[self mutableSetValueForKey:keyPath] addObject:@"Lol"];
  });

  
  [self SH_runLoopUntilTestPassesWithBlock:^BOOL{
    return didPass;
  } withTimeOut:5];
  
  
  STAssertTrue(didPass, nil);
  
}

-(void)testSH_performAsyncTestsWithinBlock_withTimeout; {
  NSString * keyPath   = @"sampleArray";
  __block BOOL didPass = NO;

  [self SH_performAsyncTestsWithinBlock:^(BOOL *didFinish) {
    
    [self SH_addObserverForKeyPaths:@[keyPath].SH_toSet withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
      didPass    = YES;
      *didFinish = YES;
    }];
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [[self mutableArrayValueForKey:keyPath] addObject:@"Lol"];
    });
    
  } withTimeout:5];
  
  STAssertTrue(didPass, nil);
  
}

@end
