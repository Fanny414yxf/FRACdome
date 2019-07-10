//
//  ViewController.m
//  RACdome
//
//  Created by cximac on 2019/6/28.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <objc/runtime.h>


// 单体模式实现
#define DELC_SINGLETON(classname) \
+(classname*)instance;

#define IMPL_SINGLETON(classname) \
\
static classname *s_shared##classname = nil; \
\
+ (classname *) instance \
{ \
@synchronized(self) \
{ \
if (s_shared##classname == nil) \
{ \
s_shared##classname = [[self alloc] init]; \
} \
} \
\
return s_shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (s_shared##classname == nil) \
{ \
s_shared##classname = [super allocWithZone:zone]; \
return s_shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \


@implementation LoginManager

//IMPL_SINGLETON(LoginManager);

+ (void)logInWithUsername:(NSString *)username password:(NSString *)password
{
    
}

@end


@interface ViewController ()<UITextFieldDelegate>
{
    BOOL loggedIn;
}

@property (weak, nonatomic) NSString *value;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextF;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextF;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    [self signal];
    
//    [self userInterFace];
    
//    [self RACLoginCase];
    
    [self caseMap2];
    
}

- (void)case1KVO
{
    //键值对监听  RAC封装了kvo机制
    [self.userNameTextF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        self.value = x;
    }];
    
    [RACObserve(self, value) subscribeNext:^(NSString *value) {
        
        NSLog(@"self.value --------- %@",value);
        
    }];
}


//映射  用于把原信号中的内容映射成新的内容
- (void)caseMap2
{
    
   // https://blog.csdn.net/u013232867/article/details/51448382
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:self.userNameTextF.text];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    RAC(self, self.userNameTextF.text) = [signal map:^id _Nullable(id  _Nullable value) {
        if ([value isEqualToString:@"fanny"]) {
            return @"小狮子";
        }
        
        return @"";
    }];
    
    NSLog(@"userNAMETF %@   self.value %@", self.userNameTextF.text, self.value);
    
    
    
    [[self.userNameTextF.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        
        return nil;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@" , x);
    }];
    
    
}

- (void)case3
{
    
}


- (void)case4
{
    
}


- (void)case5
{
    
}


- (void)case6
{
    
}

- (void)case7
{
    
}

- (void)case8
{
    
}

- (void)case9
{
    
}

- (void)case10
{
    
}

- (void)case11
{
    
}


- (void)RACLoginCase
{
    RAC(self.button, enabled) = [RACSignal combineLatest:@[self.userNameTextF.rac_textSignal, self.passWordTextF.rac_textSignal, RACObserve(self, self->loggedIn)]];

    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {


    }];

   RAC(self, self->loggedIn) = [[NSNotificationCenter.defaultCenter
                            rac_addObserverForName:@"DFDF" object:nil]
                           mapReplace:@NO];
    
}



- (void)userInterFace
{
    
//    [RACObserve(self, self.userNameTextF.text) subscribeNext:^(NSString *newName) {
//        NSLog(@"userNameTextF ------ %@", newName);
//        self.nameLabel.text = newName;
//    }];
    
    
    
//    [[RACObserve(self, self.userNameTextF)
//      filter:^(NSString *newName) {
//          return [newName hasPrefix:@"j"];
//      }]
//     subscribeNext:^(NSString *newName) {
//         self.nameLabel.text = newName;
//     }];
    
    
    
//    [self.userNameTextF.rac_textSignal subscribeNext:^(id x){
//        NSLog(@"%@", x);
//        self.nameLabel.text = x;
//    }];
    

    /** 给textfield加信号，监听值变化而操作 */
    __block NSString * valueString;
    [[self.userNameTextF.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        NSString*text = value;
        valueString = value;
//        return text.length < 5;
        return [value containsString:@"j"];
    }]  subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
   
    
    
    
//    NSArray *ARR = @[@"FDSGG", @"fanny", @"sad", @"smile", @"..." ];
//    [ARR.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//
    
    

//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"jtd",@"name",@"man",@"sex",@"jx",@"jg", nil];
//    [dict.rac_sequence.signal subscribeNext:^(id x) {
//        RACTupleUnpack(NSString *key,NSString *value) = x;
//
//        NSLog(@"key:%@,value:%@",key,value);
//    }];
    
    
    
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"点击了 吗");
        [self buttonClick];
        return [RACSignal empty];
    }];
    
    
}

- (void)buttonClick
{
    NSLog(@"确实点击了button");
}



- (void)signal
{
    /**
     *  RACSignal
     *  先订阅 在发送
     */
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送信号");
        [subscriber sendNext:@"ooooo"];
        
        return nil;
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"订阅信号----%@", x);
    }];
    
    
    /*
     必须先订阅  再发送
     */
    RACSubject * subject = [RACSubject subject];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者1----%@", x);
    }];
    
    [subject sendNext:@"subject"];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者2----%@", x);
    }];
    
    [subject sendNext:@"subject 2"];
}


@end
