//
//  main.m
//  LearnOC
//
//  Created by 王籽涵 on 2020/6/6.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]) {
    dispatch_group_t group = dispatch_group_create();

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    dispatch_queue_t queue=dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);

       for (int j=0; j<100; j++) {

           dispatch_group_async(group, queue, ^{

              NSString *url=@"https://www.baidu.com";

              [self.manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {



              } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

                 NSLog(@"%d",j);//顺序打印

                 dispatch_semaphore_signal(semaphore);

              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                 NSLog(@"%d",j);//顺序打印

                 dispatch_semaphore_signal(semaphore);

              }];

              dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

           });

       }

    dispatch_group_notify(group, queue, ^{

       //所有请求返回数据后执行

    });
}
