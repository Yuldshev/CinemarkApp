import Foundation

final class NetworkLogger {
  static let shared = NetworkLogger()

  private init() {}

  func logRequest(_ request: URLRequest) {
    print("🌐 REQUEST:")
    print("   URL: \(request.url?.absoluteString ?? "Unknown")")
    print("   Method: \(request.httpMethod ?? "GET")")

    if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
      print("   Headers: \(headers)")
    }

    if let body = request.httpBody,
       let bodyString = String(data: body, encoding: .utf8) {
      print("   Body: \(bodyString)")
    }

    print("   ⏰ \(Date())")
    print("----------------------------------------")
  }

  func logResponse(_ response: HTTPURLResponse, data: Data?) {
    let statusEmoji = statusCodeEmoji(response.statusCode)

    print("📡 RESPONSE:")
    print("   \(statusEmoji) Status Code: \(response.statusCode)")
    print("   URL: \(response.url?.absoluteString ?? "Unknown")")

    if let data = data {
      print("   Data Size: \(data.count) bytes")

      if let jsonString = String(data: data, encoding: .utf8) {
        let preview = String(jsonString.prefix(500))
        print("   Data Preview: \(preview)\(jsonString.count > 500 ? "..." : "")")
      }
    }

    print("   ⏰ \(Date())")
    print("----------------------------------------")
  }

  func logError(_ error: Error, for request: URLRequest) {
    print("❌ ERROR:")
    print("   URL: \(request.url?.absoluteString ?? "Unknown")")
    print("   Error: \(error.localizedDescription)")

    if let networkError = error as? NetworkError {
      switch networkError {
      case .httpError(let statusCode):
        print("   Status Code: \(statusCode)")
      case .decodingError(let decodingError):
        print("   Decoding Error: \(decodingError.localizedDescription)")
      case .networkError(let underlyingError):
        print("   Network Error: \(underlyingError.localizedDescription)")
      case .invalidResponse:
        print("   Invalid Response")
      default:
        break
      }
    }

    print("   ⏰ \(Date())")
    print("========================================")
  }

  private func statusCodeEmoji(_ statusCode: Int) -> String {
    switch statusCode {
    case 200...299: return "✅"
    case 300...399: return "↩️"
    case 400...499: return "⚠️"
    case 500...599: return "🔥"
    default: return "❓"
    }
  }
}
