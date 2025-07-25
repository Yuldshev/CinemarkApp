import Foundation

enum NetworkError: Error, LocalizedError {
  case invalidResponse
  case httpError(Int)
  case decodingError(DecodingError)
  case networkError(Error)
  case noConnection
  case unknown(Error)

  var errorDescription: String? {
    switch self {
    case .invalidResponse:
      return "Invalid response from server"
    case .httpError(let statusCode):
      return "HTTP error with status code: \(statusCode)"
    case .decodingError(let error):
      return "Failed to decode response: \(error.localizedDescription)"
    case .networkError(let error):
      return "Network error: \(error.localizedDescription)"
    case .noConnection:
      return "No internet connection. Please check your settings."
    case .unknown(let error):
      return "An unknown error occurred: \(error.localizedDescription)"
    }
  }
}
