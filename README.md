# Kartu Profil — Rahman Ar Rafif

A single-screen Flutter profile card. The card sits on a soft dot-grid canvas, carries a brass monogram seal, and tilts slightly under a finger. It enters once on load.

## Run

```sh
flutter pub get
flutter run
```

## Where things live

- `lib/main.dart` — app entry and theme.
- `lib/pages/profile_card_page.dart` — canvas, background dots, and card placement.
- `lib/widgets/profile_card.dart` — the card, seal, info rows, and barcode.
- `test/widget_test.dart` — smoke tests at a standard and a small phone size.

The NIM, program, year, and validity date are placeholders. Edit the `ProfileCard` arguments in `profile_card_page.dart` to change them.

## Type

Fraunces and Manrope are bundled from Google Fonts under the SIL Open Font License, so the card renders the same offline.
# mobprog
