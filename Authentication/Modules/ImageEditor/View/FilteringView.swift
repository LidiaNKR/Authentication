//
//  FilteringView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 02.05.2024.
//

import SwiftUI

struct FilteringView: View {
    
    @EnvironmentObject private var viewModel: ImageEditorViewModel
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                //Изображение
                Image(uiImage: viewModel.mainViewImage.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                
                //Слайдер для корректировки интенсивности фильтра
                Slider(value: $viewModel.sliderValue)
                    .padding()
                    .opacity(viewModel.mainViewImage.isEditable ? 1 : 0)
                    .disabled(viewModel.mainViewImage.isEditable ? false : true)
                
                //Превью изображением с фильтрами
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.allImages) { filtered in
                            Image(uiImage: filtered.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .onTapGesture {
                                    viewModel.sliderValue = 1.0
                                    viewModel.mainViewImage = filtered
                                }
                        }
                    }
                    .padding()
                }
            }
            .onChange(of: viewModel.sliderValue, perform: { _ in
                viewModel.updateEffect()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    //Готово
                    Button {
                        viewModel.doneFilteringImage()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    //Отмена
                    Button {
                        viewModel.cancelFilteringImage()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .foregroundColor(.green)
        }
    }
}

struct FilteringView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
