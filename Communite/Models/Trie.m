//
//  Trie.m
//  trie
//
//  Created by Zavien Anthony on 7/28/21.
//

#import "Trie.h"

@implementation Trie

- (id) initTrie{
    self = [super init];
    self.dict = [[NSMutableDictionary alloc] init];
    self.head = [[NSMutableDictionary alloc] init];
    self.suggestedWords = [[NSMutableArray alloc] init];
    self.wordArray = [[NSMutableArray alloc] init];
    self.charArray = [[NSArray alloc] init];

    return self;
}

- (void)makeTrie:(NSMutableArray *)array{
    self.wordArray = array;
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
        [self formatString:self.wordArray[i]];
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
        self.head[@"*"] = self.wordArray[i];
    }
}

- (void)searchPrefix:(NSString *)searchTerm{
    self.suggestedWords = [[NSMutableArray alloc] init];
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
        }
    }
    NSLog(@"%@", self.head);
    [self suggestions:self.head :accum];
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
    NSLog(@"%@", self.suggestedWords);
    return 0;
}

- (NSString *)formatString:(NSString *)word {
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    word = [[word componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    word = [word lowercaseString];
    return word;
}

@end
