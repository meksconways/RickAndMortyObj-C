//
//  EpisodesVC.m
//  RickAndMorty
//
//  Created by macbook  on 8.10.2019.
//  Copyright © 2019 meksconway. All rights reserved.
//

#import "EpisodesVC.h"
#import "EpisodesCell.h"
#import "EpisodeModel.h"

NSString *cellId = @"episodeCellId";
NSString *episodeURL = @"https://rickandmortyapi.com/api/episode";

@interface EpisodesVC ()

@property (strong, nonatomic) NSMutableArray<EpisodeModel *> *episodes;
@property (strong,nonatomic) UIActivityIndicatorView *indicator;


@end

@implementation EpisodesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchEpisodes];
    [self setupUI];
}

- (void) setupUI{
    self.clearsSelectionOnViewWillAppear = YES;
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.indicator startAnimating];
    self.tableView.backgroundView = self.indicator;
    self.tableView.tableFooterView = [UIView.new initWithFrame:CGRectZero];
}

- (void) fetchEpisodes{
    
    NSURL *url = [NSURL URLWithString:episodeURL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        
        NSDictionary *rootJsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (err) {
            NSLog(@"Error: %@",err);
            return;
        }
        
        NSMutableArray <EpisodeModel *> *arr = NSMutableArray.new;
        
        NSArray *results = rootJsonObj[@"results"];
        
        for (NSDictionary *res in results){
            
            EpisodeModel *tempModel = [[EpisodeModel alloc] init];
            tempModel.episodeName = res[@"name"];
            tempModel.episode = res[@"episode"];
            tempModel.airDate = res[@"air_date"];
            
            [arr addObject:tempModel];
            
        }
        
        self.episodes = arr;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
  
    }] resume];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _episodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EpisodesCell *cell = (EpisodesCell *) [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    EpisodeModel *model = _episodes[indexPath.row];
    
    if (cell != nil){
        cell.episodeName.text = model.episodeName;
        cell.episode.text = model.episode;
        cell.airDate.text = model.airDate;
    }
    
    return cell;
}



@end
