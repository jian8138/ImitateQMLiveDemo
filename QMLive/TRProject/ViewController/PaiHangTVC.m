//
//  PaiHangTVC.m
//  TRProject
//
//  Created by Jian on 2016/11/26.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "PaiHangTVC.h"
#import "RankWeekCell.h"
#define kRankIconPath @"http://www.quanmin.tv%@"

@interface PaiHangTVC ()
@property (nonatomic, strong) NSArray<rankCurrModel*> * allRankCurrs;
@property (nonatomic, strong) NSArray<rankWeekModel*> * allRankWeeks;
@property (nonatomic) NSArray<NSString*>* allRankNumIcons;
@property (nonatomic) UISegmentedControl* segmentCtl;
@end

@implementation PaiHangTVC

#pragma mark - Lazy
-(NSArray<NSString *> *)allRankNumIcons
{
    if (!_allRankNumIcons)
    {
        static NSMutableArray *tempPicArr;
        if (!tempPicArr)
        {
            tempPicArr = [NSMutableArray arrayWithCapacity:10];
            for (NSInteger i = 1; i <= 10; i++)
            {
                NSString *pic = [NSString stringWithFormat:@"rankNumber_icon_%ld_25x25_",i];
                [tempPicArr addObject:pic];
            }
        }
        _allRankNumIcons = tempPicArr.copy;
    }
    return _allRankNumIcons;
}

#pragma mark - Life

-(instancetype)initWithModel:(RoomModel *)model
{
    self = [super init];
    if (self)
    {
        self.allRankCurrs = model.rank_curr;
        self.allRankWeeks = model.rank_week;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[RankWeekCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.segmentCtl = [[UISegmentedControl alloc] initWithItems:@[@"贡献场榜",@"贡献周榜"]];
    _segmentCtl.selectedSegmentIndex = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _segmentCtl.selectedSegmentIndex == 0 ? self.allRankCurrs.count: self.allRankWeeks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.rankNumIV.image = [UIImage imageNamed:self.allRankNumIcons[indexPath.row]];
    cell.contentView.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    if(_segmentCtl.selectedSegmentIndex == 0)
    {
        rankCurrModel *currModel = self.allRankCurrs[indexPath.row];
        NSString *path = [NSString stringWithFormat:kRankIconPath,currModel.icon];
        [cell.iconIV setImageURL:path.lzj_toURL];
        cell.sendNickLB.text = currModel.send_nick;
        cell.likeIV.image = [UIImage imageNamed:@"ic_bofang_ranking_list_naiping_20x20_"];
        cell.scoreLB.hidden = NO;
        cell.scoreLB.text = currModel.score > 10000?[NSString stringWithFormat:@"%.1f万",currModel.score / 10000.0] : [NSString stringWithFormat:@"%ld",currModel.score];
    }
    else
    {
        rankWeekModel *weekModel = self.allRankWeeks[indexPath.row];
        NSString *path = [NSString stringWithFormat:kRankIconPath,weekModel.icon];
        [cell.iconIV setImageURL:path.lzj_toURL];
        cell.sendNickLB.text = weekModel.send_nick;
        if ([weekModel.change isEqualToString:@"up"])
        {
            cell.likeIV.image = [UIImage imageNamed:@"ic_sp_player_paihang_zb_up_20x20_"];
        }
        else if ([weekModel.change isEqualToString:@"down"])
        {
            cell.likeIV.image = [UIImage imageNamed:@"ic_sp_player_paihang_zb_down_20x20_"];
        }
        else
        {
            cell.likeIV.image = [UIImage imageNamed:@"ic_sp_player_paihang_zb_ping_20x20_"];
        }
        cell.scoreLB.hidden = YES;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    view.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    [view addSubview:_segmentCtl];
    [_segmentCtl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    [_segmentCtl setWidth:100 forSegmentAtIndex:0];
    [_segmentCtl setWidth:100 forSegmentAtIndex:1];
    _segmentCtl.tintColor = [UIColor redColor];
    _segmentCtl.layer.borderWidth = 1;
    _segmentCtl.layer.cornerRadius = 15;
    _segmentCtl.clipsToBounds = YES;
    _segmentCtl.layer.borderColor = [UIColor redColor].CGColor;
    [_segmentCtl bk_addEventHandler:^(id sender) {
        [self.tableView reloadData];
    } forControlEvents:UIControlEventValueChanged];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
