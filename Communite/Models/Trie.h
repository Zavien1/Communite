//
//  Trie.h
//  trie
//
//  Created by Zavien Anthony on 7/28/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trie : NSObject

@property (strong, nonatomic) NSMutableArray *wordArray;
@property (strong, nonatomic) NSMutableArray *suggestedWords;
@property (strong, nonatomic) NSArray *charArray;
@property (strong, nonatomic) NSString* word1;
@property (strong, nonatomic) NSString* word2;
@property (strong, nonatomic) NSString* word3;
@property (strong, nonatomic) NSString* word4;
@property (strong, nonatomic) NSString* word5;
@property (strong, nonatomic) NSString* word6;



@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong ,nonatomic) NSMutableDictionary *head;

- (void)initTrie;
- (void)searchPrefix;
- (void *)suggestions: (NSMutableDictionary *)dictionary :(NSString *)accum;



@end

NS_ASSUME_NONNULL_END
