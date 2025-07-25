import Foundation

enum APIEndpoints {
  // MARK: - Movie
  case moviePopular(page: Int)
  case movieTopRated(page: Int)
  case movieUpcoming(page: Int)
  case movieNowPlaying(page: Int)
  case movieID(Int)

  // MARK: - TV
  case tvPopular(page: Int)
  case tvTopRated(page: Int)
  case tvOnTheAir(page: Int)
  case tvID(Int)

  // MARK: - Person
  case personPopular(page: Int)
  case personID(Int)

  private var baseURL: URL {
    guard let url = URL(string: "https://api.themoviedb.org/3") else {
      fatalError("Invalid base URL")
    }
    return url
  }

  private var path: String {
    switch self {
    case .moviePopular: return "/movie/popular"
    case .movieTopRated: return "/movie/top_rated"
    case .movieUpcoming: return "/movie/upcoming"
    case .movieNowPlaying: return "/movie/now_playing"
    case .movieID(let id): return "/movie/\(id)"

    case .tvPopular: return "/tv/popular"
    case .tvTopRated: return "/tv/top_rated"
    case .tvOnTheAir: return "/tv/on_the_air"
    case .tvID(let id): return "/tv/\(id)"

    case .personPopular: return "/person/popular"
    case .personID(let id): return "/person/\(id)"
    }
  }

  private var parameters: [String: Any] {
    let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
    var params: [String: Any] = ["api_key": Secret.apiKey, "language": languageCode]

    switch self {
    case .moviePopular(let page), .movieTopRated(let page), .movieUpcoming(let page), .movieNowPlaying(let page),
          .tvPopular(let page), .tvTopRated(let page), .tvOnTheAir(let page), .personPopular(let page):
        params["page"] = page
    case .movieID, .tvID, .personID: break
    }

    return params
  }

  var urlRequest: URLRequest {
    let url = baseURL.appendingPathComponent(path)

    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      fatalError("Invalid URL: \(url)") // или обработка ошибки
    }

    components.queryItems = parameters.map { key, value in
      URLQueryItem(name: key, value: "\(value)")
    }

    guard let finalURL = components.url else {
      fatalError("Could not construct final URL from components: \(components)")
    }

    var request = URLRequest(url: finalURL)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    return request
  }
}
