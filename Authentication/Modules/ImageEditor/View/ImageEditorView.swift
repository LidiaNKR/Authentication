//
//  HomeView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

struct ImageEditorView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var authService: AuthenticationViewModel
    @ObservedObject private var viewModel = ImageEditorViewModel()
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
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
                        
                        //Добавление изображения
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "photo.artframe")
                            Text("Select an image")
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
                
                //Выход из учетной записи
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            authService.signOut { error in
                                if let error {
                                    viewModel.message = LocalizedStringKey(error.localizedDescription)
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
            ActionSheet(title: Text("Select an image"),
                        buttons: [
                            .default(Text("Gallery")) {
                    showImagePicker.toggle()
                    sourceType = .photoLibrary
                },
                            .default(Text("Сamera")) {
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
            Alert(title: Text("Done"),
                  message: Text(viewModel.message),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct ImageEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageEditorView()
    }
}
