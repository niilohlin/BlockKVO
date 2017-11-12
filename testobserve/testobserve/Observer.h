//
// Created by Niil Öhlin on 2017-11-12.
// Copyright (c) 2017 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Observer : NSObject
- (void)observeSelector:(SEL)aSelector onObject:(id)object didChange:(void (^)(id))block;
@end