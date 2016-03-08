//
//  PYInputCoreService.h
//  MyInputMethod
//
//  Created by luowei on 16/3/8.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 输入法内核服务类
@interface PYInputCoreService : NSObject

/// 初始化
+ (BOOL)Init;

// 反初始化
+ (BOOL)Uninit;

/**
 * 搜索候选词
 @param [in] str，搜索字符串
 @return 搜索是否成功
 */
+ (BOOL)SearchCandidate:(NSString *)str;

/**
 * 返回候选数目
 @return 返回候选个数
 */
+ (int)GetCandidateCount;

/**
 * 获取编码字符串
 @return 返回编码字符串字符串
 */
+ (NSString *)GetCompositionString;

/**
 * 获取候选
 @param [in] pos，获取候选的起点，从0开始
 @param [in] count，获取候选的个数
 @param [out] candidateArray，候选结果
 @return 获取是否成功
 */
+ (NSMutableArray *)GetCandidate:(int)pos candidateCount:(int)count;

/**
 * 选择候选
 @param [in] pos，选择候选的起点，从0开始
 @return 选择候选是否成功
 */
+ (BOOL)ChooseCandidate:(int)pos;

/**
 * 是否可以上屏
 @return 可以上屏返回true，否则返回false
 */
+ (BOOL)CanCommit;

/**
 * 获取上屏字符串
 @return 返回上屏字符串
 */
+ (NSString *)GetCommitString;

/**
 * 寻找预估候选
 @param [in] selectedCandidateIndex，选择候选的索引，从0开始
 @param [in] firstPredict，是否首次预估
 @return 返回预估候选数目
 */
+ (int)SearchPredictCandidate:(int)selectedCandidateIndex FirstPredict:(BOOL)firstPredict;

/**
 * 获取预估候选
 @param [in] pos，获取候选的起点，从0开始
 @param [in] count，获取候选的个数
 @param [out] candidateArray，候选结果
 @return 获取是否成功
 */
+ (NSMutableArray *)GetPredictCandidate:(int)pos candidateCount:(int)count;

/**
 * 取侧边栏候选信息
 @param [out] candidateArray 侧边栏候选信息
 @return 获取是否成功
 */
+ (NSMutableArray *)GetSidebarCandidate;

/**
 * 处理选择候选栏拼音
 @param [in] sidebarIndex 候选栏索引
 @param [out] candidateResult 候选结果
 @return 返回选择候选栏拼音后的候选数目
 */
+ (int)SelectSidebar:(int)sidebarIndex;

/**
 * 退格删除尾部字符
 @return 删除是否成功
 */
+ (int)BackspaceChar;

/**
 * 重置输入
 @return 重置是否成功
 */
+ (void)Reset;

/**
 * 升级用户词库，每次安装新版本时调用一次
 @return 升级成功/失败
 */
+ (BOOL)UpdateWordlib;

@end


