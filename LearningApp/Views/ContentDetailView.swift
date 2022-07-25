//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Andy on 7/21/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // only show video if not nil
            if url != nil {
        
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
                
            }
            
            // Description
            CodeTextView()
            
            // show button only if there is another lesson
            if model.hasNextLesson() {
                
                // Next Lesson Button
                Button {
                    model.nextLesson()
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    
                }
                
            } else {
                // show complete button
                Button {
                    model.currentContentSelected = nil
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    
                }
            }

        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}
