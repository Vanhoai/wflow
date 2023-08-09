package com.flow.wfow

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onStart() {
        super.onStart()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }


    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
    }

    companion object {
          init {
                System.loadLibrary("wfow")
          }
    }
}

