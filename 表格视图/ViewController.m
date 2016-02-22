//
//  ViewController.m
//  表格视图
//
//  Created by wjyMac on 15/12/4.
//  Copyright (c) 2015年 wjyMac. All rights reserved.
//

#import "ViewController.h"
#import "ListChartView.h"
@interface ViewController ()<ListChartViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ListChartView *chartView = [[ListChartView alloc]initWithFrame:CGRectMake(10, 40, 300, 400)];
    chartView.textFont = [UIFont systemFontOfSize:10.0f];
    chartView.textColor = [UIColor blackColor];
    chartView.backgroundColor = [UIColor yellowColor];
    chartView.listBackgroundColor = [UIColor whiteColor];
    chartView.delegate = self;
    chartView.cornerRadius = 2.5f;
    [self.view addSubview:chartView];
    
}
-(CGRect)boundsForList:(ListChartView *)list
{
    return CGRectInset(list.bounds, 20, 20);
}
-(UIColor *)listChart:(ListChartView *)list borderColorForRow:(NSInteger)row column:(NSInteger)column
{
    if (row==column)
    {
        return [UIColor orangeColor];
    }
    if (row==4)
    {
        return [UIColor magentaColor];
    }
    return nil;
}
-(CGSize)listChart:(ListChartView *)list itemSizeForRow:(NSInteger)row column:(NSInteger)column
{
    if (row==0&&column==0)
    {
        return CGSizeMake([list itemDefaultSize].width, [list itemDefaultSize].height*2.0f);
    }
    else if(row==1&&column==0)
    {
        ///宽度占位不能少
        return CGSizeMake([list itemDefaultSize].width, 0);
    }
    return [list itemDefaultSize];
}
-(NSInteger)rowForList:(ListChartView *)list
{
    return 8;
}
-(NSInteger)columnForList:(ListChartView *)list
{
    return 10;
}
-(UIColor *)listChart:(ListChartView *)list backgroundColorForRow:(NSInteger)row column:(NSInteger)column
{
    if (row==0&&column==0)
    {
        return [UIColor lightGrayColor];
    }
    else if (row==([self rowForList:list]-1)&&column==0)
    {
        return [UIColor cyanColor];
    }
    else if (row==0&&column==([self columnForList:list]-1))
    {
        return [UIColor purpleColor];
    }
    else if (row==([self rowForList:list]-1)&&column==([self columnForList:list]-1))
    {
        return [UIColor brownColor];
    }
    else if ((row+column)==8)
    {
        return [UIColor blueColor];
    }
    return nil;
}
-(NSString *)listChart:(ListChartView *)list textForRow:(NSInteger)row column:(NSInteger)column
{
    if (row==column)
    {
        return @"相等";
    }
    if (row>1&&row>column)
    {
        return @"大";
    }
    if (row<6&&row<column)
    {
        return @"小";
    }
    return nil;
}
-(UIColor*)listChart:(ListChartView *)list textColorForRow:(NSInteger)row column:(NSInteger)column
{
    if (column==4)
    {
        return [UIColor redColor];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
