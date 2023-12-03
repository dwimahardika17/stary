//
//  Gallery.swift
//  AR_camera
//
//  Created by I MADE DWI MAHARDIKA on 23/03/23.
//

import SwiftUI
import Photos

struct Gallery: View {
    @State private var images: [UIImage] = []
    var body: some View {
        VStack {
            
            if images.count > 0 {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                        }
                    }
                }
                .offset(y: 40)
            } else {
                Text("No images found in the custom album")
                    .offset(y: 50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            fetchImagesFromCustomAlbum()
        }
        .background(Image("memorydisplay-06")
            .resizable()
            .ignoresSafeArea())
    }
    
    func fetchImagesFromCustomAlbum() {
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

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
