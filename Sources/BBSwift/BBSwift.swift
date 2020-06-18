
import Foundation

public struct BBOptions {
    
    #if !os(macOS)
    public var pickerTitle: String = "Pick an image"
    public var pickerMessage: String = "Choose where to pick an image"
    public var pickerCameraText: String = "from Camera"
    public var pickerLibraryText: String = "from Library"
    #endif
    
}

public struct BBSwift {
    
    static private(set) var instance: BBSwift = BBSwift(options: BBOptions())
    
    var options: BBOptions

    #if !os(macOS)
    var router: Router!
    #endif
    
    public var localizationLanguage: String?
    public var bundle: Bundle = Bundle.main
    
    /// Default configuration of the Framework
    mutating func configure(options: BBOptions = BBOptions()) {
        self.options = options
    }
    
    #if !os(macOS)
    func configureRouter(navigationController: NavigationController) {
        self.router = Router(root: navigationController)
    }
    #endif
    /// If you want the localize function to override the default phone language
    public static func setLocalizationLanguage(lang: String) {
        BBSwift.instance.localizationLanguage = lang
    }
    
    /// If for any fucking reason you want to change the bundle the framework operates in
    public static func setBundle(bundle: Bundle) {
        BBSwift.instance.bundle = bundle
    }
}


