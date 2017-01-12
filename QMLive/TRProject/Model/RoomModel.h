//
//  RoomModel.h
//  TRProject
//
//  Created by Jian on 2016/11/24.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveModel;
@class rankCurrModel;
@class rankWeekModel;
@interface RoomModel : NSObject
@property (nonatomic, strong) NSArray * admins;
@property (nonatomic, strong) NSString * announcement;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * category_id;
@property (nonatomic, strong) NSString * category_name;
@property (nonatomic, assign) NSInteger follow;
@property (nonatomic, assign) BOOL forbid_status;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, strong) NSArray * hot_word;
@property (nonatomic, strong) NSString * intro;
@property (nonatomic, assign) BOOL is_star;
@property (nonatomic, strong) NSString * last_play_at;
@property (nonatomic, strong) LiveModel * live;//
@property (nonatomic, strong) NSString * nick;
@property (nonatomic, strong) NSArray * notice;
@property (nonatomic, strong) NSString * play_at;
@property (nonatomic, assign) BOOL play_status;
@property (nonatomic, assign) BOOL police_forbid;
@property (nonatomic, strong) NSArray<rankCurrModel*> * rank_curr;//
@property (nonatomic, strong) NSArray * rank_total;
@property (nonatomic, strong) NSArray<rankWeekModel*> * rank_week;//
@property (nonatomic, strong) NSArray * room_lines;
@property (nonatomic, strong) NSString * screen;
@property (nonatomic, strong) NSString * slug;
@property (nonatomic, strong) NSObject * special;
@property (nonatomic, strong) NSString * thumb;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString * video;
@property (nonatomic, strong) NSString * video_quality;
@property (nonatomic, assign) NSInteger view;
@property (nonatomic, assign) BOOL warn;
@property (nonatomic, assign) NSInteger watermark;
@property (nonatomic, strong) NSString * watermark_pic;
@property (nonatomic, assign) NSInteger weight;
@end

@class WsModel;
@interface LiveModel : NSObject
@property (nonatomic) WsModel* ws;//
@end

@class HlsModel;
@interface WsModel : NSObject
@property (nonatomic) NSString* def_mobile;
@property (nonatomic) NSString* def_pc;
//@property (nonatomic) FlvModel* flv;
@property (nonatomic) HlsModel* hls;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* v;
@end

@class liveURLModel;
@interface HlsModel : NSObject
@property (nonatomic) liveURLModel* zero;//zero = 0
@property (nonatomic) liveURLModel* one;//one = 1
@property (nonatomic) liveURLModel* two;//two = 2
@property (nonatomic) liveURLModel* three;//three = 3
@property (nonatomic) liveURLModel* four;//four = 4
@property (nonatomic) liveURLModel* five;//five = 5
@property (nonatomic) liveURLModel* six;//six = 6
@property (nonatomic) NSInteger main_mobile;
@property (nonatomic) NSInteger main_pc;
@end

@interface liveURLModel : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* src;
@end

@interface rankCurrModel : NSObject
@property (nonatomic) NSString* avatar;
@property (nonatomic) NSString* icon;
@property (nonatomic) NSString* rank;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSString* send_nick;
@property (nonatomic) NSString* send_uid;
@end

@interface rankWeekModel : NSObject
@property (nonatomic) NSString* avatar;
@property (nonatomic) NSString* icon;
@property (nonatomic) NSString* rank;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSString* send_nick;
@property (nonatomic) NSString* send_uid;
@property (nonatomic) NSString* change;
@property (nonatomic) NSString* icon_url;

@end



