//
//  TImeLineCell.swift
//  MvvmGithubClientApp
//
//  Created by user on 2018/08/16.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation
import UIKit

final class TimeLineCell: UITableViewCell {
    
    private var iconView: UIImageView!
    private var nickNameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
    
        iconView = UIImageView()
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
        
        nickNameLabel = UILabel()
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nickNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = CGRect(x: 15,
                                y: 15,
                                width: 45,
                                height: 45)
        iconView.layer.cornerRadius = iconView.frame.size.height / 2
        
        nickNameLabel.frame = CGRect(x: iconView.frame.maxX + 15,
                                     y: iconView.frame.origin.y,
                                     width: contentView.frame.width - iconView.frame.maxX,
                                     height: 15)
    }
    
    func setNickName(nickName: String) {
        nickNameLabel.text = nickName
    }
    
    func setIcon(icon: UIImage) {
        iconView.image = icon
    }
    
}
