//
//  MZWeakTimerObject.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/15.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZWeakTimerObject.h"

@interface MZWeakTimerObject ()

@property (nonatomic, weak)  id  aTarget;

@property (nonatomic, assign) SEL aSelector;


@end

@implementation MZWeakTimerObject

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    MZWeakTimerObject *obj = [[MZWeakTimerObject alloc] init];
    obj.aTarget = aTarget;
    obj.aSelector = aSelector;
    
    return [NSTimer timerWithTimeInterval:ti target:obj selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    
}

-(void)fire:(id)obj
{
    [self.aTarget performSelector:self.aSelector withObject:obj];

}

@end
