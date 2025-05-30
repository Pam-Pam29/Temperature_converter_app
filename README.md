# Temperature Converter App

A Flutter mobile application that converts temperatures between Fahrenheit and Celsius with history tracking and a responsive design.

##  Features

- **Dual Conversion Support**: Convert between Fahrenheit to Celsius and Celsius to Fahrenheit
- **Precise Calculations**: Results displayed to exactly 2 decimal places
- **Conversion History**: Tracks all conversions with formatted display
- **Input Validation**: Comprehensive error handling for invalid inputs
- **Responsive Design**: Optimised for both portrait and landscape orientations
- **Modern UI**: Clean, Material Design-inspired interface

##  Conversion Formulas

The app uses the standard temperature conversion formulas:
- **Celsius to Fahrenheit**: °F = °C × 9/5 + 32
- **Fahrenheit to Celsius**: °C = (°F - 32) × 5/9


##  App Architecture

### **Main Components**

1. **MyApp (StatelessWidget)**
   - Root application widget
   - Configures MaterialApp with consistent theming
   - Sets up colour scheme and button styles

2. **TemperatureConverter (StatefulWidget)**
   - Main screen containing all functionality
   - Manages app state and user interactions

3. **_TemperatureConverterState (State)**
   - Handles all state management and UI updates
   - Contains conversion logic and history management

### **Key State Variables**
- `inputController`: Manages text input field
- `selectedConversion`: Tracks current conversion type
- `conversionResult`: Stores calculated result
- `conversionHistory`: List of all conversion records

##  Widgets Used

### **Layout Widgets**
- `Scaffold`: Main app structure
- `AppBar`: Top navigation bar
- `Card`: Elevated containers for sections
- `Column`/`Row`: Vertical and horizontal layouts
- `Expanded`: Responsive width distribution
- `SingleChildScrollView`: Scrollable content
- `OrientationBuilder`: Responsive orientation handling

### **Input Widgets**
- `TextField`: Temperature value input
- `TextEditingController`: Input management
- `RadioListTile`: Conversion type selection

### **Interactive Widgets**
- `ElevatedButton`: Primary convert action
- `TextButton`: Secondary actions (clear history)
- `AlertDialog`: Error message display

### **Display Widgets**
- `Text`: Various text displays
- `Icon`: Visual indicators
- `Container`: Custom styling containers
- `ListView.builder`: Dynamic history list


##  Responsive Design

### **Portrait Orientation**
- Vertical layout with full-height history section
- Optimal spacing for touch interactions
- Clear visual hierarchy

### **Landscape Orientation**  
- Adjusted history section height (150px vs 250px)
- Maintained functionality and accessibility
- Consistent visual design

##  Installation & Setup

### **Prerequisites**
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or physical device

### **Getting Started**

1. **Clone the repository**
   ```bash
   git clone
   cd temperature-converter-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### **Build for Release**
```bash
# Android
flutter build apk --release

# iOS (requires Mac)
flutter build ios --release
```

### **Test Cases**
1. **Standard Conversions**
   - 32°F → 0.00°C
   - 100°C → 212.00°F
   - 0°C → 32.00°F


##  Contributing

This is an academic project, but we welcome suggestions for improvement.

##  License

This project is created for educational purposes as part of a Flutter development course.

---

**Author**: Victoria Fakunle 
**Course**: Mobile App Development  
**Assignment**: Individual Assignment 1  
