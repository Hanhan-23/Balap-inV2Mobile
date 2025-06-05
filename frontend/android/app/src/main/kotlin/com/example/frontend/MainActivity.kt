// android/app/src/main/kotlin/com/example/frontend/MainActivity.kt
package com.example.frontend

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.frontend/api_key"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getApiKey") {
                try {
                    val aiKey = getMetaData("com.google.android.geo.API_KEY")
                    if (aiKey != null) {
                        result.success(aiKey)
                    } else {
                        result.error("UNAVAILABLE", "API key not found in manifest", null)
                    }
                } catch (e: Exception) {
                    result.error("ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getMetaData(key: String): String? {
        val appInfo = applicationContext.packageManager.getApplicationInfo(applicationContext.packageName, PackageManager.GET_META_DATA)
        return appInfo.metaData?.getString(key)
    }
}