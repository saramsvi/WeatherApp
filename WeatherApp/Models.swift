import Foundation
//convert json models in to structs
struct WeatherModel : Codable{
    let timezone : String
    let current : CurrentWeather
}
struct CurrentWeather : Codable{
    let temp : Float
    let weather : [WeatherInfo]
}

struct WeatherInfo  :  Codable {
    let main : String
    let description : String
    
}
