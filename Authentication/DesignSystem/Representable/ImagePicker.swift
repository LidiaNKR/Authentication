//
//  ImagePicker.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    @Binding var isShowPicker: Bool
    @Binding var imageData: Data
    @Binding var originImageData: Data
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(imagePicker: self)
    }
    
    // MARK: - Methods
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: - Properties
    
    var imagePicker: ImagePicker
    
    // MARK: - Initializers
    
    init(imagePicker: ImagePicker) {
        self.imagePicker = imagePicker
    }
    
    // MARK: - Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageData = (info[.originalImage] as? UIImage)?.pngData() {
            
            imagePicker.imageData = imageData
            imagePicker.originImageData = imageData
            imagePicker.isShowPicker.toggle()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.isShowPicker.toggle()
    }
}
