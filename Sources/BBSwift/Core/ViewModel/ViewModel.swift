//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/06/29.
//

import Foundation
import Combine

class ViewModelList<T: JSONContructible & ObservableObject>: ObservableObject where T: APIRouteAssociable {

    @Published var isLoading: Bool = false
    @Published var objects: [T] = [] {
        didSet {
            self.cancellables.removeAll()
            self.objects.forEach { (object) in
                let c = object.objectWillChange.sink(receiveValue: { _ in
                    self.objectWillChange.send()
                })
                self.cancellables.append(c)
            }
        }
    }
    @Published var showBanner: Bool = false
    @Published var bannerData: BannerData = BannerData.empty

    var cancellables = [AnyCancellable]()

    var subscriber: AnyCancellable?

    init(objects: [T] = []) {
        self.objects = objects
    }
    
    private func load(showLoader: Bool, showError: Bool, compl: ((APIError?) -> Void)? = nil) {
        if showLoader {
            self.isLoading = true
        }
        self.subscriber = T.getAssociatedRoute().request(type: Array<T>.self).sink(receiveCompletion: { (result) in
            if showLoader {
                self.isLoading = false
            }
            switch result {
            case .failure(let error):
                if showError {
                    self.bannerData = BannerData(title: BBSwift.instance.options.banner.apiErrorTitle, detail: error.message, type: .error)
                    self.showBanner = error != APIError.networkCallCancelled
                }
                compl?(error)
            case .finished:
                compl?(nil)
                break
            }
        }) { (objects) in
            self.objects = objects
        }
    }
    
    func reloadObjects() {
        self.load(showLoader: false, showError: false, compl: nil)
    }

    func loadObjects(compl: ((APIError?) -> Void)? = nil) {
        self.load(showLoader: true, showError: true, compl: compl)
    }

}
