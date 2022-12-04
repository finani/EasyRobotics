#include "include/native_cpp/native_cpp_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "native_cpp_plugin.h"

void NativeCppPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  native_cpp::NativeCppPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
