# Flutter Desktop To-Do List Application

A minimalist, elegant to-do list application built specifically for Windows desktop using Flutter. This project demonstrates how to create a native desktop application with Flutter while handling window management and native desktop interactions.

## Features

- 🪟 Custom window management (draggable, frameless window)
- ✨ Clean, minimalist design with a pink theme
- ➕ Add and remove tasks easily
- 💾 Prevent closing when tasks are present
- 🖱️ Draggable window interface

## Development Journey & Challenges

During the development of this application, I encountered and overcame several challenges:

### 1. Window Management
- Initial difficulty with window dragging functionality
- Solved by implementing proper window manager callbacks
- Learned about native window behavior in desktop applications

### 2. Platform-Specific Code
- Simplified the project by removing unnecessary mobile and web platform code
- Focused solely on Windows desktop implementation
- Streamlined dependencies to include only what's needed for Windows

### 3. UI/UX Considerations
- Implemented a frameless window design
- Added protection against accidental closure when tasks are present
- Created a clean, intuitive interface

## Setup and Running

1. Ensure you have Flutter installed and Windows desktop development enabled:
```powershell
flutter config --enable-windows-desktop
```

2. Install dependencies:
```powershell
flutter pub get
```

3. Run the application:
```powershell
flutter run -d windows
```

## Project Structure

The project has been streamlined to include only Windows desktop-specific code:

```
to_do_desktop/
├── lib/
│   └── main.dart          # Main application code
├── windows/               # Windows platform-specific code
├── pubspec.yaml           # Project dependencies
└── README.md             # Project documentation
```

## Technologies Used

- Flutter SDK
- window_manager package for native window control
- Material Design for UI components

## Lessons Learned

1. Desktop application development requires different considerations than mobile apps
2. Window management is crucial for a good desktop experience
3. Keeping dependencies minimal improves application performance
4. Platform-specific code organization is important for maintenance

## Future Improvements

- [ ] Add data persistence
- [ ] Implement task categories
- [ ] Add due dates to tasks
- [ ] Create task priority levels
- [ ] Add custom themes

## Contributing

Feel free to contribute to this project by creating issues or submitting pull requests.

## License

This project is licensed under the MIT License.
