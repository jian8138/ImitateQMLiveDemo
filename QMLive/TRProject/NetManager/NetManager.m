//
//  NetManager.m
//  TRProject
//
//  Created by tarena on 16/7/14.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "NetManager.h"
#define kOnLinePath @"/json/play/list%@.json"
#define kCategoryPath @"/json/categories/list.json"
#define kThemePath @"/json/categories/%@/list%@.json"
#define kRoomLivePath @"/json/rooms/%@/info.json"
#define kRecommendPath @"/json/app/index/recommend/list-iphone.json?1127105609"
#define kRecommendADPath @"/json/page/app-data/info.json"
#define kSearchPath @"/api/v1"

@implementation NetManager

+(id)getOnLineDataWithPage:(NSInteger)page CompletionHandler:(void (^)(OnLineModel *, NSError *))completionHandler
{
    NSString *path = page == 0 ? [NSString stringWithFormat:kOnLinePath,@""] : [NSString stringWithFormat:kOnLinePath,[NSString stringWithFormat:@"_%ld",page]];
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([OnLineModel parse:responseObj],error);
    }];
}

+(id)getCategoryListCompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    return [self GET:kCategoryPath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([CategoryModel parse:responseObj],error);
    }];
}

+(id)getThemeDataWithSlug:(NSString*)slug Page:(NSInteger)page CompletionHandler:(void (^)(OnLineModel *, NSError *))completionHandler
{
    NSString *path = page == 0 ? [NSString stringWithFormat:kThemePath,slug,@""] : [NSString stringWithFormat:kThemePath,slug,[NSString stringWithFormat:@"_%ld",page]];
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([OnLineModel parse:responseObj],error);
    }];
}

+(id)getLiveRommDataWithUid:(NSString *)uid CompletionHandler:(void (^)(RoomModel *, NSError *))completionHandler
{
    NSString *path = [NSString stringWithFormat:kRoomLivePath,uid];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([RoomModel parse:responseObj],error);
    }];
}

+(id)getRecommendDataCompletionHandler:(void (^)(RecommendModel *, NSError *))completionHandler
{
    NSString *path = kRecommendPath;
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([RecommendModel parse:responseObj],error);
    }];
}

+(id)getRecommendADCompletionHandler:(void (^)(RecommendADModel *, NSError *))completionHandler
{
    NSString *path = kRecommendADPath;
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([RecommendADModel parse:responseObj],error);
    }];
}

+(id)postSearchDataWithKey:(NSString *)key Page:(NSInteger)page CompletionHandler:(void (^)(SearchModel *, NSError *))completionHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"site.search" forKey:@"m"];
    [params setObject:@"2" forKey:@"os"];
    [params setObject:@"0" forKey:@"p[categoryId]"];
    [params setObject:key forKey:@"p[key]"];
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"p[page]"];
    [params setObject:@"10" forKey:@"p[size]"];
    [params setObject:@"1.3.2" forKey:@"v"];
    
    return [self POST:kSearchPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([SearchModel parse:responseObj],error);
    }];
}









@end
