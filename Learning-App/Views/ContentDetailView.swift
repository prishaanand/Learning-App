//
//  ContentDetailView.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        
        //if lesson is not set yet, make it empty string
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        //only show video if we get a valid url 
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
        }
        
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
