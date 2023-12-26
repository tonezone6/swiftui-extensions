//
//  String-LoremIpsum.swift
// 

import Foundation

extension String {
  private static var lorem_words_200: String {
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut eu est at metus aliquet finibus. Sed et erat hendrerit, accumsan libero ac, dignissim purus. Pellentesque fringilla mauris ac quam facilisis, imperdiet mattis erat auctor. Cras imperdiet, lacus non volutpat volutpat, nisl ante porttitor erat, sagittis consequat turpis lacus nec lacus. Quisque sed nisl sit amet justo volutpat posuere. Phasellus cursus venenatis tellus, eget varius arcu convallis imperdiet. Phasellus non aliquam est. Nam consequat odio in augue rutrum, sit amet cursus purus blandit. Cras non lorem mauris. Curabitur nisl lectus, dignissim ut eros a, commodo fermentum nulla. In eu ligula id ipsum placerat luctus. Nulla faucibus erat non mi ullamcorper, id tempus nulla vehicula. Curabitur condimentum placerat sapien, in vulputate felis sollicitudin nec. Mauris sit amet cursus nunc, nec porta elit. Etiam tincidunt elit nulla, eu tempor lorem malesuada mollis. Nam consequat nisl quis massa lobortis laoreet. Phasellus aliquam metus vitae odio mollis feugiat. Vivamus sit amet fringilla est, quis rutrum mauris. Quisque dui mi, imperdiet et tempus eget, feugiat et lectus. Morbi ut risus felis. Suspendisse quis eleifend neque. Etiam consequat eros ut nisi vestibulum, eget rutrum massa ullamcorper. Praesent condimentum egestas justo a rhoncus. Suspendisse nec sem sollicitudin, euismod."
  }

  public static func loremIpsum(words count: Int = 8) -> String? {
    guard count <= 200 else { return nil }
    let set = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
    let components = String.lorem_words_200.components(separatedBy: set)
    let array = components.filter { !$0.isEmpty }
    let words = array.prefix(count)
    return words.joined(separator: " ").sentenceCapitalized
  }
  
  public var sentenceCapitalized: String {
    let first = self.prefix(1).capitalized
    let remaining = self.dropFirst().lowercased()
    return first + remaining
  }
  
  public func uniqueStrings(splitBy separator: Element = " ") -> [String] {
    let array = self
      .split(separator: separator)
      .map(String.init)
    let uniqueItems = Set(array)
    return Array(uniqueItems)
  }
}
