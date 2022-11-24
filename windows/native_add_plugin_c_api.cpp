#include "include/native_add/native_add_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "native_add_plugin.h"

void NativeAddPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  native_add::NativeAddPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
