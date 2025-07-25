import Foundation

@Observable
final class JSONLoader {
  static let shared = JSONLoader()

  private init() {}

  func loadJSON<T: Decodable>(from filename: String) throws -> T {
    // First try to load from bundle
    if let url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: nil) {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return try decoder.decode(T.self, from: data)
    }
    
    // Fallback to loading from filesystem
    let currentFileURL = URL(fileURLWithPath: #file)
    let testDirectoryURL = currentFileURL.deletingLastPathComponent()
    let jsonFileURL = testDirectoryURL.appendingPathComponent("JSON_static").appendingPathComponent(filename)
    
    guard FileManager.default.fileExists(atPath: jsonFileURL.path) else {
      fatalError("Failed to locate \(filename) at \(jsonFileURL.path)")
    }
    
    let data = try Data(contentsOf: jsonFileURL)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(T.self, from: data)
  }
}
