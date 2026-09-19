package com.turskyi.lifecoach

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ) {
        try {
            super.onActivityResult(requestCode, resultCode, data)
        } catch (e: Exception) {
            if (e.message?.contains(
                    "Reply already " +
                            "submitted"
                ) == true ||
                e.cause?.message?.contains(
                    "Reply already " +
                            "submitted"
                ) == true
            ) {
                // Swallow the known Flutter Engine ProcessTextPlugin
                // framework crash
            } else {
                throw e
            }
        }
    }
}
