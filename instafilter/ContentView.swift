//
//  ContentView.swift
//  instafilter
//
//  Created by Travis Brigman on 2/24/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins


struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var showSaveImageAlert = false
    @State private var inputImage: UIImage?
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var processedImage: UIImage?
    @State private var filterName: String = "CISepiaTone"


    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
        },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
        }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                        
                    } else {
                        Text("Tap to Select A Picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("\(filterNameParser(filter: filterName))") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    Button("Save the Picture") {
    
                        guard let processedImage = self.processedImage else {
                            self.showSaveImageAlert = true
                            return }
                        
                        let imageSaver = ImageSaver()
                        
                        
                        imageSaver.successHandler = {
                            print("success")
                        }
                        imageSaver.errorHandler = {
                            print("oops \($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                        
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("InstaFilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select A Filter"), buttons: [
                    .default(Text("Crystalize")) {
                        self.setFilter(CIFilter.crystallize())
                    },
                    .default(Text("Edges")) {
                        self.setFilter(CIFilter.edges())
                    },
                    .default(Text("Gaussian Blur")) {
                        self.setFilter(CIFilter.gaussianBlur())
                    },
                    .default(Text("Pixellate")) {
                        self.setFilter(CIFilter.pixellate())
                    },
                    .default(Text("Sepia Tone")) {
                        self.setFilter(CIFilter.sepiaTone())
                    },
                    .default(Text("Unsharp Mask")) {
                        self.setFilter(CIFilter.unsharpMask())
                    },
                    .default(Text("Vignette")) {
                        self.setFilter(CIFilter.vignette())
                    },
                    .cancel()
                ])
            }
            .alert(isPresented: $showSaveImageAlert) {
                Alert(title: Text("Error Saving Image"), message: Text("try something else"), dismissButton: .default(Text("OK")))
            }
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        self.filterName = currentFilter.name
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        self.filterName = currentFilter.name
        loadImage()
    }
    
    func filterNameParser(filter name: String) -> String {
        var parsedName = name

        parsedName.removeSubrange(parsedName.startIndex...parsedName.index(after: parsedName.startIndex))
        
        return parsedName.titleCase()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
