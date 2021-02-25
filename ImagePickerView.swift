//
//  ImagePickerView.swift
//  instafilter
//
//  Created by Travis Brigman on 2/24/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//
/*
import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("save finished")
    }
}

struct ImagePickerView: View {
        @State private var image: Image?
        @State private var showingImagePicker = false
        @State private var inputImage: UIImage?
        var body: some View {
            VStack {
                image?
                .resizable()
                .scaledToFit()
                
                Button("Showing Image") {
                    self.showingImagePicker = true
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
            
            let imageSaver = ImageSaver()
            imageSaver.writeToPhotoAlbum(image: inputImage)
        }
    }

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
*/
