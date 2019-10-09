//
//  EpisodesCell.h
//  RickAndMorty
//
//  Created by macbook  on 8.10.2019.
//  Copyright © 2019 meksconway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EpisodesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *episodeName;
@property (weak, nonatomic) IBOutlet UILabel *episode;
@property (weak, nonatomic) IBOutlet UILabel *airDate;

@end

