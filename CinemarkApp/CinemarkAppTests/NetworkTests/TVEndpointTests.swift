import Foundation
import XCTest
@testable import CinemarkApp

final class TVEndpointTests: XCTestCase {
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

  // MARK: - TV Endpoint tests
  func test_request_tvPopular_success() async throws {
    let expectedResponse: Response<TVModel> = try jsonLoader.loadJSON(from: "TVPopularResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<TVModel> = try await sut.request(.tvPopular(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.name, "Watch What Happens Live with Andy Cohen")
    XCTAssertEqual(response.results.last?.name, "Шторм любви")
  }

  func test_request_tvTopRated_success() async throws {
    let expectedResponse: Response<TVModel> = try jsonLoader.loadJSON(from: "TVTopRatedResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<TVModel> = try await sut.request(.tvTopRated(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.name, "Во все тяжкие")
    XCTAssertEqual(response.results.last?.name, "Первый шаг")
  }

  func test_request_tvOnTheAir_success() async throws {
    let expectedResponse: Response<TVModel> = try jsonLoader.loadJSON(from: "TVOnTheAirResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<TVModel> = try await sut.request(.tvOnTheAir(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.name, "Поздней ночью с Сетом Майерсом")
    XCTAssertEqual(response.results.last?.name, "Жители Ист-Энда")
  }

  func test_request_tvID_success() async throws {
    let expectedResponse: DetailTVModel = try jsonLoader.loadJSON(from: "TVIDResponse.json")
    sut.result = .success(expectedResponse)

    let response: DetailTVModel = try await sut.request(.tvID(1396))

    XCTAssertEqual(response.id, 1396)
    XCTAssertEqual(response.name, "Во все тяжкие")
  }
}
