/*
 * Copyright 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.hallo2hallo.vanillarally;

import android.Manifest;
import android.app.AlertDialog;
import android.app.NativeActivity;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class NdkTestActivity extends NativeActivity {
    private static final int REQUEST_PERMISSION = 1234;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //Hide toolbar
        int SDK_INT = android.os.Build.VERSION.SDK_INT;
        if(SDK_INT >= 19)
        {
            setImmersiveSticky();

            View decorView = getWindow().getDecorView();
            decorView.setOnSystemUiVisibilityChangeListener(visibility -> setImmersiveSticky());
        }
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
    }

    protected void onResume() {
        super.onResume();

        //Hide toolbar
        setImmersiveSticky();
    }

    void setImmersiveSticky() {
        View decorView = getWindow().getDecorView();
        decorView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN
                | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
    }

    public void showMessage(String title, String message) {
        this.runOnUiThread(() -> {
            new AlertDialog.Builder(this)
                    .setTitle(title)
                    .setMessage(message)
                    .show();
            //Toast.makeText(this, "Hello", Toast.LENGTH_SHORT).show();
        });
    }

    public float xDpi() {
        DisplayMetrics displaymetrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(displaymetrics);
        return displaymetrics.xdpi;
    }

    public float yDpi() {
        DisplayMetrics displaymetrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(displaymetrics);
        return displaymetrics.ydpi;
    }

    public String flavor() {
        return BuildConfig.FLAVOR;
    }

    public void requestReadExternalStoragePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
                && ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                    REQUEST_PERMISSION);
        }
    }
}
