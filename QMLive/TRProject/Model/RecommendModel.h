//
//  RecommendModel.h
//  TRProject
//
//  Created by Jian on 2016/11/28.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecoRoomModel,RecoRoomListModel;
@interface RecommendModel : NSObject

@property (nonatomic, strong) NSArray *ad;

@property (nonatomic, strong) NSArray<RecoRoomModel *> *room;

@end

@interface RecoRoomModel : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, assign) NSInteger is_default;

@property (nonatomic, assign) NSInteger ID;//ID = id

@property (nonatomic, copy) NSString *category_more;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<RecoRoomListModel *> *list;

@property (nonatomic, copy) NSString *name;

@end

@interface RecoRoomListModel : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger play_true;

@property (nonatomic, assign) BOOL is_shield;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, copy) NSString *last_play_at;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, assign) BOOL check;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *love_cover;

@property (nonatomic, assign) NSInteger play_count;

@property (nonatomic, assign) NSInteger view;

@property (nonatomic, assign) NSInteger grade;

@property (nonatomic, copy) NSString *beauty_cover;

@property (nonatomic, copy) NSString *last_thumb;

@property (nonatomic, assign) NSInteger coin;

@property (nonatomic, copy) NSString *default_image;

@property (nonatomic, assign) NSInteger max_view;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, assign) NSInteger anniversary;

@property (nonatomic, assign) NSInteger like;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *recommend_image;

@property (nonatomic, copy) NSString *video;

@property (nonatomic, copy) NSString *last_end_at;

@property (nonatomic, copy) NSString *first_play_at;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *category_slug;

@end

