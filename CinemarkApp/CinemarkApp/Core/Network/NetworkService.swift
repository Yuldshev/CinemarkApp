import Foundation

protocol NetworkServiceProtocol {
  func request<T: Decodable>(_ endpoint: APIEndpoints) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
  static let shared = NetworkService()

  private let session: URLSession
  private let decoder: JSONDecoder

  private init() {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    self.session = URLSession(configuration: configuration)

    self.decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }

  func request<T: Decodable>(_ endpoint: APIEndpoints) async throws -> T {
    let request = endpoint.urlRequest

    // Log request
    NetworkLogger.shared.logRequest(request)

    do {
      let (data, response) = try await session.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse else {
        let error = NetworkError.invalidResponse
        NetworkLogger.shared.logError(error, for: request)
        throw error
      }

      // Log response
      NetworkLogger.shared.logResponse(httpResponse, data: data)

      guard 200...299 ~= httpResponse.statusCode else {
        let error = NetworkError.httpError(httpResponse.statusCode)
        NetworkLogger.shared.logError(error, for: request)
        throw error
      }

      return try decoder.decode(T.self, from: data)

    } catch let decodingError as DecodingError {
      let error = NetworkError.decodingError(decodingError)
      NetworkLogger.shared.logError(error, for: request)
      throw error
    } catch let networkError as NetworkError {
      // Already logged above
      throw networkError
    } catch {
      let networkError = NetworkError.networkError(error)
      NetworkLogger.shared.logError(networkError, for: request)
      throw networkError
    }
  }
}
