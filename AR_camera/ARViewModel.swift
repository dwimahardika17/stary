//
//  ARViewModel.swift
//  AR_camera
//
//  Created by Nicholas Yvees on 21/03/23.
//

import Foundation
import RealityKit

class ARViewModel: ObservableObject {
    @Published private var model : ARModel = ARModel()
    
    var arView : ARView {
        model.arView
    }
    
    func switchCamera() {
        model.switchCamera()
    }
}
