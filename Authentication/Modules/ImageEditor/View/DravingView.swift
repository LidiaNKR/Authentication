//
//  DravingView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import SwiftUI
import PencilKit

struct DravingView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var viewModel: ImageEditorViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            GeometryReader { proxy -> AnyView in
                
                let size = proxy.frame(in: .global)
                
                DispatchQueue.main.async {
                    if viewModel.rect == .zero {
                        viewModel.rect = size
                    }
                }
                
                return AnyView(
                    
                    ZStack {
                        // Рисование
                        CanvasView(canvas: $viewModel.canvas,
                                   imageData: $viewModel.imageData,
                                   toolPicker: $viewModel.toolPicker,
                                   rect: size.size)
                        
                        // Текст
                        TextBoxView()
                            .environmentObject(viewModel)
                    }
                )
            }
        }
        
        //Действия для редактирования изображения
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.cancelImageEditing()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.shareImage()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.saveImage()
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    viewModel.textBoxes.append(TextBox())
                    viewModel.currentIndex = viewModel.textBoxes.count - 1
                    
                    withAnimation {
                        viewModel.addNewBox.toggle()
                    }
                    viewModel.toolPicker.setVisible(
                        false,
                        forFirstResponder: viewModel.canvas
                    )
                    viewModel.canvas.resignFirstResponder()
                } label: {
                    Image(systemName: "pencil")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        viewModel.isFiltering.toggle()
                        viewModel.toolPicker.setVisible(
                            !viewModel.isFiltering,
                            forFirstResponder: viewModel.canvas
                        )
                    }
                } label: {
                    Image(systemName: "camera.filters")
                }
            }
        }
        .foregroundColor(.green)
        
        //Поделиться изображением
        .sheet(isPresented: $viewModel.isSharePresented) {
            ShareSheet(activityItems: viewModel.items)
        }
    }
}

struct DravingView_Previews: PreviewProvider {
    static var previews: some View {
        DravingView()
    }
}
