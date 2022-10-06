PLATFORM=30

freesplitscreen.zip: magiskmodule/system/product/overlay/de.lucaber.android.freesplitscreen.apk
	rm $@
	cd magiskmodule && zip -r ../$@ . 

build/de.lucaber.android.freesplitscreen.unaligned.apk: overlay/res/values/config.xml
	aapt package -f -F $@ -M "overlay/AndroidManifest.xml" -S "overlay/res" -I ${ANDROID_HOME}/platforms/android-$(PLATFORM)/android.jar

build/de.lucaber.android.freesplitscreen.aligned.apk: build/de.lucaber.android.freesplitscreen.unaligned.apk
	zipalign -f -p 4 $< $@

magiskmodule/system/product/overlay/de.lucaber.android.freesplitscreen.apk: build/de.lucaber.android.freesplitscreen.aligned.apk
	echo "123123" | apksigner sign --ks build/apkkey.keystore  --out $@ $<

clean:
	rm -f build/*.apk magiskmodule/system/product/overlay/*