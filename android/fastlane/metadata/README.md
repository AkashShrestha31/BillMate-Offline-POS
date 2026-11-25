# Google Play store listings (metadata only)

Text files under `metadata/android/<locale>/` are uploaded with **supply** — no APK, AAB, images, or changelogs.

## Locales (25 — matches in-app languages)

| Play folder | App code | Language |
|-------------|----------|----------|
| `en-US` | en | English |
| `ne-NP` | ne | Nepali |
| `hi-IN` | hi | Hindi |
| `es-419` | es | Spanish (Latin America) |
| `ar` | ar | Arabic |
| `zh-CN` | zh | Chinese (Simplified) |
| `fr-FR` | fr | French |
| `de-DE` | de | German |
| `ja-JP` | ja | Japanese |
| `pt-BR` | pt | Portuguese (Brazil) |
| `ru-RU` | ru | Russian |
| `bn-BD` | bn | Bengali |
| `th` | th | Thai |
| `vi` | vi | Vietnamese |
| `id` | id | Indonesian |
| `ko-KR` | ko | Korean |
| `it-IT` | it | Italian |
| `nl-NL` | nl | Dutch |
| `pl-PL` | pl | Polish |
| `tr-TR` | tr | Turkish |
| `ms` | ms | Malay |
| `fil` | fil | Filipino |
| `ur` | ur | Urdu |
| `fa` | fa | Persian |
| `sw` | sw | Swahili |

Each folder contains:

- `title.txt` — max **30** Unicode characters
- `short_description.txt` — max **80** Unicode characters
- `full_description.txt` — max **4000** Unicode characters

Regenerate missing locales from English + app ARB strings:

```bash
python3 scripts/generate_play_store_metadata.py
```

(Skips locales that already have all three files.)

## Prerequisites

1. Service account JSON at `fastlane/keys/play-store-key.json` (gitignored).
2. That account invited in Play Console → Users and permissions (Release manager or store listing access).
3. App `ai.biztrack` already created on Play Console.

Test the key:

```bash
cd android
bundle exec fastlane run validate_play_store_json_key json_key:fastlane/keys/play-store-key.json
```

## Commands

From the `android/` directory:

```bash
bundle install
bundle exec fastlane validate          # check character limits
bundle exec fastlane upload_metadata   # upload titles/descriptions only
bundle exec fastlane download_metadata # pull existing listings from Play Console
```

## Workflow

1. Edit `fastlane/metadata/android/<locale>/*.txt`
2. `bundle exec fastlane validate`
3. `bundle exec fastlane upload_metadata`
