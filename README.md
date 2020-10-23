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

### NumberPicker

Inspired from: https://github.com/yashthaker7/NumberPicker

There is few modifications from the original library

```
let numberPicker = NumberPicker(delegate: self, minNumber: 5, maxNumber: 30, cancelImage: UIImage(named: "numberpicker_cancel")!, doneImage: UIImage(named: "numberpicker_done")!, arrowImage: UIImage(named: "numberpicker_arrow")!)
numberPicker.bgGradients = [Colors.Gradient.blue.uiColor(), Colors.Gradient.lightBlue.uiColor()]
numberPicker.tintColor = .white
numberPicker.heading = ("mintemp".localized() + " °C")
numberPicker.defaultSelectedNumber = Int(self.minTemp ?? 5.0)
router.presentedModal?.present(numberPicker, animated: true, completion: nil)
```

- We don't store images so you have to provide your own cancel done and arrow image. This will be solved with swift 5.3. If you don't want to change them just copy paste the original project images
- Support of min value

### NumberTextfield

Easy Textfield for numbers. Support optional value. You can also provide the type of number you want: - price (two digits) - integer or a custom one (ex: `%.03f`) for 3 digits value


#### Currencies symbols

You can access currencies symbol with:

`currencySymbol` -> Return symbol of currency (ex: $US)
`currencyShortSymbol` -> Return the short version of symbol (ex: $)

Usage example: `"USD".currencySymbol`


#### Customization

By default the picker use these texts for popup:
 - "Pick an image"
 - "Choose where to pick an image"
 - "from Camera"
 - "from Library"

### CustomList

Because List is annoying and has bugs (on iOS 13) and ugly display (iOS 14), CustomList is just a wrapper when you provide the objects and the View is displayed if count > 0.
Because with an empty ScrollView you will have some bugs.

You can customize these texts with `BBPickerOptions`.

Here is an example when I want to use my own texts with localization:
```
var options = BBOptions(logRequestMode: .all)
options.picker = BBPickerOptions(title: "imagepicker_title".localized(), message: "imagepicker_message".localized(), camera: "imagepicker_camera".localized(), library: "imagepicker_library".localized())
BBSwift.configure(options: options)
```

### GridStack

This is the SwiftUI collectionview equivalent. It iterates through rows, column and objects you provide. Just specify the number of columns and you're good to go.

### Print

Use this to print data inside a SwiftUI view
