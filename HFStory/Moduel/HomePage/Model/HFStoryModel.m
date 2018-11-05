//
//  HFStoryModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/17.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFStoryModel.h"

@implementation HFStoryModel
+(instancetype)storyModelWithDictionary:(NSDictionary *)dic
{
    //[[[dics objectEnumerator] nextObject] ]
    NSString *string =  [NSString stringWithFormat:@"{\"headerImageUrl\":\"http://xxx.com/a.mp4\",\"creatTime\":\"%@\",\"storyTitle\":\"普通故事\",\"isOriginal\":\"1\",\"name\":\"西窗不眠\",\"story\":[{\"section\":[{\"type\":\"text\",\"content\":\"第一段第一个素材?\\n悲哀！\\n悲哀！\\n悲哀！\\n悲哀！\\n悲哀！\"}, {\"type\": \"pic\", \"content\":\"https://img1.doubanio.com/view/photo/albumcover/public/p2519255768.jpg\"}, {\"type\":\"text\", \"content\":\"第一段结尾\"}]},{\"section\":[{\"type\":\"text\",\"content\":\"第二段开头\"}, {\"type\": \"pic\", \"content\":\"https://img3.doubanio.com/view/photo/albumcover/public/p2519057573.jpg\"},{\"type\":\"text\",\"content\":\"第二段结尾\\n换一行\"}]}]}",dic];
    if ([dic isEqual:@"teshu"]) {
        string = [NSString stringWithFormat:@"{\"headerImageUrl\":\"http://xxx.com/a.mp4\",\"creatTime\":\"%@\",\"storyTitle\":\"特殊故事\",\"isOriginal\":\"1\",\"name\":\"长淮望断\",\"story\":[{\"section\":[{\"type\":\"text\",\"content\":\"第一段第一个素材，怎么可以这么炸想我这样聪明的人,早就告别我就不信怎么可以这m炸!!!!!!!!!!!!!!我就不信\"}, {\"type\": \"pic\", \"content\":\"https://img1.doubanio.com/view/photo/sqs/public/p2531032009.jpg\"}, {\"type\":\"text\", \"content\":\"没有结尾\"}]},{\"section\":[{\"type\":\"text\",\"content\":\"第二段开头\"}]}]}",dic];
    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // NSArray *array = [dics mutableArrayValueForKey:@"section"];
    HFStoryModel *sm = [HFStoryModel yy_modelWithJSON:data];
    return sm;
    
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"storySectionArray" : [HFStorySectionModel class]};
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
        return @{@"storySectionArray":@"story",
                 @"nickName"  : @"name",
                 @"desc"  : @"ext.desc",
                 @"bookID": @[@"id", @"ID", @"book_id"]};
    
}
@end

@implementation HFStorySectionModel
+(instancetype)storySectionModeWithDictionary:(NSDictionary *)dic
{
    return nil;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"storySectionElementArray" : [HFStoryElementModel class]};
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"storySectionElementArray":@"section",
             @"nickName"  : @"name",
             @"desc"  : @"ext.desc",
             @"bookID": @[@"id", @"ID", @"book_id"]};
    
}
@end
@implementation HFStoryElementModel

@end
