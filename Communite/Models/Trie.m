//
//  Trie.m
//  trie
//
//  Created by Zavien Anthony on 7/28/21.
//

#import "Trie.h"

@implementation Trie{
}

- (void)initTrie{
    self.word1 = @"hello";
    self.word2 = @"goodbye";
    self.word3 = @"morning";
    self.word4 = @"afteroon";
    self.word5 = @"goodnight";
    self.word6 = @"good";
    
    
    self.wordArray = [NSMutableArray arrayWithObjects:self.word1,self.word2,self.word3,self.word4,self.word5,self.word6, nil];
    self.suggestedWords = [[NSMutableArray alloc] init];
    self.charArray = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];
    self.dict = [[NSMutableDictionary alloc] init];
    //    self.dict[@""] = self.charArray;
    
    int i;
    for(i = 0; i < [self.charArray count]; i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]  init];
        self.dict[self.charArray[i]] = dictionary;
    }
    int j;
    for(i = 0; i < [self.wordArray count]; i++){
        unsigned int len = [self.wordArray[i] length];
        unichar buffer[len];
        [self.wordArray[i] getCharacters:buffer range:NSMakeRange(0, len)];
        self.head = self.dict;
        for(j = 0; j < len; ++j) {
            unichar current = buffer[j];
            NSString *curr = [NSString stringWithFormat:@"%c", current];
            if(self.head[curr]){
                self.head = self.head[curr];
            }   else{
                self.head[curr] = [[NSMutableDictionary alloc] init];
                self.head = self.head[curr];
            }
        }
        self.head[@"*"] = @"";
    }
}

- (void)searchPrefix{
    NSString *searchTerm = @"good";
    NSString *accum = @"";
    int i;
    self.head = self.dict;
    
    unsigned int len = [searchTerm length];
    unichar buffer[len];
    [searchTerm getCharacters:buffer range:NSMakeRange(0, len)];
    
    for(i = 0; i < len; i++){
        NSString *curr = [NSString stringWithFormat:@"%c", buffer[i]];
        accum = [accum stringByAppendingString:curr];
        if(self.head[curr]){
            self.head = self.head[curr];
        } else{
            //            return -1;
        }
    }
    NSLog(@"%@", self.head);
    [self suggestions:self.head :accum];
    
    NSLog(@"%@", self.suggestedWords);
}

- (void *)suggestions:(NSMutableDictionary *)dictionary :(NSString *)accum{
    if([dictionary isKindOfClass:[NSString class]]){
        self.suggestedWords = [self.suggestedWords arrayByAddingObject:accum];
        return 0;
    }
    NSArray *keys = [dictionary allKeys];
    int i;
    for(i = 0; i < [keys count]; i++){
        self.head = dictionary;
        NSString *newString = accum;
        NSString *key = [NSString stringWithFormat:@"%@", keys[i]];
        self.head = self.head[key];
        newString = [newString stringByAppendingString:key];
        [self suggestions:self.head :newString];
    }
//    for(i = 0; i < [keys count]; i++){
//        if([key isEqualToString:@"*"]){
//            self.suggestedWords = [self.suggestedWords arrayByAddingObject:accum];
//        }
//        else {
//            dictionary = dictionary[key];
//            NSLog(@"%@", key);
//            accum = [accum stringByAppendingString:key];
//            NSLog(@"%@", accum);
//            if([dictionary isKindOfClass:[NSString class]] ){
//                return 0;
//            } else{
//                [self suggestions:dictionary :accum];
//                return 0;
//
//            }
//        }
//    }
    return 0;
}

@end
