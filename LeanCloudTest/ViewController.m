//
//  ViewController.m
//  LeanCloudTest
//
//  Created by zhougj on 15/6/9.
//  Copyright (c) 2015年 iiseeuu. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "WToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self insertData];
//    [self queryData];
//    [self registerUserName:@"hxy12" passwd:@"898989" ];
 
    
//    [self loginWithUserName:@"hxy" passwd:@"898989"];
}

#pragma mark - login/register/findPW
//注册(填写手机号码-->发送SMS-->拿到短信验证码验证-->成功注册)
- (void)registerUserName:(NSString *)name passwd:(NSString *)passwd
{
    AVUser *user = [AVUser user];
    user.username = name;
    user.password = passwd;
    user.email = @"test@qq223.com";
    user.mobilePhoneNumber = @"18951741030";
    
    [AVOSCloud requestSmsCodeWithPhoneNumber:user.mobilePhoneNumber appName:@"LTest" operation:nil timeToLive:4 callback:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [WToast showWithText:@"短信已发出"];
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded)
                {
                    [WToast showWithText:[NSString stringWithFormat:@"注册成功%@",user.mobilePhoneNumber]];
                }
                else
                {
                    [WToast showWithText:[NSString stringWithFormat:@"注册失败%@",error]];
                }
            }];
        }
        else
        {
            [WToast showWithText:[NSString stringWithFormat:@"短信发送失败%@",error]];
        }

    }];
}


//拿到短信验证码，进行相应的验证
- (void)verifySMSCode:(NSString *)smsCode withNum:(NSString *)mobileNum
{
    [AVOSCloud verifySmsCode:smsCode mobilePhoneNumber:mobileNum callback:^(BOOL succeeded, NSError *error) {
        
    }];
}


//登录
- (void)loginWithUserName:(NSString *)name passwd:(NSString *)passwd
{
    [AVUser logInWithUsernameInBackground:name password:passwd block:^(AVUser *user, NSError *error) {
        if (!error)
        {
            
        }
        else
        {
            
        }
    }];
    
    
    
    
    //缓存当前用户对象
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser)
    {
        //允许用户实用
    }
    else
    {
        //为nil，用户可打开用户注册界面
    }
    
    //清除缓存用户对象
    [AVUser logOut];
    
}

- (void)operationPasswd
{
    //重置密码
    [AVUser requestEmailVerify:@"test@qq.com" withBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    
    //修改密码
    [AVUser logInWithUsernameInBackground:@"" password:@"111111" block:^(AVUser *user, NSError *error) {
        
    }];
    
    [[AVUser currentUser] updatePassword:@"111111" newPassword:@"222222" block:^(id object, NSError *error) {
        
    }];
    
}

//插入
- (void)insertData
{
    //数据存储
    //AVObject 128KB最大
    
//    String 字符串
//    Number 数字
//    Boolean 布尔类型
//    Array 数组
//    Object 或者 Pointer 对象
//    Date 日期
//    Bytes base64编码的二进制数据
//    File 文件
//    Null 空值
//    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
//    [testObject setObject:@"bar" forKey:@"foo"];
//    [testObject save];
//    
//    AVObject *testLean = [AVObject objectWithClassName:@"TestLeanCloud"];
//    [testLean setObject:@"zgj" forKey:@"name"];
//    [testLean save];
    
//    AVFile 保存文件(图片、视频、文档)
    NSData *data = [@"hello Worldsdfds" dataUsingEncoding:NSUTF8StringEncoding];
    AVFile *file = [AVFile fileWithName:@"hello.txt" data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    
    AVObject *jobApplication = [AVObject objectWithClassName:@"JobApplication"];
    [jobApplication setObject:@"Joe Smith" forKey:@"applicantName"];
    [jobApplication setObject:file         forKey:@"applicantResumeFile"];
    [jobApplication saveInBackground];

    AVFile *applicant = [jobApplication objectForKey:@"applicantResumeFile"];
    NSData *resumData = [applicant getData];
    NSString *saveStr = [[NSString alloc] initWithData:resumData encoding:NSUTF8StringEncoding];
    
}

//AVQuery 查询
//CQL 查询
- (void)queryData
{
    AVQuery *query = [AVQuery queryWithClassName:@"TestLeanCloud" predicate:nil];
    NSArray *array = [query findObjects];
    for (AVObject *object in array)
    {
        NSString *value = [object valueForKey:@"name"];
    }
    
    
    //CQL
    {
        NSString *cql1 = @"select * from TestObject";
        AVCloudQueryResult *result = [AVQuery doCloudQueryWithCQL:cql1];
        NSString *className = result.className; //TestObject
        for (AVObject *object in result.results)
        {
            NSLog(@"foo 的值为%@",[object valueForKey:@"foo"]);
        }
    }

    //查询AVfile
    {
        NSString *cql1 = @"select * from _File";
        AVCloudQueryResult *result = [AVQuery doCloudQueryWithCQL:cql1];
        for (AVObject *object in result.results)
        {
            NSString *textURL = [object objectForKey:@"url"];
            AVFile *file = [AVFile fileWithURL:textURL];
            NSData *resumData = [file getData];
            NSString *saveStr = [[NSString alloc] initWithData:resumData encoding:NSUTF8StringEncoding];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
