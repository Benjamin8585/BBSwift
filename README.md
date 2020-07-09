# BBSwift

Swift library to make life easier.

This library has been designed to simplify iOS Development. 
However this library is not here to be highly customizable and to cover all cases. 
If you want high customization for a specific part we strongly recommand to go native/custom.

The localization part is a good example. It cover most of usages in a basic application, but if you want to have different languages at the same time don't use this library.

### Localization

You can use the `localized()` function after a string to localize it. You can also pass parameters if you have dynamic texts.

By default language is current phone language.
If you want to specify explictely a language (ex: user has English phone but choosed French language in his profile):
`BBSwift.setLocalizationLanguage(lang: "fr")`


##### Examples

**Localizable.string: (en version)**

`"boutiquerow_stocks" = "%@ stocks available";`

**Localizable.string: (fr version)**

`"boutiquerow_stocks" = "%@ stocks disponibles";`

**Code**

`"boutiquerow_stocks".localized(params: ["3"])` will return  `3 stocks available`

`BBSwift.setLocalizationLanguage(lang: "fr")`
`"boutiquerow_stocks".localized(params: ["3"])` will return  `3 stocks disponibles`


### Image picker

You can transform any view as a button for image selection with `.imagePickable(image: $viewModel.image)`
The image binding you are passing is where the image result will be stored.

#### Customization

By default the picker use these texts for popup:
 - "Pick an image"
 - "Choose where to pick an image"
 - "from Camera"
 - "from Library"

You can customize these texts with `BBPickerOptions`.

Here is an example when I want to use my own texts with localization:
```
var options = BBOptions(logRequestMode: .all)
options.picker = BBPickerOptions(title: "imagepicker_title".localized(), message: "imagepicker_message".localized(), camera: "imagepicker_camera".localized(), library: "imagepicker_library".localized())
BBSwift.configure(options: options)
```
