//
//  VideoPicker.swift
//
//
//  Created by Benjamin Bourasseau on 22/09/2020.
//

import Foundation
import SwiftUI
import MobileCoreServices

public struct VideoPickerModifier: ViewModifier {

    @State var showVideoPicker: Bool = false
    @State var showActionSheet: Bool = false
    @State var pickerType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var video: Data?

    public func body(content: Content) -> some View {
        content.onTapGesture {
            self.showActionSheet = true
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text(BBSwift.instance.options.picker.videoTitle), message: Text(BBSwift.instance.options.picker.videoMessage), buttons: [
                .default(Text(BBSwift.instance.options.picker.library)) {
                    self.pickerType = .photoLibrary
                    self.showVideoPicker = true
                },
                .default(Text(BBSwift.instance.options.picker.camera)) {
                    self.pickerType = .camera
                    self.showVideoPicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: self.$showVideoPicker) {
            VideoPicker(isShown: self.$showVideoPicker, video: self.$video, sourceType: self.$pickerType).edgesIgnoringSafeArea(.all)
        }
    }

}


class VideoPickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isShown: Bool
    @Binding var video: Data?
    
    init(isShown : Binding<Bool>, video: Binding<Data?>) {
        _isShown = isShown
        _video   = video
    }
    
    //Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let videoURL: URL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
          print(videoURL)
        if let nsData = NSData(contentsOf: videoURL) {
            let data: Data = Data(referencing: nsData)
            video = data
        } else {
            video = nil
        }
        isShown = false
    }
    
    //Image selection got cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct VideoPicker : UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var video: Data?
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<VideoPicker>) {
        
    }
    
    func makeCoordinator() -> VideoPickerCordinator {
        return VideoPickerCordinator(isShown: $isShown, video: $video)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = self.sourceType
        picker.mediaTypes = ["public.movie"]
        return picker
    }
}


struct VideoPicker_Previews: PreviewProvider {
    static var previews: some View {
        VideoPicker(isShown: .constant(false), video: .constant(Data()), sourceType: .constant(.photoLibrary))
    }
}
