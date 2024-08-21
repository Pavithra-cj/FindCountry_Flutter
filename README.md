# find_country_flutter

This Flutter app fetches and displays a list of European countries, allowing users to sort the countries by population, name, and capital, and view detailed information about each country.

## Features

- Fetches data from the REST Countries API.
- Displays European countries with their names, capitals, flags, and population.
- Allows users to sort countries by:
    - Population
    - Name
    - Capital
- Provides detailed information about a selected country, including:
    - Official name
    - Population
    - Languages spoken
    - Flag
- Implements error handling for network issues.
- Optimized for performance and responsive UI design.

## API

This app uses the [REST Countries API](https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population) to fetch the data for European countries. The data includes:
- Country name
- Capital
- Flag
- Region
- Languages
- Population

## Requirements

- Flutter SDK (>= 2.10.0)
- Dart SDK (>= 2.15.0)
- Dio for API handling
- Retrofit for API integration
- A device or emulator to run the app

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/european-countries-app.git
    ```
2. Navigate to the project directory:
    ```bash
    cd european-countries-app
    ```
3. Get the dependencies:
    ```bash
    flutter pub get
    ```

## Usage

1. Run the app on an emulator or a physical device:
    ```bash
    flutter run
    ```
2. The app will display a list of European countries with flags, names, and capitals.
3. Use the sorting dropdown to sort the countries by population, name, or capital.
4. Tap on a country to view detailed information.

## Testing

Unit tests have been written for key components of the app. To run tests:

```bash
flutter test
```

### Contact

- **Name**: Pavithra Chamod
- **Email**: pavithrachamodj@gmail.com