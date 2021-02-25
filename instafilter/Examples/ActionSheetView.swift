//
//  ActionSheetView.swift
//  instafilter
//
//  Created by Travis Brigman on 2/24/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change Background"), message: Text("Select a New Color"), buttons: [
                .default(Text("Red")){ self.backgroundColor = .red },
                .default(Text("Green")){ self.backgroundColor = .green },
                .default(Text("Blue")){ self.backgroundColor = .blue },
                .cancel()
            ])
        }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
    }
}
