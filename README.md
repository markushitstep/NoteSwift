# Weather Notes App

A simple iOS application built with SwiftUI that allows users to create notes enriched with current weather data.

## ✨ Features

- Notes list screen
- Add note screen
- Input validation
- Toast error messages
- Weather integration via OpenWeather API
- Local storage using UserDefaults
- Note details screen

---

## 🛠 Tech Stack

- Swift
- SwiftUI
- URLSession
- UserDefaults
- OpenWeather API

---

## 📁 Project Structure

```text
NoteApp/
├── Models/
│   ├── Note.swift
│   └── WeatherResponse.swift
│
├── Services/
│   ├── WeatherService.swift
│   ├── StorageService.swift
│   └── NoteValidator.swift
│
├── Views/
│   ├── ContentView.swift
│   ├── AddNoteView.swift
│   ├── NoteView.swift
│   ├── NoteDetailView.swift
│   └── ToastView.swift
│
└── NoteAppApp.swift
```

## 🚀 Setup

1. Clone the repository
2. Open the project in Xcode
3. Register at:
   https://openweathermap.org/api
4. Create an API key
5. Open `WeatherService.swift`
6. Replace:

```swift
private let apiKey = "YOUR_API_KEY"
```

with your actual API key.
