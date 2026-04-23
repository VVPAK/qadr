# Qadr — Roadmap

## In Progress

### Quran Reader
- [x] Data pipeline (tanzil.net via alquran.cloud API)
- [x] Surah list screen
- [x] Ayah reader screen (Arabic + translation)
- [x] Discuss ayah in chat (QuranAyahCard + LLM)
- [ ] Bookmarks / last reading position
- [ ] Search by text across all surahs
- [ ] Audio recitation

## Planned

### Verified Source Search for Ayah Context
Instead of LLM generating explanations of Quran ayahs on its own, implement web search across trusted Islamic sources with citations.

**Why:** LLM not qualified to do tafsir. Users need reliable, sourced information from recognized scholars.

**Approach:**
- Integrate web search API (Google Custom Search / Tavily / similar)
- Whitelist trusted domains: quran.com, islamqa.info, sunnah.com, islamweb.net, tafsir.app
- LLM summarizes search results and provides links to original sources
- Never present LLM's own interpretation as tafsir
- UI: render clickable source links in chat messages

**Depends on:** web search API integration, new chat message component for citations

### Dua Collection
- [ ] Populate dua database with seed data
- [ ] Dua list screen (categories, search)
- [ ] Dua of the day

### Learning
- [ ] Expand lesson curriculum
- [ ] Quiz / knowledge check

### General
- [ ] Offline LLM fallback
- [ ] Prayer time notifications
- [ ] Widget (iOS / Android)
