//
//  NetManager.h
//  TRProject
//
//  Created by tarena on 16/7/14.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "BaseNetworking.h"
#import "RoomModel.h"
#import "RecommendModel.h"
#import "RecommendADModel.h"
#import "SearchModel.h"

@interface NetManager : BaseNetworking

+(id)getOnLineDataWithPage:(NSInteger)page CompletionHandler:(void(^)(OnLineModel *model,NSError *error))completionHandler;

+(id)getCategoryListCompletionHandler:(void(^)(NSArray *model,NSError *error))completionHandler;

+(id)getThemeDataWithSlug:(NSString*)slug Page:(NSInteger)page CompletionHandler:(void(^)(OnLineModel *model,NSError *error))completionHandler;

+(id)getLiveRommDataWithUid:(NSString*)uid CompletionHandler:(void(^)(RoomModel *model,NSError *error))completionHandler;

+(id)getRecommendDataCompletionHandler:(void(^)(RecommendModel *model, NSError *error)) completionHandler;

+(id)getRecommendADCompletionHandler:(void(^)(RecommendADModel *model, NSError *error)) completionHandler;

+(id)postSearchDataWithKey:(NSString*)key Page:(NSInteger)page CompletionHandler:(void(^)(SearchModel *model,NSError *error)) completionHandler;

@end
