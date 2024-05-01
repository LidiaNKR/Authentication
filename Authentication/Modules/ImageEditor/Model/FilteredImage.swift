//
//  FilteredImage.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import SwiftUI
import CoreImage

struct FilteredImage: Identifiable {
    
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    var isEditable: Bool
}
