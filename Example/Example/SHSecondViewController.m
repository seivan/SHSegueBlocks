//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"

@interface SHSecondViewController ()
-(IBAction)tapProgUnwind:(id)sender;

@end

@implementation SHSecondViewController
@synthesize name;

-(IBAction)tapProgUnwind:(id)sender; {
  //[self performSegueWithIdentifier:@"unwinder" sender:self];
  [self SH_performSegueWithIdentifier:@"unwinder" withUserInfo:@{@"name" : @"Used the userinfo!"}];
}


-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  NSLog(@"Sent here by identifier; %@", self.name);
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
//  NSLog(@"SHSecondViewController prepareForSegue %@ - %@", sender, segue);
//}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender NS_AVAILABLE_IOS(6_0); {
//  NSLog(@"SHSecondViewController shouldPerformSegueWithIdentifier %@ - %@", sender, identifier);
  return YES;
  
}// Invoked immediately prior to initiating a segue. Return NO to prevent the segue from firing. The default implementation returns YES. This method is not invoked when -performSegueWithIdentifier:sender: is used.

// View controllers will receive this message during segue unwinding. The default implementation returns the result of -respondsToSelector: - controllers can override this to perform any ancillary checks, if necessary.
- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender NS_AVAILABLE_IOS(6_0); {
//  NSLog(@"SHSecondViewController canPerformUnwindSegueAction %@ %@ - %@", NSStringFromSelector(action), sender, fromViewController);
  
  return [self respondsToSelector:action];
}



@end
