fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### validate

```sh
[bundle exec] fastlane validate
```

Validate Play Store listing metadata character limits

### download_metadata

```sh
[bundle exec] fastlane download_metadata
```

Download existing store listing metadata from Play Console

### upload_metadata

```sh
[bundle exec] fastlane upload_metadata
```

Upload store listing metadata only (title, short & full descriptions)

### flutter_prepare

```sh
[bundle exec] fastlane flutter_prepare
```

Clean, get dependencies, fix issues, and format Flutter project

### get_release_notes_from_user

```sh
[bundle exec] fastlane get_release_notes_from_user
```

Get release notes from user input and store in ENV['RELEASE_NOTES']

----


## Android

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Build production AAB and publish directly to Play Console (production track)

### android playstore_deploy

```sh
[bundle exec] fastlane android playstore_deploy
```

Build production AAB and upload to Google Play

### android playstore_internal

```sh
[bundle exec] fastlane android playstore_internal
```

Deploy to Play Store internal testing

### android playstore_alpha

```sh
[bundle exec] fastlane android playstore_alpha
```

Deploy to Play Store closed testing (alpha)

### android playstore_beta

```sh
[bundle exec] fastlane android playstore_beta
```

Deploy to Play Store open testing (beta)

### android playstore_production

```sh
[bundle exec] fastlane android playstore_production
```

Deploy to Play Store production

### android alpha

```sh
[bundle exec] fastlane android alpha
```

Build and distribute development APK via Firebase App Distribution

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
