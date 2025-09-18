package com.balladeart.ballade_art

import android.util.DisplayMetrics
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "dpi_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDpi") {
                val metrics: DisplayMetrics = resources.displayMetrics
                val map: HashMap<String, Any> = hashMapOf(
                    "xdpi" to metrics.xdpi,
                    "ydpi" to metrics.ydpi
                )
                result.success(map)
            } else {
                result.notImplemented()
            }
        }
    }
}
