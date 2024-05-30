//
//  ContentView.swift
//  CarClassifier
//
//  Created by Thibault Giraudon on 30/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var uiImage: UIImage?
    @State private var isPresenting: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        ZStack {
            Color.primaryGray
                .ignoresSafeArea()
            VStack {
                if let image = uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .contextMenu {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                uiImage = nil
                            }
                        }
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.quinary)
                        HStack {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .padding()
                                .onTapGesture {
                                    isPresenting = true
                                    sourceType = .photoLibrary
                                }
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .onTapGesture {
                                    isPresenting = true
                                    sourceType = .camera
                                }
                        }
                        .foregroundStyle(.primaryGray)
                    }
                }
                
                Button {
                    if let image = uiImage {
                        classifier.detect(uiImage: image)
                    }
                } label: {
                    Text("Submit")
                        .font(.largeTitle)
                        .foregroundStyle(uiImage == nil ? .gray : .primaryGreen)
                        .brightness(-0.2)
                        .padding(.horizontal)
                        .padding()
                        .background(uiImage == nil ? .gray : .primaryGreen)
                        .clipShape(.capsule)
                        .padding()
                }
                .disabled(uiImage == nil)
                
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack {
                            Text(imageClass)
                                .font(.largeTitle)
                                .bold()
                        }
                    } else {
                        HStack {
                            Text("NA")
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                ImagePicker(uiImage: $uiImage, isPresenting: $isPresenting, sourceType: $sourceType)
                    .onDisappear {
                        if let image = uiImage {
                            classifier.detect(uiImage: image)
                        }
                    }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(classifier: ImageClassifier())
}
