# NPS Plugin

<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>

---

A Flutter package 💙 **100% native** to display a review collection in style [NPS (Net Promoter Score)](https://en.wikipedia.org/wiki/Net_promoter_score).

This package allows you to show a modal with a rating scale of 0 to 10, as well as optional fields for feedback and phone number. It is compatible with web, desktop and mobile platforms, and also supports the dark theme.

<img src="https://github.com/wellitonklein/wellitonklein/assets/17295513/1fd0cfda-5b80-471b-ab20-46cf6ca34552" width="800" >
<img src="https://github.com/wellitonklein/wellitonklein/assets/17295513/af35ad4e-d663-45ec-8e32-ef5a6ad24b5e" width="800" >

## Installation

To use this package, add `nps_plugin` as a dependency in your `pubspec.yaml` file.

```sh
flutter pub add nps_plugin
```

Then import the package into your code:

```dart
import 'package:nps_plugin/nps_plugin.dart';
```

## How to use
Here is a basic example of how to use the package to display the NPS rating modal:

```dart
await npsStart(
  context,
  npsTitle: 'So far, how likely are you to recommend the ',
  owner: 'Flutter',
  feedbackTitle: 'Leave your feedback',
  showInputPhone: false,
);
```

You can customize the title, system or company name, and other settings as needed.

## Compatibilities
This package is compatible with the following platforms:

- Mobile (Android and iOS)
- Desktop (Windows, macOS and Linux)
- Web

## Dark Theme
Compatibility with Flutter's dark theme. It automatically adjusts to your app's theme.

## Material 2 e 3
Compatibility with versions 2 and 3 of Google Material.

## Contributions and Problems
This package is open source and you are encouraged to report problems or submit suggestions for improvements via issues on [GitHub Issues](https://github.com/wellitonklein/nps_plugin/issues).

## License
This package is distributed under the [MIT License](https://en.wikipedia.org/wiki/MIT_License). See the LICENSE file for details.
