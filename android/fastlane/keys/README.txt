Play Store deploy key (service account JSON)
==============================================

Google Play no longer shows a separate "API access" menu on many accounts.
Use Google Cloud + "Users and permissions" instead.

PART A — Google Cloud (create JSON key)
---------------------------------------
1. Open https://console.cloud.google.com/
2. Create or select a project (any name, e.g. "play-deploy")
3. APIs & Services → Library → search "Google Play Android Developer API" → Enable
4. IAM & Admin → Service accounts → Create service account
   - Name: play-deploy → Create → Done (no GCP roles required)
5. Open that service account → Keys → Add key → Create new key → JSON → Create
6. Save the downloaded file as:
     android/fastlane/keys/play-store-key.json
7. Copy the service account EMAIL (ends with @....iam.gserviceaccount.com)

PART B — Play Console (grant access) — matches your sidebar
------------------------------------------------------------
1. https://play.google.com/console
2. Left menu → Users and permissions   (NOT "Developer account")
3. Click Invite new users
4. Paste the service account EMAIL from part A (not your Gmail)
5. Permissions:
   - Account: allow release to testing tracks (+ production if needed)
   - App permissions: select Nepal / India / Korean apps (or all apps)
6. Send invite / Save

Wait 15–60 minutes if upload returns 403.

PART C — Ruby 3+ for Fastlane (required on Mac)
-----------------------------------------------
macOS system ruby (/usr/bin/ruby 2.6) is too old. Use Homebrew:

  brew install ruby
  cd android
  /opt/homebrew/opt/ruby/bin/bundle install
  cd ..

./country.sh picks Homebrew ruby automatically when present.

PART D — Deploy to production (Play Console)
--------------------------------------------
From the android folder:

  cd android
  bundle install
  bundle exec fastlane android deploy

This builds the production AAB and uploads directly to the production track.

Other lanes:
  bundle exec fastlane android playstore_internal
  bundle exec fastlane android playstore_beta
  bundle exec fastlane android playstore_production

Copy .env.playstore.example → .env.playstore and set FLUTTER_BIN if needed.

Signing: android/key.properties + release keystore (same as release builds).
