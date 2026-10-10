# Qur'an Dungeon — Text Crawler 🕌⚔

A text-based dungeon-crawler version of the Quran Live Map. Same law, same clock,
same saves — zero graphical load, runs on anything.

## Play
Double-click `index.html` — that's it. Everything is embedded; no internet needed.

## The law of the dungeon
- The real clock is the dungeon master. **Floor = hour of the day**:
  floor 1 holds the chambers of Surahs 1-9 ... floor 12 holds 106-114.
- The **Qur'an Walker ◈** never stops: it finger-walks the 14×14 grid —
  moon letters drag it along a row, sun letters along a column,
  and when a letter does not move the finger, a ✦ marker is stamped.
- **You are the Delver @**. Walk beside it, explore ahead of it
  ( foresight bonus when the Walker later crosses your steps ),
  pin your real world onto the squares, and read the Council's whispers.

## Commands
- `help` — the full delver's handbook
- `n / s / e / w` — walk (arrow keys too)
- `1`–`7` — cast abilities (fatiha, kursi, tadabbur, surge, sajdah, dua, takbir)
- `maze` — enter THE GAUNTLET: beat the hour's maze before the hour dies (`leave` to exit)
- `place <name>` / `person <name> as <relation>` / `forget place|person <n>`
- `note <thought>` / `journal` — pour thoughts out of your head, stamped by surah:ayah
- `spot <word>` — alert when the Walker touches that word
- `quls`, `haram`, `sound`, `stats`, `look`, `places`, `people`, `clear`

## Shared saves
Uses the same localStorage keys as the map app — your XP, blooms, places,
people, journal and app-birth time carry over between both versions.
