//
//  UIViewController+SHSegueBlock.m
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIViewController+SHSegueBlock.h"

@interface SHSegueBlockManager : NSObject
@property(nonatomic,strong) NSMapTable * mapBlocks;
@property(nonatomic,strong) NSMapTable * mapUserInfo;
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
    self.mapBlocks      = [NSMapTable weakToWeakObjectsMapTable];
    self.mapUserInfo    = [NSMapTable weakToStrongObjectsMapTable];
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
@property(nonatomic,readonly) NSMapTable * mapBlocks;
@property(nonatomic,readonly) NSMapTable * mapUserInfo;

@end

@implementation UIViewController (SHSegueBlock)

-(NSMutableDictionary *)SH_userInfo; {
  NSMutableDictionary * userInfo = [self.mapUserInfo objectForKey:self];
  if(userInfo == nil){
    userInfo = @{}.mutableCopy;
    self.SH_userInfo = userInfo;
  }
  return userInfo;
}

-(void)setSH_userInfo:(NSMutableDictionary *)userInfo; {
  if(userInfo)
    [self.mapUserInfo setObject:userInfo forKey:self];
  else
    [self.mapUserInfo removeObjectForKey:self];
}
- (void)SH_performSegueWithIdentifier:(NSString *)identifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock; {
  NSMutableDictionary * blocks = [self.mapBlocks objectForKey:self];
  if(blocks == nil) blocks = @{}.mutableCopy;
  if(theBlock) blocks[identifier] = [theBlock copy];
  [self.mapBlocks setObject:blocks forKey:self];
  [self performSegueWithIdentifier:identifier sender:self];
}

- (void)SH_performSegueWithIdentifier:(NSString *)identifier
                         withUserInfo:(NSDictionary *)theUserInfo; {
  [self SH_performSegueWithIdentifier:identifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    UIViewController * destinationViewController = theSegue.destinationViewController;
    destinationViewController.SH_userInfo = [theUserInfo mutableCopy];
  }];
}

//- (void)SH_performSegueWithIdentifier:(NSString *)identifier
//      andPrepareUserInfoForSegueBlock:(SHPrepareUserInfoForSegue)theBlock; {
//  [self SH_performSegueWithIdentifier:identifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
//    UIViewController * destionationViewController = theSegue.destinationViewController;
//    theBlock(destionationViewController.userInfo);
//  }];
//}

-(NSMapTable *)mapBlocks; {
  return SHSegueBlockManager.sharedManager.mapBlocks;
}
-(NSMapTable *)mapUserInfo; {
  return SHSegueBlockManager.sharedManager.mapUserInfo;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {

  NSLog(@"SHSegueBlock.h prepareForSegue  %@ - %@", self, sender);
  NSMutableDictionary * blocks = [SHSegueBlockManager.sharedManager.mapBlocks objectForKey:self];
  SHPrepareForSegue block = blocks[segue.identifier];
  if(block) block(segue);
//  [blocks removeObjectForKey:segue.identifier];
  [SHSegueBlockManager.sharedManager.mapBlocks setObject:blocks forKey:self];

}
#pragma clang diagnostic pop


#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 5.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"USERINFO %@",self.mapUserInfo);
    NSLog(@"BLOCK %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

@end
