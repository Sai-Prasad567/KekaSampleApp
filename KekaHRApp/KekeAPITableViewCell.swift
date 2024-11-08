//
//  KekeAPITableViewCell.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import UIKit

class KekaAPITableViewCell: UITableViewCell {
    
    let tLabel = UILabel()
    let dLabel = UILabel()
    let dateLabel = UILabel()
    let image = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        tLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        tLabel.numberOfLines = 0
        tLabel.lineBreakMode = .byWordWrapping
        tLabel.textColor = .black
        
        dLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        dLabel.numberOfLines = 0
        dLabel.lineBreakMode = .byWordWrapping
        dLabel.textColor = .blue
        
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        dateLabel.numberOfLines = 0
        dateLabel.lineBreakMode = .byWordWrapping
        dateLabel.textColor = .orange
        
        self.contentView.addSubview(tLabel)
        self.contentView.addSubview(dLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(image)
        
        tLabel.addConstraint(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        dLabel.addConstraint(top: tLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        dateLabel.addConstraint(top: dLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        image.addConstraint(top: dateLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0),size: CGSize(width: 30, height: 30))
    }
    
    func configure(_ model: APIModel) {
        tLabel.text = model.headline.main
        dLabel.text = model.abstract
        dateLabel.text = model.pubDate.formatDate(from: model.pubDate)
        if let url = model.multimedia.first?.url {
            image.setImage(urlString: url)
        }
    }
}
