//
//  ImageClassifier.swift
//  CarClassifier
//
//  Created by Thibault Giraudon on 30/05/2024.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.results
    }
    
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else {
            print("Error 2")
            return
        }
        print("CPT 2")
        classifier.detect(ciImage: ciImage)
        
    }
    
}
