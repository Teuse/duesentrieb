import Foundation

struct BuildEnv {
   
   static var debug: Bool {
      #if DEBUG
      return true
      #else
      return false
      #endif
   }
}
