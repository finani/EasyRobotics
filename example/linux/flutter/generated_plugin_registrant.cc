//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <native_cpp/native_cpp_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) native_cpp_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "NativeCppPlugin");
  native_cpp_plugin_register_with_registrar(native_cpp_registrar);
}
