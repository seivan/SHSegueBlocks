//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "KIF.h"
#import "SHTestCaseAdditions.h"
#import "SHSegueBlocks.h"


#import "SHViewController.h"
#import "SHSecondViewController.h"
@interface SHSegueBlocksSuper : KIFTestCase
@property(nonatomic,strong) NSString                 * firstSegueIdentifier;
@property(nonatomic,strong) UINavigationController   * navCon;
@property(nonatomic,strong) SHViewController         * firstVc;
@property(nonatomic,strong) SHSecondViewController   * secondVc;
@end

