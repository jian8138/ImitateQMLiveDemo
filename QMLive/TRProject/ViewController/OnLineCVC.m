//
//  OnLineCVC.m
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "OnLineCVC.h"
#import "OnLineCell.h"
#import "UIView+CartoonBottom.h"
#import "RoomVC.h"

@interface OnLineCVC ()

@property (nonatomic) NSMutableArray* allOnLineDatas;
@property (nonatomic) NSInteger page;

@property (nonatomic) TRNoNetView* nonetView;

@end

@implementation OnLineCVC

#pragma mark - Lazy

-(NSMutableArray *)allOnLineDatas
{
    if (!_allOnLineDatas)
    {
        _allOnLineDatas = [NSMutableArray array];
    }
    return _allOnLineDatas;
}

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

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Life

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //为了防止iphone7plus 横屏进入时，长边被认为是宽的问题
    //强制获取宽 和 高 中小的 作为宽

    CGFloat width = (long)((MIN(kScreenH, kScreenW) - 30)/2.0);
    CGFloat height = width * 338/576.0 + 35;
    layout.itemSize = CGSizeMake(width, height);
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    [self.collectionView registerClass:[OnLineCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    
    [TRFactrory addSearchItemToVC:self WithAction:^{
        [self.navigationController pushViewController:[[SearchCVC alloc]init] animated:YES];
    }];
}

-(void)netStateChanged:(NSNotification *)noti
{
    NSLog(@"网络状态变化");
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

-(void)refreshContent
{
    //首次加载时的动画
    [self.view showLoadPic];
    [NetManager getOnLineDataWithPage:0 CompletionHandler:^(OnLineModel *model, NSError *error) {
        if(!error)
        {
            [self.view hideHUD];
            [self.allOnLineDatas addObjectsFromArray:model.data];
            [self.collectionView reloadData];
        }
    }];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    MJWeakSelf
    //使用__weak 来解决block中的循环引用问题
    [self.collectionView addHeaderRefresh:^{
        [NetManager getOnLineDataWithPage:0 CompletionHandler:^(OnLineModel *model, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if(!error)
            {
                [weakSelf.allOnLineDatas removeAllObjects];
                [weakSelf.allOnLineDatas addObjectsFromArray:model.data];
                [weakSelf.view showMsg:@"加载完成"];
                [weakSelf.collectionView reloadData];
                weakSelf.page = 0 ;
            }
            [NSTimer bk_scheduledTimerWithTimeInterval:.25 block:^(NSTimer *timer) {
                [weakSelf.collectionView configHeaderRefresh];
            } repeats:NO];
        }];
    }];
    
    [self.collectionView addFooterRefresh:^{
        [NetManager getOnLineDataWithPage:self.page + 1 CompletionHandler:^(OnLineModel *model, NSError *error) {
            [weakSelf.collectionView endFootRefresh];
            if (!error)
            {
                [weakSelf.allOnLineDatas addObjectsFromArray:model.data];
                [weakSelf.view showMsg:@"加载完成"];
                [weakSelf.collectionView reloadData];
                weakSelf.page += 1;
            }
        }];
    }];
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allOnLineDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OnLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    OnLineDataModel *model = self.allOnLineDatas[indexPath.item];
    
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
    OnLineDataModel *model = self.allOnLineDatas[indexPath.item];
    RoomVC *rvc = [[RoomVC alloc] initWithUid:model.uid];
    [self.navigationController pushViewController:rvc animated:YES];
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
