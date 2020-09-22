//
//  ImagePicker.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI

public struct ImagePickerModifier: ViewModifier {

    @State var showImagePicker: Bool = false
    @State var showActionSheet: Bool = false
    @State var pickerType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var image: UIImage?

    public func body(content: Content) -> some View {
        content.onTapGesture {
            self.showActionSheet = true
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text(BBSwift.instance.options.picker.imageTitle), message: Text(BBSwift.instance.options.picker.imageMessage), buttons: [
                .default(Text(BBSwift.instance.options.picker.library)) {
                    self.pickerType = .photoLibrary
                    self.showImagePicker = true
                },
                .default(Text(BBSwift.instance.options.picker.camera)) {
                    self.pickerType = .camera
                    self.showImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: self.$showImagePicker) {
            ImagePicker(isShown: self.$showImagePicker, image: self.$image, sourceType: self.$pickerType).edgesIgnoringSafeArea(.all)
        }
    }

}


class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    init(isShown : Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image   = image
    }
    
    //Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        isShown = false
    }
    
    //Image selection got cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCordinator {
        return ImagePickerCordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = self.sourceType
        return picker
    }
}


//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker(isShown: .constant(false), image: .constant(UIImage()), sourceType: .constant(.photoLibrary))
//    }
//}
