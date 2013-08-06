//
//  SHActionSheetBlocksCallbacksScenarion.m
//  Example
//
//  Created by Seivan Heidari on 7/31/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSegueBlocksSuper.h"


@interface SHSegueBlocksCallbacksIntegration : SHSegueBlocksSuper

@end

@implementation SHSegueBlocksCallbacksIntegration

#pragma mark - Properties
-(void)testSH_userInfo; {
  STAssertNotNil(self.firstVc.SH_userInfo, nil);
  STAssertTrue(self.firstVc.SH_userInfo.SH_isEmpty, nil);
  
  self.firstVc.SH_userInfo = @{@"LOL" : @"xx"}.mutableCopy;
  STAssertFalse(self.firstVc.SH_userInfo.SH_isEmpty, nil);
}


#pragma mark - Segue performers
-(void)testSH_performSegueWithIdentifier_andPrepareForSegueBlock; {
  __block BOOL didAssert = NO;
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    STAssertNotNil(theSegue, nil);
    STAssertEqualObjects(self.firstVc, theSegue.sourceViewController, nil);
    didAssert = YES;
  }];
  
  STAssertTrue(didAssert, nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
  
}

-(void)testSH_performSegueWithIdentifier_andDestinationViewController; {
  __block BOOL didAssert = NO;
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andDestinationViewController:^(UIViewController *theDestinationViewController) {
    STAssertNotNil(theDestinationViewController, nil);
    STAssertFalse(self.firstVc == theDestinationViewController, nil);
    didAssert = YES;
  }];
  
  STAssertTrue(didAssert, nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
  
}

-(void)testSH_performSegueWithIdentifier_withUserInfo; {
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier withUserInfo:@{self.firstSegueIdentifier : @"asd"}];
  UIViewController * vc = self.navCon.viewControllers.SH_lastObject;
  STAssertNotNil(vc.SH_userInfo[self.firstSegueIdentifier], nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}


#pragma mark - Helpers
-(void)testSH_handlesBlockForSegueFirst; {
  UIViewController * secondVc = self.navCon.viewControllers.SH_lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andDestinationViewController:^(UIViewController *theDestinationViewController) {
  }];
  STAssertTrue([self.firstVc SH_handlesBlockForSegue:segue], nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testSH_handlesBlockForSegueSecond; {
  UIViewController * secondVc = self.navCon.viewControllers.SH_lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    
  }];
  STAssertTrue([self.firstVc SH_handlesBlockForSegue:segue], nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testSH_handlesBlockForSegueThird; {
  UIViewController * secondVc = self.navCon.viewControllers.SH_lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier withUserInfo:nil];
  STAssertTrue([self.firstVc SH_handlesBlockForSegue:segue], nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testSH_handlesBlockForSegueNone; {
  UIViewController * secondVc = self.navCon.viewControllers.SH_lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:nil];
  STAssertFalse([self.firstVc SH_handlesBlockForSegue:segue], nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testUnwind; {
  __block BOOL didAssert = NO;
  __block UIViewController * destVc = nil;
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    destVc = theSegue.destinationViewController;
    STAssertNotNil(theSegue, nil);
    STAssertEqualObjects(self.firstVc, theSegue.sourceViewController, nil);
    didAssert = YES;
  }];
  
  STAssertTrue(didAssert, nil);
  [tester waitForViewWithAccessibilityLabel:@"second"];
  
  [destVc SH_performSegueWithIdentifier:@"second" withUserInfo:@{@"seivan" : @"lol"}];
  [tester waitForViewWithAccessibilityLabel:@"first"];
  STAssertNotNil(self.firstVc.SH_userInfo[@"seivan"], nil);
  
}

@end
