import Foundation

// MARK: - TV
struct TVModel: Codable, Identifiable {
  let adult: Bool
  let backdropPath: String
  let genreIDS: [Int]?
  let id: Int
  let originCountry: [String]?
  let originalLanguage, originalName, overview: String
  let popularity: Double
  let posterPath, name: String
  let firstAirDate: String?
  let voteAverage: Double
  let voteCount: Int

  var posterURL: URL? {
    URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
  }

  var formattedVoteAverage: String {
    String(format: "%.1f", voteAverage)
  }
}

// MARK: - DetailTV
struct DetailTVModel: Codable, Identifiable {
  let adult: Bool
  let backdropPath: String
  let createdBy: [CreatedBy]?
  let episodeRunTime: [Int]?
  let firstAirDate: String
  let genres: [Genre]
  let homepage: String
  let id: Int
  let inProduction: Bool
  let languages: [String]
  let lastAirDate: String
  let lastEpisodeToAir: LastEpisodeToAir?
  let name: String
  let nextEpisodeToAir: NextEpisodeToAir?
  let networks: [Network]
  let numberOfEpisodes, numberOfSeasons: Int
  let originCountry: [String]
  let originalLanguage, originalName, overview: String
  let popularity: Double
  let posterPath: String
  let productionCompanies: [Network]
  let productionCountries: [ProductionCountry]
  let seasons: [Season]?
  let spokenLanguages: [SpokenLanguage]
  let status, tagline, type: String
  let voteAverage: Double
  let voteCount: Int

  var backdropURL: URL? {
    URL(string: "https://image.tmdb.org/t/p/w780/\(backdropPath)")
  }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
  let id: Int
  let name, originalName: String
  let gender: Int
  let creditID, profilePath: String?
}

// MARK: - LastEpisodeToAir
struct LastEpisodeToAir: Codable {
  let id: Int
  let name, overview: String
  let voteAverage: Double
  let voteCount: Int
  let airDate: String
  let episodeNumber: Int
  let episodeType, productionCode: String
  let runtime, seasonNumber, showID: Int?
  let stillPath: String?
}

// MARK: - Network
struct Network: Codable {
  let id: Int
  let logoPath: String?
  let name, originCountry: String
}

// MARK: - Season
struct Season: Codable {
  let airDate: String?
  let episodeCount, id: Int
  let name, overview, posterPath: String?
  let seasonNumber: Int
  let voteAverage: Double
}

// MARK: - NextEpisodeToAir
struct NextEpisodeToAir: Codable {
  let id: Int
  let name: String
  let airDate: String?
}
