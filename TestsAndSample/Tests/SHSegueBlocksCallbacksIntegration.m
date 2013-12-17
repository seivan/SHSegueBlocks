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
  XCTAssertNotNil(self.firstVc.SH_userInfo);
  XCTAssertTrue(self.firstVc.SH_userInfo.count == 0);
  
  self.firstVc.SH_userInfo = @{@"LOL" : @"xx"}.mutableCopy;
  XCTAssertFalse(self.firstVc.SH_userInfo.count == 0);
}


#pragma mark - Segue performers
-(void)testSH_performSegueWithIdentifier_andPrepareForSegueBlock; {
  __block BOOL didAssert = NO;
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    XCTAssertNotNil(theSegue);
    XCTAssertEqualObjects(self.firstVc, theSegue.sourceViewController);
    didAssert = YES;
  }];
  
  XCTAssertTrue(didAssert);
  [tester waitForViewWithAccessibilityLabel:@"second"];
  
}

-(void)testSH_performSegueWithIdentifier_andDestinationViewController; {
  __block BOOL didAssert = NO;
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andDestinationViewController:^(UIViewController *theDestinationViewController) {
    XCTAssertNotNil(theDestinationViewController);
    XCTAssertFalse(self.firstVc == theDestinationViewController);
    didAssert = YES;
  }];
  

  XCTAssertTrue(didAssert);
  [tester waitForViewWithAccessibilityLabel:@"second"];
  
}

-(void)testSH_performSegueWithIdentifier_withUserInfo; {
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier withUserInfo:@{self.firstSegueIdentifier : @"asd"}];
  UIViewController * vc = self.navCon.viewControllers.lastObject;
  XCTAssertNotNil(vc.SH_userInfo[self.firstSegueIdentifier]);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}


#pragma mark - Helpers
-(void)testSH_handlesBlockForSegueFirst; {
  UIViewController * secondVc = self.navCon.viewControllers.lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andDestinationViewController:^(UIViewController *theDestinationViewController) {
  }];
  XCTAssertTrue([self.firstVc SH_handlesBlockForSegue:segue]);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testSH_handlesBlockForSegueSecond; {
  UIViewController * secondVc = self.navCon.viewControllers.lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    
  }];
  XCTAssertTrue([self.firstVc SH_handlesBlockForSegue:segue]);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testSH_handlesBlockForSegueThird; {
  UIViewController * secondVc = self.navCon.viewControllers.lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.firstSegueIdentifier source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier withUserInfo:nil];
  XCTAssertTrue([self.firstVc SH_handlesBlockForSegue:segue]);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}

-(void)testSH_handlesBlockForSegueNone; {
  UIViewController * secondVc = self.navCon.viewControllers.lastObject;
  UIStoryboardSegue * segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"NewIdentifier" source:self.firstVc destination:secondVc];
  
  
  [self.firstVc SH_performSegueWithIdentifier:self.firstSegueIdentifier andPrepareForSegueBlock:nil];
  XCTAssertFalse([self.firstVc SH_handlesBlockForSegue:segue]);
  [tester waitForViewWithAccessibilityLabel:@"second"];
}


@end
