import SwiftUI

enum AppColor {

    static var primary: Color       { return Color(red: 1.0, green: 0.451, blue: 0.129) }   // #FF7321
    static var primaryDark: Color   { return Color(red: 0.66, green: 0.223, blue: 0) }      // #A83900
    
    static var blackTextColor: Color { return Color.black }
    static var whiteTextColor: Color { return Color.white }
    
    static var darkBackground: Color { return darkGray }
    
    
    
    //MARK: - Private Color Definitions
    
    static private var darkGray: Color     { return Color(white: 0.2) }
}
