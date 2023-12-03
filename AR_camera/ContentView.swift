//
//  ContentView.swift
//  AR_camera
//
//  Created by Nicholas Yvees on 21/03/23.
//

import SwiftUI
import RealityKit
import ARKit
import Photos
import CoreImage
import AVKit

struct ContentView : View {
    //    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    //    @State private var image: UIImage?
    private var data: [Int] = Array(1...20)
    @State private var images: [UIImage] = []
    let limit = 10
    @State var audioPlay: AVAudioPlayer!
    private let fixedRows = [
        GridItem(.fixed(90)),
//        GridItem(.fixed(120)),
    ]
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                  
                    Image("Earth")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .scaledToFit()
                    
                    LottieButton(animationName: "5", loopMode: .loop)
                        .frame(width: 150, height: 200)
                        .rotationEffect(.degrees(-180))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .offset(x: -30, y: -100)
                        .frame(maxWidth: .infinity, maxHeight: 790)
                    
                    LottieButton(animationName: "3", loopMode: .loop)
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .offset(x: 10)
                        .frame(maxWidth: .infinity, maxHeight: 290)
                    
                    LottieButton(animationName: "4", loopMode: .loop)
                        .frame(width: 250, height: 250)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .offset(x: 10)
                        .frame(maxWidth: .infinity, maxHeight: 750)
                    
                    LottieButton(animationName: "2", loopMode: .loop)
                        .frame(width: 300, height: 250)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .offset(x: 10)
                        .frame(maxWidth: .infinity, maxHeight: 600)
                    
                   
                    
                    
                    VStack {
                        NavigationLink(destination: Camera()){
                            Image("AddPhoto")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 230, alignment: .bottom)
                                .offset(y: -12)
                        }
//                        .offset(y: 80)
                        .padding(.top, 350)
                        
                        ScrollView (.horizontal){
                            LazyHGrid(rows: fixedRows, spacing: 7){
                                ForEach(images.prefix(limit), id: \.self) { image in
                                    ZStack{
                                        //Rectangle()
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 100,height: 150)
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(10)
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                            .onAppear {
                                fetchImagesFromCustomAlbum()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .offset(y: 35)
                        
                    }
                    .background(Image("Cockpit")
                        .resizable()
                        .scaledToFill()
                        .padding(.top, 400))
                    .frame(maxHeight: .infinity)
                    
                    NavigationLink(destination: Gallery()){
                        Image("Seemore")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 80)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 25)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("GalaxyBG")
                    .resizable()
                    .scaledToFill()
                )
                .ignoresSafeArea()
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    //Force rotation to portrait
                    AppDelegate.orientationLock = .portrait //making sure its portrait
                }.onDisappear{
                    AppDelegate.orientationLock = .all //unlocking rotation when leaving this view
                }
                
            }
            .onAppear {
                let sound = Bundle.main.path(forResource: "space", ofType: "mp3")
                self.audioPlay = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlay.numberOfLoops = -1 // Set number of loops to a negative integer for infinite looping
                self.audioPlay.play()
            }
            
        }
        
        
        
    }
    func fetchImagesFromCustomAlbum() {
        images = []
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", "Stary")
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options)
        
        if let album = albums.firstObject {
            let assets = PHAsset.fetchAssets(in: album, options: nil)
            
            assets.enumerateObjects { asset, _, _ in
                let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = true
                requestOptions.deliveryMode = .highQualityFormat
                
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: requestOptions) { image, _ in
                    if let image = image {
                        self.images.append(image)
                    }
                }
            }
        }
    }
}




//struct ARViewContainer: UIViewRepresentable {
//
//    var arViewModel: ARViewModel
//
//
//
//    func makeUIView(context: Context) -> ARView {
//        arViewModel.arView.session.run(ARFaceTrackingConfiguration())
////      arViewModel.arView = ARView(frame: .zero)
//      // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//      // Add the box anchor to the scene
//      arViewModel.arView.scene.anchors.append(boxAnchor)
//      return arViewModel.arView
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
