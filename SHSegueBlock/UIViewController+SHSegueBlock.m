//
//  UIViewController+SHSegueBlock.m
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIViewController+SHSegueBlock.h"

@interface SHSegueBlockManager : NSObject
@property(nonatomic,strong) NSMapTable          * mapBlocks;

#pragma mark -
#pragma mark Singleton Methods
+(instancetype)sharedManager;
@end


@implementation SHSegueBlockManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks = [NSMapTable weakToStrongObjectsMapTable];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHSegueBlockManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHSegueBlockManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}
@end

@interface UIViewController ()

@end

@implementation UIViewController (SHSegueBlock)
- (void)SH_performSegueWithIdentifier:(NSString *)identifier
           andPrepareForSegueBlock:(SHSegueBlockPrepareForSegue)theBlock; {
  NSMutableDictionary * blocks = [SHSegueBlockManager.sharedManager.mapBlocks objectForKey:self];
  if(blocks == nil) blocks = @{}.mutableCopy;
  blocks[identifier] = [theBlock copy];
  [SHSegueBlockManager.sharedManager.mapBlocks setObject:blocks forKey:self];
  [self performSegueWithIdentifier:identifier sender:self];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  NSLog(@"SHSegueBlock.h prepareForSegue  %@ - %@", self, sender);
  NSMutableDictionary * blocks = [SHSegueBlockManager.sharedManager.mapBlocks objectForKey:self];
  SHSegueBlockPrepareForSegue block = blocks[segue.identifier];
  if(block) block(segue);
  [blocks removeObjectForKey:segue.identifier];
  [SHSegueBlockManager.sharedManager.mapBlocks setObject:blocks forKey:self];
  

}
#pragma clang diagnostic pop


@end
