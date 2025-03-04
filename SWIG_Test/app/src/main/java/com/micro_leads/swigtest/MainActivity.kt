package com.micro_leads.swigtest

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import com.micro_leads.swigtest.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

//        swigtest_native_swig.process()
    }



    companion object {
        // Used to load the 'swigtest' library on application startup.
        init {
            System.loadLibrary("swigtest")
            System.loadLibrary("swigtest_native_swig")
        }
    }
}