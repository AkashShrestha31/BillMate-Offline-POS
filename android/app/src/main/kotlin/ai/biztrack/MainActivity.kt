package ai.biztrack

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // Explicit registration (do not call super — avoids duplicate / reflection issues).
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
