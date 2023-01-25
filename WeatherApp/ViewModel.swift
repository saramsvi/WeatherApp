import Foundation
//Data needed by the view

class WeatherViewModel: ObservableObject {
    //  @Published every time view property gets updated any view holding on to an instance will update the respective  UI
    @Published var title :  String  = "_"
    @Published  var description :  String  = "_"
    @Published  var temp :  String  = "_"
    @Published  var timezone :  String  = "_"
    
    init(){
        fetchWeather()
    }
    func fetchWeather(){
        guard let url =  URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=0f9ddeb08d235df4381f0b86071c4f94") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _, error  in
            guard let data =  data, error == nil else{
                return
            }
            //convert data to model
            do{
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async{
                    
                    self.title = model.current.weather.first?.main ?? "No title"
                    self.description = model.current.weather.first?.description ?? "No description"
                    self.temp = "\(model.current.temp)°"
                    self.timezone = model.timezone
                }
              
            }
            catch{
                print("failed")
            }
        }
        task.resume()
    }
}
