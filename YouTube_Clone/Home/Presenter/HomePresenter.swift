//
//  HomePresenter.swift
//  YouTube_Clone
//
//  Created by Adrian Flores Herrera on 7/1/26.
//

import Foundation

protocol HomeViewProtocol : AnyObject {
    func getData(list : [[Any]], sectionTitleList : [String] )
}

class HomePresenter {
    
    var provider : HomeProviderProtocol
    weak var delegate : HomeViewProtocol?
    private var objectList : [[Any]] = []
    private var sectionTitleList : [String] = []
    
    init(delegate : HomeViewProtocol,provider: HomeProvider = HomeProvider()) {
        self.provider = provider
        self.delegate = delegate


        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = HomeProviderMock()
        }
        #endif
        
    }
    
    func getHomeObjects() async {
        
        objectList.removeAll()
        sectionTitleList.removeAll()
        
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        async let playList =  try await provider.getPlayList(channelId: Constants.channelId).items
        
        do {
            
               let (responseChannel, responsePlaylist, responseVideos) = await(try channel, try playList, try videos)
            
            // Index O
            
            objectList.append(responseChannel)

            sectionTitleList.append("")
            
            if let playlistId = responsePlaylist.first?.id, let playListItems = await getPlayListItems(playListId: playlistId) {
            
            // Index 1
                objectList.append(playListItems.items.filter({$0.snippet.title != "Private video"}))
                
                sectionTitleList.append(responsePlaylist.first?.snippet.title ?? "")


            }
               
            // Index 2
            objectList.append(responseVideos)
            
            sectionTitleList.append("Uploads")
            
            // Index 3
            objectList.append(responsePlaylist)
            
            sectionTitleList.append("Created playlists")

            delegate?.getData(list: objectList, sectionTitleList: sectionTitleList)
            
        
            
        } catch {
            print(error)
        }
    }
    
    func getPlayListItems(playListId : String) async -> PlaylistItemsModel? {
        
        do {
            let playListItems = try await provider.getPlayListItems(playlistId: playListId)
            return playListItems
            

        } catch {
            
            print("Error")
            return nil
        }
        
    }
    
}
