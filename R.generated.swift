//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `History`.
    static let history = _R.storyboard.history()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "History", bundle: ...)`
    static func history(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.history)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 15 colors.
  struct color {
    /// Color `AccentBlack-light`.
    static let accentBlackLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentBlack-light")
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `AccentPink-placeholder`.
    static let accentPinkPlaceholder = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentPink-placeholder")
    /// Color `AccentPink`.
    static let accentPink = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentPink")
    /// Color `AccentYellow`.
    static let accentYellow = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentYellow")
    /// Color `BackgroundColor-reversed`.
    static let backgroundColorReversed = Rswift.ColorResource(bundle: R.hostingBundle, name: "BackgroundColor-reversed")
    /// Color `BackgroundColor`.
    static let backgroundColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BackgroundColor")
    /// Color `BackgroundGray-lightest`.
    static let backgroundGrayLightest = Rswift.ColorResource(bundle: R.hostingBundle, name: "BackgroundGray-lightest")
    /// Color `BackgroundGray`.
    static let backgroundGray = Rswift.ColorResource(bundle: R.hostingBundle, name: "BackgroundGray")
    /// Color `IconColor`.
    static let iconColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "IconColor")
    /// Color `IconWhite`.
    static let iconWhite = Rswift.ColorResource(bundle: R.hostingBundle, name: "IconWhite")
    /// Color `LineGray`.
    static let lineGray = Rswift.ColorResource(bundle: R.hostingBundle, name: "LineGray")
    /// Color `TextColor`.
    static let textColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "TextColor")
    /// Color `TextGray-light`.
    static let textGrayLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "TextGray-light")
    /// Color `TextGray`.
    static let textGray = Rswift.ColorResource(bundle: R.hostingBundle, name: "TextGray")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentBlack-light", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentBlackLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentBlackLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentPink", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentPink(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentPink, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentPink-placeholder", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentPinkPlaceholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentPinkPlaceholder, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentYellow", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentYellow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentYellow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BackgroundColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func backgroundColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.backgroundColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BackgroundColor-reversed", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func backgroundColorReversed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.backgroundColorReversed, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BackgroundGray", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func backgroundGray(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.backgroundGray, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BackgroundGray-lightest", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func backgroundGrayLightest(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.backgroundGrayLightest, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "IconColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func iconColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.iconColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "IconWhite", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func iconWhite(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.iconWhite, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "LineGray", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lineGray(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lineGray, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "TextColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "TextGray", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textGray(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textGray, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "TextGray-light", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textGrayLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textGrayLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentBlack-light", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentBlackLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentBlackLight.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentPink", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentPink(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentPink.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentPink-placeholder", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentPinkPlaceholder(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentPinkPlaceholder.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentYellow", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentYellow(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentYellow.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BackgroundColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func backgroundColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.backgroundColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BackgroundColor-reversed", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func backgroundColorReversed(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.backgroundColorReversed.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BackgroundGray", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func backgroundGray(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.backgroundGray.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BackgroundGray-lightest", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func backgroundGrayLightest(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.backgroundGrayLightest.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "IconColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func iconColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.iconColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "IconWhite", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func iconWhite(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.iconWhite.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "LineGray", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lineGray(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lineGray.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "TextColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "TextGray", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textGray(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textGray.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "TextGray-light", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textGrayLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textGrayLight.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 4 files.
  struct file {
    /// Resource file `NanumSquareRound-Bold.otf`.
    static let nanumSquareRoundBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "NanumSquareRound-Bold", pathExtension: "otf")
    /// Resource file `NanumSquareRound-ExtraBold.otf`.
    static let nanumSquareRoundExtraBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "NanumSquareRound-ExtraBold", pathExtension: "otf")
    /// Resource file `NanumSquareRound-Light.otf`.
    static let nanumSquareRoundLightOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "NanumSquareRound-Light", pathExtension: "otf")
    /// Resource file `NanumSquareRound-Regular.otf`.
    static let nanumSquareRoundRegularOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "NanumSquareRound-Regular", pathExtension: "otf")

    /// `bundle.url(forResource: "NanumSquareRound-Bold", withExtension: "otf")`
    static func nanumSquareRoundBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.nanumSquareRoundBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "NanumSquareRound-ExtraBold", withExtension: "otf")`
    static func nanumSquareRoundExtraBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.nanumSquareRoundExtraBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "NanumSquareRound-Light", withExtension: "otf")`
    static func nanumSquareRoundLightOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.nanumSquareRoundLightOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "NanumSquareRound-Regular", withExtension: "otf")`
    static func nanumSquareRoundRegularOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.nanumSquareRoundRegularOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 4 fonts.
  struct font: Rswift.Validatable {
    /// Font `NanumSquareRoundOTFB`.
    static let nanumSquareRoundOTFB = Rswift.FontResource(fontName: "NanumSquareRoundOTFB")
    /// Font `NanumSquareRoundOTFEB`.
    static let nanumSquareRoundOTFEB = Rswift.FontResource(fontName: "NanumSquareRoundOTFEB")
    /// Font `NanumSquareRoundOTFL`.
    static let nanumSquareRoundOTFL = Rswift.FontResource(fontName: "NanumSquareRoundOTFL")
    /// Font `NanumSquareRoundOTFR`.
    static let nanumSquareRoundOTFR = Rswift.FontResource(fontName: "NanumSquareRoundOTFR")

    /// `UIFont(name: "NanumSquareRoundOTFB", size: ...)`
    static func nanumSquareRoundOTFB(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: nanumSquareRoundOTFB, size: size)
    }

    /// `UIFont(name: "NanumSquareRoundOTFEB", size: ...)`
    static func nanumSquareRoundOTFEB(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: nanumSquareRoundOTFEB, size: size)
    }

    /// `UIFont(name: "NanumSquareRoundOTFL", size: ...)`
    static func nanumSquareRoundOTFL(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: nanumSquareRoundOTFL, size: size)
    }

    /// `UIFont(name: "NanumSquareRoundOTFR", size: ...)`
    static func nanumSquareRoundOTFR(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: nanumSquareRoundOTFR, size: size)
    }

    static func validate() throws {
      if R.font.nanumSquareRoundOTFB(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'NanumSquareRoundOTFB' could not be loaded, is 'NanumSquareRound-Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.nanumSquareRoundOTFEB(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'NanumSquareRoundOTFEB' could not be loaded, is 'NanumSquareRound-ExtraBold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.nanumSquareRoundOTFL(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'NanumSquareRoundOTFL' could not be loaded, is 'NanumSquareRound-Light.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.nanumSquareRoundOTFR(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'NanumSquareRoundOTFR' could not be loaded, is 'NanumSquareRound-Regular.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 9 images.
  struct image {
    /// Image `add`.
    static let add = Rswift.ImageResource(bundle: R.hostingBundle, name: "add")
    /// Image `backspace`.
    static let backspace = Rswift.ImageResource(bundle: R.hostingBundle, name: "backspace")
    /// Image `divide`.
    static let divide = Rswift.ImageResource(bundle: R.hostingBundle, name: "divide")
    /// Image `dot`.
    static let dot = Rswift.ImageResource(bundle: R.hostingBundle, name: "dot")
    /// Image `equal`.
    static let equal = Rswift.ImageResource(bundle: R.hostingBundle, name: "equal")
    /// Image `minus`.
    static let minus = Rswift.ImageResource(bundle: R.hostingBundle, name: "minus")
    /// Image `multiply`.
    static let multiply = Rswift.ImageResource(bundle: R.hostingBundle, name: "multiply")
    /// Image `percent`.
    static let percent = Rswift.ImageResource(bundle: R.hostingBundle, name: "percent")
    /// Image `plus-minus`.
    static let plusMinus = Rswift.ImageResource(bundle: R.hostingBundle, name: "plus-minus")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "add", bundle: ..., traitCollection: ...)`
    static func add(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.add, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "backspace", bundle: ..., traitCollection: ...)`
    static func backspace(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.backspace, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "divide", bundle: ..., traitCollection: ...)`
    static func divide(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.divide, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "dot", bundle: ..., traitCollection: ...)`
    static func dot(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dot, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "equal", bundle: ..., traitCollection: ...)`
    static func equal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.equal, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "minus", bundle: ..., traitCollection: ...)`
    static func minus(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.minus, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "multiply", bundle: ..., traitCollection: ...)`
    static func multiply(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.multiply, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "percent", bundle: ..., traitCollection: ...)`
    static func percent(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.percent, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "plus-minus", bundle: ..., traitCollection: ...)`
    static func plusMinus(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.plusMinus, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `HistoryTableViewCell`.
    static let historyTableViewCell = _R.nib._HistoryTableViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "HistoryTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.historyTableViewCell) instead")
    static func historyTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.historyTableViewCell)
    }
    #endif

    static func historyTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> HistoryTableViewCell? {
      return R.nib.historyTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? HistoryTableViewCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `historyTableCell`.
    static let historyTableCell: Rswift.ReuseIdentifier<HistoryTableViewCell> = Rswift.ReuseIdentifier(identifier: "historyTableCell")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _HistoryTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = HistoryTableViewCell

      let bundle = R.hostingBundle
      let identifier = "historyTableCell"
      let name = "HistoryTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> HistoryTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? HistoryTableViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try history.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct history: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = HistoryViewController

      let bundle = R.hostingBundle
      let historyStoryboard = StoryboardViewControllerResource<HistoryViewController>(identifier: "historyStoryboard")
      let name = "History"

      func historyStoryboard(_: Void = ()) -> HistoryViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: historyStoryboard)
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "trash.fill") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'trash.fill' is used in storyboard 'History', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "AccentColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'AccentColor' is used in storyboard 'History', but couldn't be loaded.") }
          if UIKit.UIColor(named: "AccentPink", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'AccentPink' is used in storyboard 'History', but couldn't be loaded.") }
          if UIKit.UIColor(named: "BackgroundGray", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'BackgroundGray' is used in storyboard 'History', but couldn't be loaded.") }
          if UIKit.UIColor(named: "TextColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'TextColor' is used in storyboard 'History', but couldn't be loaded.") }
        }
        if _R.storyboard.history().historyStoryboard() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'historyStoryboard' could not be loaded from storyboard 'History' as 'HistoryViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainViewController

      let bundle = R.hostingBundle
      let mainStoryboard = StoryboardViewControllerResource<MainViewController>(identifier: "mainStoryboard")
      let name = "Main"

      func mainStoryboard(_: Void = ()) -> MainViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainStoryboard)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "add", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'add' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "backspace", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'backspace' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "divide", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'divide' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "dot", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'dot' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "equal", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'equal' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "folder.fill") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'folder.fill' is used in storyboard 'Main', but couldn't be loaded.") } }
        if UIKit.UIImage(named: "minus", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'minus' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "multiply", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'multiply' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "percent", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'percent' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "plus-minus", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'plus-minus' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "AccentColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'AccentColor' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "BackgroundColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'BackgroundColor' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "TextColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'TextColor' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "TextGray", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'TextGray' is used in storyboard 'Main', but couldn't be loaded.") }
        }
        if _R.storyboard.main().mainStoryboard() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainStoryboard' could not be loaded from storyboard 'Main' as 'MainViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
