//
//  ShareSheet.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    var activityItems: [Any]
    
    // MARK: - Methods
    
    func makeUIViewController(context: Context) -> some UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: []
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
