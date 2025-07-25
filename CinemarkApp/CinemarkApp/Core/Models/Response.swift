import Foundation

struct Response<T: Decodable>: Decodable {
  let page: Int
  let results: [T]
  let totalPages, totalResults: Int?
}
