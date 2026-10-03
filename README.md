# 2048 for Garmin Venu 4

A simple version of the 2048 puzzle game for the Garmin Venu 4, built with Connect IQ and Monkey C.

Currently created for use with Venu 4 devices and Garmin 3.1 api, though in future may expand to more compatible devices/api versions.

## Project structure

| File | Purpose |
| --- | --- |
| `source/Game2048.mc` | Game logic: board, sliding, merging, scoring, save/load |
| `source/Garmin_2048App.mc` | Draws the board, tiles, and score |
| `source/Garmin_2048Delegate.mc` | Handles taps and restarts after game over |
| `source/Garmin_2048View.mc` | App entry point, loads and saves game state |
| `manifest.xml` | App type, target devices, API level |

## Requirements

- [Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/)
- Visual Studio Code with the Garmin Monkey C extension
- Java (JDK 17 or newer)
- A Connect IQ developer key

## License

Personal project. 2048 game copied from original by Gabriele Cirulli.
