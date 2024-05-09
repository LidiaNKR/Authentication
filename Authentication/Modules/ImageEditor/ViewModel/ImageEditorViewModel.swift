//
//  ImageEditorViewModel.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import SwiftUI
import PencilKit
import CoreImage.CIFilterBuiltins

final class ImageEditorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    //Изображение
    @Published var originImageData: Data = Data(count: 0)
    @Published var imageData: Data = Data(count: 0)
    @Published var rect: CGRect = .zero
    
    //Инструменты для рисования
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    
    //Текст
    @Published var textBoxes: [TextBox] = []
    @Published var addNewBox: Bool = false
    @Published var currentIndex: Int = 0
    
    //Фильры
    @Published var isFiltering: Bool = false
    @Published var sliderValue: CGFloat = 1.0
    @Published var allImages: [FilteredImage] = []
    @Published var mainViewImage: FilteredImage!
    
    //Алерт
    @Published var showAlert: Bool = false
    @Published var message: LocalizedStringKey = ""
    
    //Отправка изображения
    @Published var isSharePresented: Bool = false
    @Published var items: [Any] = []
    
    ///Фильтры для изображения
    private let filters: [CIFilter] = [
        CIFilter.sepiaTone(),
        CIFilter.comicEffect(),
        CIFilter.colorInvert(),
        CIFilter.photoEffectFade(),
        CIFilter.photoEffectChrome(),
        CIFilter.bloom(),
    ]
    
    // MARK: - Image
    
    /// Отмена редактирования изображение
    func cancelImageEditing() {
        originImageData = Data(count: 0)
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }
    
    /// Конвертация изображения и текста в PNG формат
    func makeImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), 
                             afterScreenUpdates: true)
        
        let swiftUIView = ZStack{
            ForEach(textBoxes) { [ self ] box in
                
                Text(textBoxes[currentIndex].id == box.id && addNewBox 
                     ? ""
                     : box.text)
                    .font(.system(size: 30))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundColor(box.textColor)
                    .offset(box.offset)
            }
        }
        
        if let view = UIHostingController(rootView: swiftUIView).view {
            let controller = view
            controller.frame = rect
            
            controller.backgroundColor = .clear
            canvas.backgroundColor = .clear
            
            controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), 
                                     afterScreenUpdates: true)
        }
        
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if let imagePNG = generatedImage?.pngData() {
            guard let image = UIImage(data: imagePNG) else { return nil }
            
            return image
        }
        
        return nil
    }
    
    ///Сохранение изображения в галерею
    func saveImage() {
        guard let image = makeImage() else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        message = "Image saved successfully"
        showAlert.toggle()
    }
    
    ///Поделиться изображением
    func shareImage() {
        guard let image = makeImage() else { return }
        
        items.removeAll()
        items.append(image)
        isSharePresented.toggle()
    }
    
    // MARK: - TextEditor
    
    /// Получение редактируемого текста
    func getText(box: TextBox) -> String {
        return textBoxes[currentIndex].id == box.id && addNewBox ? "" : box.text
    }
    
    /// Получение индекста текста
    func getIndex(textBox: TextBox) -> Int {
        let index = textBoxes.firstIndex { box -> Bool in
            return textBox.id == box.id
        } ?? 0
        
        return index
    }
    
    /// Корректировка текста
    func changeText(box: TextBox) {
        toolPicker.setVisible(false, forFirstResponder: canvas)
        canvas.resignFirstResponder()
        
        currentIndex = getIndex(textBox: box)
        
        withAnimation {
            addNewBox = true
        }
    }
    
    ///Перетаскивание текста
    func dragTextOnChanded(box: TextBox, value: DragGesture.Value) {
        let currentOffset = value.translation
        let lastOffset = box.lastOffset
        let newTranslation = CGSize(
            width: lastOffset.width + currentOffset.width,
            height: lastOffset.height + currentOffset.height
        )
        
        textBoxes[getIndex(textBox: box)].offset = newTranslation
    }
    
    ///Завершение перетаскивания текста
    func dragTextOnEnded(box: TextBox, value: DragGesture.Value) {
        textBoxes[getIndex(textBox: box)].lastOffset = value.translation
    }
    
    func doneTextEditing() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        textBoxes[currentIndex].isAdded = true
        withAnimation {
            addNewBox = false
        }
    }
    
    /// Отмена добавления текста
    func cancelTextEditing() {
        
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        withAnimation {
            addNewBox.toggle()
        }
        
        if !textBoxes[currentIndex].isAdded && textBoxes.count != 1 {
            textBoxes.removeLast()
            currentIndex -= 1
        }
    }
    
    // MARK: - ImageFiltering
    
    ///Генерация фильтров для изображения
    func loadFilter() {
        
        allImages.removeAll()
        mainViewImage = nil
        
        let context = CIContext()
        
        filters.forEach { filter in
            let ciImage = CIImage(data: self.originImageData)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            guard let newImage = filter.outputImage else { return }
            
            let cgImage = context.createCGImage(newImage, from: newImage.extent)
            
            guard let cgImage else { return }
            
            let isEditable = filter.inputKeys.count > 1
            
            let filteredData = FilteredImage(image: UIImage(cgImage: cgImage),
                                             filter: filter,
                                             isEditable: isEditable)
            
            self.allImages.append(filteredData)
            
            if self.mainViewImage == nil {
                self.mainViewImage = self.allImages.first
            }
        }
    }
    
    ///Корректировка интенсивности фильтра с помощью слайдера
    func updateEffect() {
        
        let context = CIContext()
        
        DispatchQueue.global(qos: .userInteractive).async {
            let ciImage = CIImage(data: self.originImageData)
            let filter = self.mainViewImage.filter
            
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            if filter.inputKeys.contains("inputIntensity") {
                filter.setValue(self.sliderValue, forKey: kCIInputIntensityKey)
            }
            
            guard let newImage = filter.outputImage else { return }
            
            let cgImage = context.createCGImage(newImage, from: newImage.extent)
            
            guard let cgImage else { return }
            
            DispatchQueue.main.async {
                self.mainViewImage.image = UIImage(cgImage: cgImage)
            }
        }
    }
    
    /// Применение фильтров
    func doneFilteringImage() {
        if let newImageData = mainViewImage.image.pngData() {
            withAnimation {
                imageData = newImageData
                cancelFilteringImage()
            }
        }
    }
    
    /// Отмена применения фильтров
    func cancelFilteringImage() {
        canvas = PKCanvasView()
        isFiltering.toggle()
    }
}
