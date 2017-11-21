//
// Created by Niil Öhlin on 2017-11-12.
// Copyright (c) 2017 ___FULLUSERNAME___. All rights reserved.
//

#import "Observer.h"


@implementation Observer {
    void *objectContext;
    NSMutableDictionary *_observationblocks;
}

- (instancetype)init {
    self = [super init];
    objectContext = &objectContext;
    _observationblocks = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)observeSelector:(SEL)aSelector onObject:(id)object didChange:(void (^)(id))block {
    NSString *selectorString = NSStringFromSelector(aSelector);
    NSValue *value = [NSValue valueWithNonretainedObject:object];
    NSMutableDictionary *selectorDict = _observationblocks[value];
    if (!selectorDict) {
        selectorDict = [[NSMutableDictionary alloc] init];
        _observationblocks[value] = selectorDict;
    }
    if (!selectorDict[selectorString]) {
        selectorDict[selectorString] = [[NSMutableArray alloc] init];
        [object addObserver:self forKeyPath:selectorString options:NSKeyValueObservingOptionNew context:objectContext];
    }
    NSMutableArray *blocks = selectorDict[selectorString];
    [blocks addObject:block];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    NSValue *value = [NSValue valueWithNonretainedObject:object];
    NSArray *blocks = _observationblocks[value][keyPath];
    id newValue = change[NSKeyValueChangeNewKey];
    [blocks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        void (^block)(id) = obj;
        block(newValue);
    }];
}

- (void)dealloc {
    [_observationblocks enumerateKeysAndObjectsUsingBlock:^(NSValue *key, NSDictionary *selectorDict, BOOL *stop) {
        [selectorDict enumerateKeysAndObjectsUsingBlock:^(NSString *selectorString, id block, BOOL *stop) {
            if (key.nonretainedObjectValue) {
                [key.nonretainedObjectValue removeObserver:self forKeyPath:selectorString context:objectContext];
            }
        }];
    }];
}

@end