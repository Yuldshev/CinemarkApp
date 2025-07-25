import Foundation

// MARK: - Person
struct PersonModel: Codable, Identifiable {
  let adult: Bool
  let gender, id: Int
  let knownForDepartment: String?
  let name, originalName: String
  let popularity: Double
  let profilePath: String?
  let knownFor: [KnownFor]

  var profileURL: URL? {
    guard let profilePath = profilePath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/original/\(profilePath)")
  }
}

struct KnownFor: Codable {
  let adult: Bool
  let backdropPath: String?
  let id: Int
  let title, originalTitle: String?
  let overview, posterPath: String
  let mediaType: String?
  let originalLanguage: String?
  let genreIDS: [Int]?
  let popularity: Double
  let releaseDate: String?
  let video: Bool?
  let voteAverage: Double
  let voteCount: Int
  let name, originalName, firstAirDate: String?
  let originCountry: [String]?
}

// MARK: - DetailPerson
struct DetailPersonModel: Codable, Identifiable {
  let adult: Bool
  let alsoKnownAs: [String]
  let biography, birthday: String?
  let deathday: String?
  let gender: Int
  let homepage: String?
  let id: Int
  let imdbID, knownForDepartment, placeOfBirth: String?
  let name: String
  let popularity: Double
  let profilePath: String?

  var profileURL: URL? {
    guard let profilePath = profilePath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/original/\(profilePath)")
  }
}
