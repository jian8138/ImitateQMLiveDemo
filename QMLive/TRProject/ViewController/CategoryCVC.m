//
//  CategoryCVC.m
//  TRProject
//
//  Created by Jian on 2016/11/21.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "CategoryCVC.h"
#import "CategoryCell.h"
#import "ThemeCVC.h"
#import "UIView+CartoonBottom.h"

@interface CategoryCVC ()

@property (nonatomic) NSArray<CategoryModel*>* allCategoryList;
@property (nonatomic) TRNoNetView* nonetView;

@property (nonatomic) NSMutableArray<NSString *>* imageNames;
@property (nonatomic) UIImageView* iconIV;

@end

@implementation CategoryCVC

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

#pragma mark - Life
-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat width = (long)((MIN(kScreenH, kScreenW) - 30)/3.0);
    CGFloat height = width * 495/384.0;
    layout.itemSize = CGSizeMake(width, height);
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        
    }
    return self;
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    if (kIsOnline)
    {
        [self refreshContent];
    }
    else
    {
        self.nonetView.hidden = NO;
    }
    
    [TRFactrory addSearchItemToVC:self WithAction:^{
        [self.navigationController pushViewController:[[SearchCVC alloc]init] animated:YES];
    }];
}

-(void)refreshContent
{
    //首次加载时的动画
    [self.view showLoadPic];
    [NetManager getCategoryListCompletionHandler:^(NSArray *model, NSError *error)  {
        if(!error)
        {
            [self.view hideHUD];
            self.allCategoryList = model;
            [self.collectionView reloadData];
        }
    }];
    
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [NetManager getCategoryListCompletionHandler:^(NSArray *model, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (!error)
            {
                weakSelf.allCategoryList = model;
                [weakSelf.collectionView reloadData];
            }
            [NSTimer bk_scheduledTimerWithTimeInterval:.25 block:^(NSTimer *timer) {
                [weakSelf.collectionView configHeaderRefresh];
            } repeats:NO];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
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
    return self.allCategoryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CategoryModel *model = self.allCategoryList[indexPath.item];
    
    [cell.imageIV setImageURL:model.thumb.lzj_toURL];
    cell.nameLB.text = model.name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = self.allCategoryList[indexPath.item];
    
    ThemeCVC *tCVC = [[ThemeCVC alloc] initWithSlug:model.slug andName:model.name];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tCVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view addCartoonBottomWithScrollView:scrollView];
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
