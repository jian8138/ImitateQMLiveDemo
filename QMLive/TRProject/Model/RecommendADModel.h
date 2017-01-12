//
//  RecommendADModel.h
//  TRProject
//
//  Created by Jian on 2016/11/29.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppFocusModel;
@interface RecommendADModel : NSObject
@property (nonatomic) NSArray<AppFocusModel*>* app_focus;// == app-focus
@end

@interface AppFocusModel : NSObject
@property (nonatomic) NSString* content;
@property (nonatomic) NSString* create_at;
//@property (nonatomic) NSString* ext;
@property (nonatomic) NSString* fk;
//@property (nonatomic) NSString* id;
@property (nonatomic) NSString* link;
//@property (nonatomic) NSString* link_object;
@property (nonatomic) NSString* priority;
@property (nonatomic) NSString* slot_id;
@property (nonatomic) NSString* status;
@property (nonatomic) NSString* subtitle;
@property (nonatomic) NSString* thumb;
@property (nonatomic) NSString* title;

@end
