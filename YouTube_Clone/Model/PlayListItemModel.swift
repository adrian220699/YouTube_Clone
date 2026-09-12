//
//  PlayListItemModel.swift
//  YouTube_Clone
//
//  Created by Adrian Flores Herrera on 6/27/26.
//

import Foundation

struct PlaylistItemsModel: Decodable{
    let kind: String
    let etag: String
    let items: [Item]
    let pageInfo : PageInfo
    
    struct Item: Decodable{
        let kind : String
        let etag : String
        let id : String
        let snippet : VideoModel.Item.Snippet
        let contentDetails : ContentDetails?
        
        struct ContentDetails: Decodable{
            let videoId : String?
            let videoPublishedAt : String?
        }
    }
    
    struct PageInfo: Decodable{
        let totalResults: Int
        let resultsPerPage: Int
    }
}
