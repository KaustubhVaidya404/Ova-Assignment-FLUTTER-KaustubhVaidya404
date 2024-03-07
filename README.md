# Chat Application

This repository contains the code for an advanced Chat Application. The application facilitates real-time text messaging with machine learning-based input enhancement. Additionally, it supports WebRTC video calling.

![Application Screenshot](Insert the screenshot of your app)

## Project Overview

The Chat Application goes beyond basic messaging by incorporating artificial intelligence to enhance user input. The system suggests improvements for the input text, allowing the sender to modify it before sending. This functionality enhances the overall message quality and improves the user interaction experience.

In addition to messaging, a WebRTC video-calling feature has been partially implemented and is currently under development for full functionality.

## Features

- Real-time messaging
- AI assistance for improving message text
- WebRTC video calling (partially implemented)

## Tech Stack / Technologies Used

- Flutter
- Open AI
- Webrtc
- Firebase
  
***Note please create your own firebae_options.dart and open ai api as it is not added in this repository for privacy reason***

## Steps to build and run the app 

First make sure your machine is equip with dart programming language and flutter framework as the project is build using this.

### 1. Clone the repository 
By entering following command in the terminal of your directory
```bash
git clone git@github.com:KaustubhVaidya404/Ova-Assignment-FLUTTER-KaustubhVaidya404.git
```

### 2. Navigate to the directory by 
```bash
ls 
```
```bash
cd [project directory]
```

### 3. Now install all the dependencies 
For installing all the dependencies run following command in the terminal
```bash
flutter pub add
```
This will install all the dependencies required for the project

### 4. Run the App 
for running the project first initilize the emulator or connect your mobile device with your device (wired/wireless).  \
**Note if you are using your mobile device make sure it has debug mode on** \
Now run following command in the terminal
```bash
flutter run lib/main.dart
```

### Build apk
For building apk file of the project run following command in the terminal 
```bash
flutter build apk 
```
This will create two files one for release and one for debug in the **build/app/outputs/flutter-apk/** 

## Usage

Provide instructions on how to use the application, including any CRUD operations and explanations of all functionalities.

## Future Improvements

- Completion of the video calling feature
- Other features planned for development



## License

Explain the license you're using, for example, the MIT license.

---
