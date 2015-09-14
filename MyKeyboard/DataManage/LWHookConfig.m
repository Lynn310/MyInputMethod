//
// Created by luowei on 15/9/14.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWHookConfig.h"
#import "Aspects.h"
#import "LWDefines.h"


@implementation LWHookConfig {

}

+ (NSDictionary *)hookEventDict {
    return @{
            @"LWToolBar": @{
                    Hook_TrackedEvents: @[
                            @{
                                    Hook_EventName: @"logo按钮点击",
                                    Hook_Option:@(AspectPositionBefore),
                                    Hook_EventSelectorName: @"logoBtnTouchUpInside:",
                                    Hook_EventHandlerBlock: ^(id<AspectInfo> aspectInfo) {
                                Log(@"========logo click hooked =======");
                            },
                            },
                            @{
                                    Hook_EventName: @"emoji按钮点击",
                                    Hook_Option:@(AspectPositionAfter),
                                    Hook_EventSelectorName: @"emojiBtnTouchUpInside:",
                                    Hook_EventHandlerBlock: ^(id<AspectInfo> aspectInfo) {
                                Log(@"========emoji click hooked =======");
                            },
                            },
                    ],
            },

            @"LWSettingPopView": @{
            }
    };
}

@end


@implementation UIResponder(Hook)

+ (void)load {
    [super load];

    [UIResponder setupWithConfiguration:[LWHookConfig hookEventDict]];
}

+ (void)setupWithConfiguration:(NSDictionary *)configs {
    // Hook Events
    for (NSString *className in configs) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configs[className];
        if(clazz==nil || config==nil){
            return;
        }

        if (config[Hook_TrackedEvents]) {
            for (NSDictionary *event in config[Hook_TrackedEvents]) {
                SEL selekor = NSSelectorFromString(event[Hook_EventSelectorName]);
                HookHandlerBlock block = event[Hook_EventHandlerBlock];

                if(selekor==nil || block == nil){
                    return;
                }

                [clazz aspect_hookSelector:selekor
                               withOptions:(AspectOptions) ((NSNumber *)event[Hook_Option]).intValue
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    block(aspectInfo);
                                } error:NULL];

            }
        }
    }
}

@end