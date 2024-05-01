//
//  TextEditorView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 02.05.2024.
//

import SwiftUI

struct TextEditorView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let opacity: CGFloat = 0.8
        static let fontSize: CGFloat = 35
        static let scaleEffect: CGFloat = 2
    }
    
    @EnvironmentObject var viewModel: ImageEditorViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            //Фон
            Color.black.opacity(Constants.opacity)
                .ignoresSafeArea()
            
            //Текстовое поле
            TextField(
                L10n.typeHere,
                text: $viewModel.textBoxes[viewModel.currentIndex].text
            )
            .font(
                .system(
                    size: Constants.fontSize,
                    weight: viewModel.textBoxes[viewModel.currentIndex].isBold ? .bold : .regular)
            )
            .colorScheme(.dark)
            .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColor)
            .padding()
            
            //Кнопки
            HStack {
                Button {
                    viewModel.doneTextEditing()
                } label: {
                    Image(systemName: "checkmark")
                }
                
                Spacer()
                
                Button {
                    viewModel.cancelTextEditing()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding()
            .foregroundColor(.green)
            .background(.black)
            .overlay(
                HStack() {
                    
                    ColorPicker("",
                                selection: $viewModel.textBoxes[viewModel.currentIndex].textColor)
                    .labelsHidden()
                    
                    Button{
                        viewModel.textBoxes[viewModel.currentIndex].isBold.toggle()
                    } label: {
                        Text(viewModel.textBoxes[viewModel.currentIndex].isBold ? "Normal" : "Bold" )
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                }
            )
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
