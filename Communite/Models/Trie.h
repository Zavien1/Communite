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


@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong ,nonatomic) NSMutableDictionary *head;

- (id)initTrie;
- (void)makeTrie: (NSMutableArray *)wordArray;
- (void)searchPrefix: (NSString *)searchTerm;
- (NSString *)formatString: (NSString *)searchTerm;
- (void *)suggestions: (NSMutableDictionary *)dictionary :(NSString *)accum;

@end

NS_ASSUME_NONNULL_END
