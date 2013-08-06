//
//  SHAppDelegate.m
//  Example
//
//  Created by Seivan Heidari on 7/15/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHAppDelegate.h"
#import "SHFastEnumerationProtocols.h"


@interface SHSample : NSObject
@property(nonatomic,strong) NSNumber * thatProperty;
-(instancetype)initWithSample:(NSNumber *)thatProperty;
@end

@implementation SHSample
-(instancetype)initWithSample:(NSNumber *)thatProperty; {
  self = [super init];
  if(self) {
    self.thatProperty = thatProperty;
  }
  return self;
}

@end


@implementation SHAppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;{
  NSArray * array = @[
                      @{@"calories" : @(1)},
                      @{@"calories" : @(11)},
                      @{@"calories" : @(2)},
                      @{@"calories" : @(22)},
                      @{@"calories" : @(3)},
                      @{@"calories" : @(33)},
                      @{@"calories" : @(4)},
                      @{@"calories" : @(5)}
                      ];
  
 NSDictionary * largest= [array SH_reduceValue:nil withBlock:^id(NSDictionary * memo, NSDictionary * obj) {
   NSDictionary * largest = nil;
   if(memo == nil) largest = obj;
    else {
      NSNumber * memoValue = memo[@"calories"];
      NSNumber * objValue = obj[@"calories"];
      if(memoValue.integerValue > objValue.integerValue) largest = memo;
      else largest = obj;
    }
   return largest;
  }];
  
  NSAssert([(NSNumber *)largest[@"calories"] integerValue] == 33, nil);
  
  
}

@end
