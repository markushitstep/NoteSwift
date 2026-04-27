import Foundation

struct WeatherData {
    let temperature: Double
    let description: String
}

enum WeatherServiceError: Error {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError
}

final class WeatherService {
    private let apiKey = "b51be12440ea7cd6a0448ebf6949e02a"

    func fetchWeather() async throws -> WeatherData {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Kyiv&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherServiceError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)

            return WeatherData(
                temperature: decodedResponse.main.temp,
                description: decodedResponse.weather.first?.description ?? "No description"
            )

        case 401:
            throw WeatherServiceError.unauthorized

        case 500...599:
            throw WeatherServiceError.serverError

        default:
            throw WeatherServiceError.invalidResponse
        }
    }
}
