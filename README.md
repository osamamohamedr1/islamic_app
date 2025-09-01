# Islamic App 🕌

A comprehensive Islamic mobile application built with Flutter, designed to help Muslims in their daily spiritual practices with prayer times, Azkar, Quran audio, and more.

## ✨ Features

### 🕐 Prayer Times
- Accurate prayer times based on user's location
- Next prayer countdown with beautiful visual indicators
- Prayer notifications with custom sound (Azan)
- Background scheduling for daily prayer notifications
- Support for Egyptian calculation method with Shafi madhab

### 📿 Azkar & Duas
- Morning and evening Azkar (Islamic remembrances)
- Various Azkar collections
- All Duas with Arabic text
- Favorites system for easy access
- Counter functionality for repetitive prayers

### 🎧 Quran Audio
- Complete Quran audio player
- Multiple reciters support
- Background audio playback
- Progress tracking and controls
- Surah selection and navigation

### 🕌 Mosque Finder
- Find nearest mosques using Google Maps
- Location-based mosque search
- Interactive map with mosque markers
- User location tracking

### 🤲 Additional Features
- **Location Services** for accurate prayer times
- **Notification Management** with user preferences
- **Favorites System** for Azkar and prayers
- **Theme Support** (Light/Dark modes)
- **Offline Support** with local data caching
- **Arabic Language Support** with proper RTL layout

## 🛠️ Technologies Used

- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language
- **BLoC/Cubit** - State management
- **Hive** - Local database for offline storage
- **Google Maps** - Location services and mosque finder
- **Just Audio** - Audio playback for Quran
- **Adhan** - Prayer times calculations
- **Flutter Local Notifications** - Prayer time notifications
- **WorkManager** - Background task scheduling
- **Timezone** - Accurate time zone handling


## 🚀 Getting Started

### Configuration

1. **Location Permissions**: The app requires location access for accurate prayer times
2. **Notification Permissions**: Enable notifications for prayer time reminders
3. **Audio Permissions**: Required for Quran audio playback

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities and shared components
│   ├── functions/          # Helper functions and services
│   ├── models/             # Data models
│   ├── routes/             # Navigation and routing
│   ├── themes/             # App themes and styling
│   └── utils/              # Utility classes and constants
├── features/               # Feature-based architecture
│   ├── azkar/             # Azkar and Duas functionality
│   ├── home/              # Home screen with prayer times
│   ├── quran_audio/       # Quran audio player
│   ├── find_nearest_masjd/ # Mosque finder
│   ├── prayer_notifications/ # Prayer time notifications
│   ├── favorites/         # Favorites management
│   ├── settings/          # App settings
│   └── choose_location/   # Location selection
└── main.dart              # App entry point
```




- Contact: [osamamohamedr1](https://github.com/osamamohamedr1)


