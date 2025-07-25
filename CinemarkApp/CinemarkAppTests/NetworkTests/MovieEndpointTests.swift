import Foundation
import XCTest
@testable import CinemarkApp

final class MovieEndpointTests: XCTestCase {
  var sut: MockNetworkService!
  private var jsonLoader = JSONLoader.shared

  override func setUp() {
    super.setUp()
    sut = .init()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  // MARK: - Movie Endpoint tests
  func test_request_popularMovies_success() async throws {
    let expectedResponse: Response<MovieModel> = try jsonLoader.loadJSON(from: "MoviePopularResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<MovieModel> = try await sut.request(.moviePopular(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.title, "Как приручить дракона")
    XCTAssertEqual(response.results.last?.title, "З-О-М-Б-И 4: Рассвет вампиров")
  }

  func test_request_topRatedMovies_success() async throws {
    let expectedResponse: Response<MovieModel> = try jsonLoader.loadJSON(from: "MovieTopRatedResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<MovieModel> = try await sut.request(.movieTopRated(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.title, "Побег из Шоушенка")
    XCTAssertEqual(response.results.last?.title, "Могила светлячков")
  }

  func test_request_upcomingMovies_success() async throws {
    let expectedResponse: Response<MovieModel> = try jsonLoader.loadJSON(from: "MovieUpcomingResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<MovieModel> = try await sut.request(.movieUpcoming(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.title, "Каратэ-пацан: Легенды")
    XCTAssertEqual(response.results.last?.title, "Трансформеры: Начало")
  }

  func test_request_nowPlayingMovies_success() async throws {
    let expectedResponse: Response<MovieModel> = try jsonLoader.loadJSON(from: "MovieNowPlayingResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<MovieModel> = try await sut.request(.movieNowPlaying(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.title, "Как приручить дракона")
    XCTAssertEqual(response.results.last?.title, "Экзотическая свадьба Мэдеи")
  }

  func test_request_movieID_success() async throws {
    let expectedResponse: DetailMovieModel = try jsonLoader.loadJSON(from: "MovieIDResponse.json")
    sut.result = .success(expectedResponse)

    let response: DetailMovieModel = try await sut.request(.movieID(278))

    XCTAssertEqual(response.adult, false)
    XCTAssertEqual(response.title, "Побег из Шоушенка")
  }
}
