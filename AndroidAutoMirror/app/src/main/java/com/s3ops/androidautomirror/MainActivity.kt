package com.s3ops.androidautomirror

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : AppCompatActivity() {

    private lateinit var statusText: TextView
    private lateinit var startButton: Button
    private lateinit var stopButton: Button
    
    private var isRecording = false
    
    companion object {
        private const val REQUEST_MEDIA_PROJECTION = 1001
        private const val REQUEST_AUDIO_PERMISSION = 1002
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        statusText = findViewById(R.id.statusText)
        startButton = findViewById(R.id.startButton)
        stopButton = findViewById(R.id.stopButton)

        startButton.setOnClickListener {
            requestPermissionsAndStart()
        }

        stopButton.setOnClickListener {
            stopScreenMirroring()
        }

        updateUI()
        
        // Request notification permission for Android 13+
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                    1003
                )
            }
        }
    }

    private fun requestPermissionsAndStart() {
        // Check audio permission
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.RECORD_AUDIO
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.RECORD_AUDIO),
                REQUEST_AUDIO_PERMISSION
            )
            return
        }

        // Request screen capture permission
        val mediaProjectionManager =
            getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        startActivityForResult(
            mediaProjectionManager.createScreenCaptureIntent(),
            REQUEST_MEDIA_PROJECTION
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        if (requestCode == REQUEST_MEDIA_PROJECTION) {
            if (resultCode == Activity.RESULT_OK && data != null) {
                startScreenMirroring(resultCode, data)
            } else {
                Toast.makeText(
                    this,
                    "Screen capture permission denied",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        
        if (requestCode == REQUEST_AUDIO_PERMISSION) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                requestPermissionsAndStart()
            } else {
                Toast.makeText(
                    this,
                    "Audio permission is required for screen mirroring",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }
    }

    private fun startScreenMirroring(resultCode: Int, data: Intent) {
        val serviceIntent = Intent(this, ScreenMirrorService::class.java).apply {
            putExtra("resultCode", resultCode)
            putExtra("data", data)
            action = ScreenMirrorService.ACTION_START
        }
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(serviceIntent)
        } else {
            startService(serviceIntent)
        }
        
        isRecording = true
        updateUI()
        statusText.text = "Status: Mirroring Active 🟢"
    }

    private fun stopScreenMirroring() {
        val serviceIntent = Intent(this, ScreenMirrorService::class.java).apply {
            action = ScreenMirrorService.ACTION_STOP
        }
        startService(serviceIntent)
        
        isRecording = false
        updateUI()
        statusText.text = "Status: Stopped"
    }

    private fun updateUI() {
        startButton.isEnabled = !isRecording
        stopButton.isEnabled = isRecording
        startButton.alpha = if (isRecording) 0.5f else 1.0f
        stopButton.alpha = if (isRecording) 1.0f else 0.5f
    }

    override fun onResume() {
        super.onResume()
        // Check if service is still running
        isRecording = ScreenMirrorService.isRunning
        updateUI()
        if (isRecording) {
            statusText.text = "Status: Mirroring Active 🟢"
        }
    }
}
