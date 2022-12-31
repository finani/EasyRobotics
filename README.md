# native_cpp

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment

### Android

> macOS - Android Studio

### iOS

> macOS - XCode

### macOS

> macOS - XCode

### Windows

> macOS - Parallels - Windows 11

### Linux

> macOS - Parallels - Ubuntu 20.04

1. Install cmake

    ``` bash
    sudo apt install cmake
    ```

2. Install dependencies

    ``` bash
    sudo apt install clang ninja-build libgtk-3-dev
    ```

3. Install flutter

    ``` bash
    mkdir development
    cd development
    git clone https://github.com/flutter/flutter.git -b stable
    echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
    source ~/.bashrc
    flutter precache
    ```

4. Build cppRobotics

    ``` bash
    git clone git@github.com:finani/EasyRobotics.git
    cd EasyRobotics/cppRobotics
    mkdir build
    cd build
    cmake ..
    cmake --build .
    ```

5. Run flutter

    ``` bash
    cd EasyRobotics/example
    flutter doctor -v
    flutter run -d linux
    ```
