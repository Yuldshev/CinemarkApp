import Foundation
import XCTest
@testable import CinemarkApp

final class PersonEndpointTests: XCTestCase {
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

  // MARK: - Person Endpoint Tests
  func test_request_personPopular_success() async throws {
    let expectedResponse: Response<PersonModel> = try jsonLoader.loadJSON(from: "PersonPopularResponse.json")
    sut.result = .success(expectedResponse)

    let response: Response<PersonModel> = try await sut.request(.personPopular(page: 1))

    XCTAssertEqual(response.page, 1)
    XCTAssertEqual(response.results.count, 20)
    XCTAssertEqual(response.results.first?.name, "Джейсон Стэтхэм")
    XCTAssertEqual(response.results.last?.name, "Дэвид Коренсвет")
  }

  func test_request_personID_success() async throws {
    let expectedResponse: DetailPersonModel = try jsonLoader.loadJSON(from: "PersonIDResponse.json")
    sut.result = .success(expectedResponse)

    let response: DetailPersonModel = try await sut.request(.personID(1892))

    XCTAssertEqual(response.id, 1892)
    XCTAssertEqual(response.name, "Мэтт Деймон")
  }
}
