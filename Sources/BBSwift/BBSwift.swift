
import Foundation


public enum LogRequestMode {
    case all, requestOnly, responseOnly, none
}

public struct BBPickerOptions {
    public var title: String = "Pick an image"
    public var message: String = "Choose where to pick an image"
    public var camera: String = "from Camera"
    public var library: String = "from Library"
}


public struct BBOptions {
    
    var picker: BBPickerOptions = BBPickerOptions()
    
    public var logRequestMode: LogRequestMode = .none
    
}

public struct BBSwift {
    
    static private(set) var instance: BBSwift = BBSwift(options: BBOptions())
    
    var options: BBOptions
    var router: Router!
    
    public var localizationLanguage: String?
    public var bundle: Bundle = Bundle.main
    
    /// Default configuration of the Framework
    mutating func configure(options: BBOptions = BBOptions()) {
        self.options = options
    }
    
    mutating func configureRouter(navigationController: NavigationController) {
        self.router = Router(root: navigationController)
    }
    /// If you want the localize function to override the default phone language
    public static func setLocalizationLanguage(lang: String) {
        BBSwift.instance.localizationLanguage = lang
    }
    
    /// If for any fucking reason you want to change the bundle the framework operates in
    public static func setBundle(bundle: Bundle) {
        BBSwift.instance.bundle = bundle
    }
}


