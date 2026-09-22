//
//  PlaylistCell.swift
//  YouTube_Clone
//
//  Created by Adrian Flores Herrera on 7/16/26.
//

import UIKit
import Kingfisher

class PlaylistCell: UITableViewCell {

    @IBOutlet weak var dotsImage: UIImageView!
    @IBOutlet weak var videoCountOverlay: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoCount: UILabel!
    
    override func awakeFromNib() {
        configView()
    }
    
    private func configView() {
        selectionStyle = .none
        super.awakeFromNib()
        dotsImage.image = UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor(named: "whiteColor")
    }

    func configCell(model : PlaylistModel.Item){
        videoTitle.text = model.snippet.title
        videoCount.text = String(model.contentDetails.itemCount)+" videos"
        videoCountOverlay.text = String(model.contentDetails.itemCount)
        
        let imageUrl = model.snippet.thumbnails.medium.url
        
        if let url = URL(string: imageUrl){
            
            videoImage.kf.setImage(with: url)
            
        }
    }
}
