//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Andy on 7/25/22.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
            
    }
}
