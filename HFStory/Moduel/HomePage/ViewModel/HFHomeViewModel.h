//
//  HFHomeViewModel.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/25.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFStoryViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFHomeViewModel : NSObject
@property (nonatomic, assign, readonly, getter=isUsernameValid) BOOL usernameValid;
@property (nonatomic, strong, readonly) NSString *userFullName;
@property (nonatomic, strong, readonly) UIImage *userAvatarImage;
@property (nonatomic, strong) NSArray<HFStoryViewModel*> *storys;
@property (nonatomic, assign, readonly) BOOL allStorysLoaded;

@property (nonatomic, strong, readwrite) NSString *username;
@property (nonatomic, strong, readwrite) NSString *dateString;
- (void) getStorysForCurrentUsername;
- (void) loadMoreStorys;
-(void)requestWithDate:(NSString*) dateStr;
+(instancetype)HFHomeViewModelWithDate:(NSString*)date;

@end

NS_ASSUME_NONNULL_END
