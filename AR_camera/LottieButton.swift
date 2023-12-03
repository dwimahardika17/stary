//
//  LottieButton.swift
//  Animation_test
//
//  Created by Nicholas Yvees on 21/03/23.
//

import Foundation
import Lottie
import SwiftUI
import UIKit

struct LottieButton: UIViewRepresentable {
    typealias UIViewType = UIView
    
    
    var animationName: String
//    let animationButton = AnimatedButton()
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()
    
    
    func makeUIView(context: UIViewRepresentableContext<LottieButton>) -> UIView {
        
        let view = UIView(frame: .zero)
        
        let animation = LottieAnimation.named(animationName)
//        animationButton.animation = animation
//        animationButton.contentMode = .scaleAspectFit
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
//        animationButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchUpInside)
        
//        animationButton.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
//            animationButton.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationButton.heightAnchor.constraint(equalTo: view.heightAnchor),
//            animationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            animationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieButton>){
        
    }
}
