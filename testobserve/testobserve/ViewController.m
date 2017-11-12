//
//  ViewController.m
//  testobserve
//
//  Created by Niil Öhlin on 2017-11-12.
//  Copyright © 2017 Niil Öhlin. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "Observer.h"
static void *observingContext = &observingContext;

@interface ViewController ()
@property ViewModel *viewModel;
@property UITextField *usernameTextField;
@property Observer *observer;
@property NSString *test;
@property NSString *test2;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _viewModel = [[ViewModel alloc] init];
    _observer = [[Observer alloc] init];

    [_observer observeSelector:@selector(test) onObject:self didChange:^(NSString *newString) {
        NSLog(@"holy fuck!, newString: %@", newString);
    }];
    [_observer observeSelector:@selector(test2) onObject:self didChange:^(NSString *newString) {
        NSLog(@"test2!, newString: %@", newString);
    }];
    [_observer observeSelector:@selector(test) onObject:self didChange:^(NSString *newString) {
        NSLog(@"overwrite!, newString: %@", newString);
    }];

    self.test = @"din mamma";
    self.test2 = @"kalas";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end