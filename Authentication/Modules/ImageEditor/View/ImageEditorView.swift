//
//  HomeView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI
import PhotosUI
import PencilKit
import CoreImage

struct ImageEditorView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var authService: AuthenticationViewModel
    @ObservedObject private var viewModel = ImageEditorViewModel()
    
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showSheet = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    
                    if UIImage(data: viewModel.imageData) != nil {
                        
                        //Изображение
                        if !viewModel.isFiltering {
                            ZoomableContainer { // Масштабирование изображения
                                DravingView()
                                    .environmentObject(viewModel)
                            }
                        }

                    } else if viewModel.imageData.count == 0 {
                        
                        //Кнопка добавления изображение
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "photo.artframe")
                            Text(L10n.chooseYourPicture)
                        }
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    } else {
                        
                        //Лоадер
                        LoadingView()
                    }
                }
                .onChange(of: viewModel.imageData, perform: { _ in
                    viewModel.loadFilter()
                })
                
                //Кнопка выхода из учетной записи
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            authService.signOut { error in
                                if let error {
                                    viewModel.message = error.localizedDescription
                                    viewModel.showAlert.toggle()
                                }
                                viewModel.cancelImageEditing()
                            }
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                    }
                }
                .foregroundColor(.green)
            }
            
            if viewModel.isFiltering && viewModel.mainViewImage != nil {
                //Фильрры
                FilteringView()
                    .environmentObject(viewModel)
            }
            
            if viewModel.addNewBox {
                //Редактирование текста
                TextEditorView()
                    .environmentObject(viewModel)
            }
        }
        
        //ActionSheet для выбора добавления фото из галереи/камеры
        .actionSheet(isPresented: $showSheet) {
            ActionSheet(title: Text(L10n.selectPhoto),
                        message: Text(""), buttons: [
                            .default(Text(L10n.photoLibrary)) {
                    showImagePicker.toggle()
                    sourceType = .photoLibrary
                },
                            .default(Text(L10n.camera)) {
                    showImagePicker.toggle()
                    sourceType = .camera
                },
                .cancel()
            ])
        }
        
        //ImagePicker для добавления фото
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(isShowPicker: $showImagePicker,
                        imageData: $viewModel.imageData,
                        originImageData: $viewModel.originImageData,
                        sourceType: sourceType)
        })
        
        //Алерт
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(L10n.alertSuccessTitle),
                  message: Text(viewModel.message),
                  dismissButton: .default(Text(L10n.alertButtonTitle)))
        }
    }
}

struct ImageEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageEditorView()
    }
}
