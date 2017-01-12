//
//  RecommendCVC.m
//  TRProject
//
//  Created by Jian on 2016/11/28.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RecommendCVC.h"
#import "OnLineCell.h"
#import "UIView+CartoonBottom.h"
#import "RcommendADHeaderView.h"
#import "RcommendHeaderView.h"
#import "RcommendFooterView.h"
#import "RoomVC.h"
#import "ThemeCVC.h"
#import "RecommendADModel.h"
#import "iCarousel.h"

@interface RecommendCVC ()<UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource>
@property (nonatomic) TRNoNetView* nonetView;
@property (nonatomic) RecommendModel* allRcommendDatas;
@property (nonatomic) RecommendADModel* allRecommendADs;
@property (nonatomic) iCarousel* ic;
@property (nonatomic) UIPageControl* pageC;
@property (nonatomic) NSTimer* scrollADTimer;

@property (nonatomic) NSMutableArray* showMuArr;

@end

@implementation RecommendCVC

#pragma mark - Lazy
-(TRNoNetView *)nonetView
{
    if (!_nonetView)
    {
        _nonetView = [[TRNoNetView alloc] initWithRefreshBlock:^{
            if (kIsOnline)
            {
                self.nonetView.hidden = YES;
                [self refreshContent];
            }
            else
            {
                [self.view showMsg:@"try again"];
            }
        }];
        [self.view addSubview:_nonetView];
        [_nonetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _nonetView;
}

- (NSMutableArray *)showMuArr
{
    if(_showMuArr == nil) {
        _showMuArr = [NSMutableArray array];
    }
    return _showMuArr;
}


static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Life

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat width = (long)((MIN(kScreenH, kScreenW) - 30)/2.0);
    CGFloat height = width * 338/576.0 + 35;
    layout.itemSize = CGSizeMake(width, height);
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    layout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 20);
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[OnLineCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[RcommendADHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RcommendADHeaderView"];
    [self.collectionView registerClass:[RcommendHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collectionView registerClass:[RcommendFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    if (kIsOnline)
    {
        [self refreshContent];
    }
    else
    {
        self.nonetView.hidden = NO;
    }
    //向通知中心中注册 监听网络状态的变化
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStateChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

-(void)netStateChanged:(NSNotification *)noti
{
    self.nonetView.hidden = YES;
    [self viewDidLoad];
}

-(void)refreshContent
{
    //首次加载时的动画
    [self.view showLoadPic];
    
    [NetManager getRecommendADCompletionHandler:^(RecommendADModel *model, NSError *error) {
        if (!error)
        {
            self.allRecommendADs = model;
            [NetManager getRecommendDataCompletionHandler:^(RecommendModel *model, NSError *error) {
                if(!error)
                {
                    [self.view hideHUD];
                    self.allRcommendDatas = model;
                    [self createShowArr];//创建要显示出来的数组
                    [self.collectionView reloadData];
                }
            }];
        }
    }];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    MJWeakSelf
    //使用__weak 来解决block中的循环引用问题
    [self.collectionView addHeaderRefresh:^{
        [NetManager getRecommendDataCompletionHandler:^(RecommendModel *model, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if(!error)
            {
                weakSelf.allRcommendDatas = model;
                [weakSelf.collectionView reloadData];
            }
            [NSTimer bk_scheduledTimerWithTimeInterval:.25 block:^(NSTimer *timer) {
                [weakSelf.collectionView configHeaderRefresh];
            } repeats:NO];
        }];
    }];
}

-(void)createShowArr
{
    NSArray *nameArr = @[@"精彩推荐",@"颜值控",@"全民星秀",@"全民户外",@"英雄联盟"];
    for (RecoRoomModel *model in _allRcommendDatas.room)
    {
        for (NSString *name in nameArr)
        {
            if ([name isEqualToString:model.name])
            {
                [self.showMuArr addObject:model];
            }
        }
    }
    [self.showMuArr insertObject:@"" atIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.showMuArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) return 0;
    RecoRoomModel *model = self.showMuArr[section];
    return model.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OnLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    RecoRoomModel *room = self.showMuArr[indexPath.section];
    RecoRoomListModel *model = room.list[indexPath.item];
    
    [cell.thumbIV setImageURL:model.thumb.lzj_toURL];
    
    NSTextAttachment *strAtt = [[NSTextAttachment alloc]init];
    strAtt.image = [UIImage imageNamed:@"player_audienceCount_icon_10x10_"];
    strAtt.bounds = CGRectMake(1, -2, 10, 10);
    NSAttributedString *str1 = [NSAttributedString attributedStringWithAttachment:strAtt];
    
    NSString *text = model.view > 10000 ? [NSString stringWithFormat:@" %.1lf万",model.view/10000.0] : [NSString stringWithFormat:@" %ld",model.view];
    NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]init];
    [muStr appendAttributedString:str1];
    [muStr appendAttributedString:str2];
    
    cell.viewLB.attributedText = muStr;
    [cell.avatarIV setImageURL:model.avatar.lzj_toURL];
    cell.nickLB.text = model.nick;
    cell.titleLB.text = model.title;

    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecoRoomModel *room = self.showMuArr[indexPath.section];
    RecoRoomListModel *model = room.list[indexPath.item];
    RoomVC *rvc = [[RoomVC alloc] initWithUid:[NSString stringWithFormat:@"%ld",model.uid]];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 30)/2.0);
    CGFloat height = width * 338/576.0 + 35;
    RecoRoomModel *room = self.showMuArr[indexPath.section];
    
    if ([room.name isEqualToString:@"颜值控"])
    {
        return CGSizeMake(width, width);
    }
    return CGSizeMake(width, height);
}

#pragma mark - 配置表头相关

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if([kind isEqualToString:UICollectionElementKindSectionHeader])
        {//组头
            RcommendADHeaderView *adHv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RcommendADHeaderView" forIndexPath:indexPath];
            self.ic = [adHv viewWithTag:100];
            if (!_ic)
            {
                _ic = [[iCarousel alloc] init];
                _ic.tag = 100;
                [adHv addSubview:_ic];
            }
            [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(0);
            }];
            _ic.delegate = self;
            _ic.dataSource = self;
            _ic.type = 0;
            _ic.scrollSpeed = 0;
            
            _pageC = [adHv viewWithTag:101];;
            if (!_pageC)
            {
                _pageC = [[UIPageControl alloc] init];
                _pageC.tag = 101;
                [adHv addSubview:_pageC];
            }
            _pageC.numberOfPages = _allRecommendADs.app_focus.count;
            [_pageC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-5);
                make.bottom.equalTo(5);
            }];
            
            [_scrollADTimer invalidate];
            _scrollADTimer = nil;
            _scrollADTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeItem:) userInfo:nil repeats:YES];
            return adHv;
        }
        else
        {//组脚
            return nil;
        }
    }
    else
    {
        if([kind isEqualToString:UICollectionElementKindSectionHeader])
        {//组头
            RcommendHeaderView *hv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            RecoRoomModel *room = self.showMuArr[indexPath.section];
            hv.nameLB.text = room.name;
            [hv contentBtn];
//            为右上方按钮添加事件,下为自己写的方法
//            [hv.contentBtn removeAllTargets];
//            [hv.contentBtn bk_addEventHandler:^(id sender) {
//                NSLog(@"%ld",indexPath.section);
//                ThemeCVC *tCVC = [[ThemeCVC alloc] initWithSlug:room.slug andName:room.name];
//                [self.navigationController pushViewController:tCVC animated:YES];
//            } forControlEvents:UIControlEventTouchUpInside];
            //老师推荐方法
            hv.contentBtn.enabled = room.slug.length;
            [hv setClickBlock:^(RcommendHeaderView *hv) {
                ThemeCVC *tCVC = [[ThemeCVC alloc] initWithSlug:room.slug andName:room.name];
                [self.navigationController pushViewController:tCVC animated:YES];
            }];
            return hv;
        }
        else
        {//组脚
            RcommendFooterView *fv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            return fv;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 550/1200.0);
    return  CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == _showMuArr.count - 1) return CGSizeZero;
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 20);
}

-(void)changeItem:(NSTimer*)timer
{
    [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view addCartoonBottomWithScrollView:scrollView];
}

#pragma mark - icDelegate
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _allRecommendADs.app_focus.count;
}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    AppFocusModel *model = _allRecommendADs.app_focus[index];
    if (!view)
    {
        view = [[UIImageView alloc]initWithFrame:carousel.bounds];
    }
    [(UIImageView *)view setImageURL:model.thumb.lzj_toURL] ;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        RoomVC *rvc = [[RoomVC alloc] initWithUid:model.fk];
        [self.navigationController pushViewController:rvc animated:YES];
    }];
    [view addGestureRecognizer:tap];
    return view;
}
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //如果询问的是 是否循环滚动，则返回yes
    if (option == iCarouselOptionWrap)
    {
        return YES;
    }
    return value;
}
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //currentItemIndex当前显示的内容的索引值
    _pageC.currentPage = carousel.currentItemIndex;
}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



@end
