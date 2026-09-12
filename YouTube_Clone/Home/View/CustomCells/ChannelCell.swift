//
//  ChannelCell.swift
//  YouTube_Clone
//
//  Created by Adrian Flores Herrera on 7/16/26.
//

import UIKit
import Kingfisher

class ChannelCell: UITableViewCell {

    @IBOutlet weak var chanelInfoLabel: UILabel!
    @IBOutlet weak var susbriberNumberLabel: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        
   
    }
    
    func configView() {
        bellImage.image =  UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate)
        bellImage.tintColor = UIColor(named: "grayColor")
        profileImage.layer.cornerRadius = 51 / 2
    }

    func configCell(model : ChannelModel.Items) {
        
        chanelInfoLabel.text = model.snippet.description
        channelTitle.text = model.snippet.title
        susbriberNumberLabel.text = "\(model.statistics?.subscriberCount ?? "0") subscribers . \(model.statistics?.videoCount ?? "0") videos"
        
        if let bannerUrl = model.brandingSettings?.image.bannerExternalUrl, let url = URL(string: bannerUrl) {
            bannerImage.kf.setImage(with: url)
        }
        
        let imageUrl = model.snippet.thumbnails.medium.url
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        profileImage.kf.setImage(with: url)
        
    }
    
}
