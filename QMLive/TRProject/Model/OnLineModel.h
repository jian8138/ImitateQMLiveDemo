//
//  OnLineModel.h
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OnLineDataModel;
@interface OnLineModel : NSObject

@property (nonatomic, strong) NSArray<OnLineDataModel*> * data;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageCount;
//@property (nonatomic, strong) Recommend * recommend;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;

@end

@interface OnLineDataModel : NSObject

@property (nonatomic) NSString* announcement;
@property (nonatomic) NSString* app_shuffling_image;
@property (nonatomic) NSString* avatar;
@property (nonatomic) NSString* beauty_cover;
@property (nonatomic) NSString* category_id;
@property (nonatomic) NSString* category_name;
@property (nonatomic) NSString* category_slug;
@property (nonatomic) NSString* create_at;
@property (nonatomic) NSString* default_image;
@property (nonatomic) NSInteger follow;
@property (nonatomic) NSString* grade;
@property (nonatomic) BOOL hidden;
@property (nonatomic) NSString* icontext;
@property (nonatomic) NSString* intro;
@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger like;
@property (nonatomic) NSString* love_cover;
@property (nonatomic) NSString* nick;
@property (nonatomic) NSString* play_at;
@property (nonatomic) NSString* push_ip;
@property (nonatomic) NSString* recommend_image;
@property (nonatomic) NSInteger screen;
@property (nonatomic) NSString* slug;
@property (nonatomic) NSString* start_time;
@property (nonatomic) NSString* status;
@property (nonatomic) NSString* thumb;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* uid;
@property (nonatomic) NSString* video;
@property (nonatomic) NSString* video_quality;
@property (nonatomic) NSInteger view;
@property (nonatomic) NSString* weight;

@end

