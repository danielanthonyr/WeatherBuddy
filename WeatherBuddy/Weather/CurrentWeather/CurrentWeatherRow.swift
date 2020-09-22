import SwiftUI

struct CurrentWeatherRow: View {
  private let viewModel: CurrentWeatherRowViewModel
  
  init(viewModel: CurrentWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    GeometryReader { geometry in
        VStack(alignment: .center) {
            Image(systemName: WeatherViewProperties.icon["\(self.viewModel.fullDescription)"] ?? "nil")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geometry.size.width * 0.80)
            
            Text(self.viewModel.fullDescription.capitalized).font(.largeTitle)
            
            HStack {
                Image(systemName: "thermometer")
              Text("Temperature:")
                Text("\(self.viewModel.temperature)°")
                .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "sun.max")
              Text("Max temperature:")
                Text("\(self.viewModel.maxTemperature)°")
                .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "thermometer.sun")
              Text("Min temperature:")
                Text("\(self.viewModel.minTemperature)°")
                .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "sun.dust")
              Text("Humidity:")
                Text(self.viewModel.humidity)
                .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "sunrise")
                Text("Sunrise:")
                Text("\(self.viewModel.sunrise)")
                .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "sunset")
                Text("Sunset:")
                Text("\(self.viewModel.sunset)")
                .foregroundColor(.gray)
            }
        }
    }
  }
}
