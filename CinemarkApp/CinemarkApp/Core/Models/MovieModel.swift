import Foundation

// MARK: - Movie
struct MovieModel: Codable, Identifiable {
  let adult: Bool
  let backdropPath: String
  let genreIDS: [Int]?
  let id: Int
  let originalLanguage: String?
  let originalTitle, overview: String
  let popularity: Double
  let posterPath, releaseDate, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int

  var posterURL: URL? {
    URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
  }

  var formattedVoteAverage: String {
    String(format: "%.1f", voteAverage)
  }
}

// MARK: - MovieID
struct DetailMovieModel: Codable, Identifiable {
  let adult: Bool
  let backdropPath: String
  let belongsToCollection: BelongsToCollection?
  let budget: Int
  let genres: [Genre]
  let homepage: String
  let id: Int
  let imdbID: String?
  let originCountry: [String]
  let originalLanguage, originalTitle, overview: String
  let popularity: Double
  let posterPath: String
  let productionCompanies: [ProductionCompany]?
  let productionCountries: [ProductionCountry]?
  let releaseDate: String
  let revenue, runtime: Int
  let spokenLanguages: [SpokenLanguage]
  let status, tagline, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int

  var backdropURL: URL? {
    URL(string: "https://image.tmdb.org/t/p/w780/\(backdropPath)")
  }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
  let id: Int
  let name: String
  let posterPath: String?
  let backdropPath: String?
}

// MARK: - Genre
struct Genre: Codable {
  let id: Int
  let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
  let id: Int
  let logoPath, name, originCountry: String?
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
  let iso31661, name: String?

  enum CodingKeys: String, CodingKey {
    case iso31661 = "iso_3166_1"
    case name
  }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
  let englishName, iso6391, name: String?

  enum CodingKeys: String, CodingKey {
    case iso6391 = "iso_639_1"
    case name, englishName
  }
}
