//
//  SearchModel.h
//  TRProject
//
//  Created by Jian on 2016/12/2.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchDataModel,DataItemsModel;
@interface SearchModel : NSObject

@property (nonatomic, strong) SearchDataModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface SearchDataModel : NSObject

@property (nonatomic, strong) NSArray<DataItemsModel *> *items;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger pageNb;

@end

@interface DataItemsModel : NSObject

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) BOOL is_shield;

@property (nonatomic, assign) NSInteger view;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, copy) NSString *category_slug;

@end

