//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import device_info_plus_macos
import geolocator_apple
import package_info_plus_macos
import path_provider_macos
import sign_in_with_apple
import url_launcher_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  FLTPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SignInWithApplePlugin.register(with: registry.registrar(forPlugin: "SignInWithApplePlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
}
