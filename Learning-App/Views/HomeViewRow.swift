//
//  HomeViewRow.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//
// Represents a single row in of the home view. 

import SwiftUI

struct HomeViewRow: View {
    
    //doesnt have access to module, so want to pass in all arguments requiring module elements
    var image:String
    var title:String
    var description:String
    var count:String
    var time:String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                //make rect size to any screen
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                //image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                //text
                VStack (alignment: .leading, spacing: 10) {
                    //headline
                    Text(title)
                        .bold()
                    
                    //description
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    //icons
                    HStack {
                        
                        //num lessons
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        
                        //time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(Font.system(size: 10))
                        
                    }
                    
                }
                .padding(.leading, 20)
                
            }
            .padding(.horizontal, 20)
            
        }
        
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description", count: "10 Lessons", time: "2 Hours")
    }
}
