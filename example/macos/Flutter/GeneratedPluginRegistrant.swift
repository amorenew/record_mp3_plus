//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audioplayers_darwin
import flutter_desktop_audio_recorder
import path_provider_foundation
import permission_handler_apple
import record_mp3_plus

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioplayersDarwinPlugin.register(with: registry.registrar(forPlugin: "AudioplayersDarwinPlugin"))
  FlutterDesktopAudioRecorderPlugin.register(with: registry.registrar(forPlugin: "FlutterDesktopAudioRecorderPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  PermissionHandlerPlugin.register(with: registry.registrar(forPlugin: "PermissionHandlerPlugin"))
  RecordMp3Plugin.register(with: registry.registrar(forPlugin: "RecordMp3Plugin"))
}
