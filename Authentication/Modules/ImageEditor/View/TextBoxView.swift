//
//  TextBoxView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 02.05.2024.
//

import SwiftUI

///Слой с добавленным текстом
struct TextBoxView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var viewModel: ImageEditorViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            ForEach(viewModel.textBoxes) { box in
                
                //Текст
                Text(viewModel.getText(box: box))
                    .font(.system(size: 30))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundColor(box.textColor)
                    .offset(box.offset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                viewModel.dragTextOnChanded(box: box,
                                                            value: value)
                            })
                            .onEnded({ value in
                                viewModel.dragTextOnEnded(box: box,
                                                          value: value)
                            })
                    )
                    .onLongPressGesture {
                        viewModel.changeText(box: box)
                    }
            }
        }
    }
}

struct TextBoxView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
