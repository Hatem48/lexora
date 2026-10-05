# Vocabulary source attribution

Retrieved on 1 October 2026. `assets/vocabulary/catalog.json` is the production catalog (`datasetType: production`, version 4). Lemma, part of speech, CEFR, ranks, and evidence tags come only from the sources below. English definitions, Arabic meanings, example sentences, inflections, and high-confidence topic links were added in Lexora for in-app learning; they are not copied from CEFR-J, Octanove, NGSL, NGSL-Spoken, or NAWL. The previous practice catalog is kept at `data/vocabulary/catalog.development.json` and is not loaded by the app.

CEFR levels come only from CEFR-J (A1–B2) and Octanove (C1–C2). When those sources disagree, or when one source lists two levels for the same lemma and part of speech, the entry is left out of the catalog and recorded in `build/vocabulary/conflicts.json`. NGSL, NGSL-Spoken, and NAWL add rank and the tags general, spoken, and academic. They do not set CEFR level.

## CEFR-J Vocabulary Profile 1.5

- Dataset: CEFR-J Vocabulary Profile 1.5
- Compiler: Yukio Tono, Tono Laboratory, Tokyo University of Foreign Studies
- Role in Lexora: lemma, part of speech, and CEFR for A1–B2
- File used: `data/vocabulary/raw/cefrj-vocabulary-profile-1.5.csv`
- Retrieved from: https://github.com/openlanguageprofiles/olp-en-cefrj/blob/master/cefrj-vocabulary-profile-1.5.csv
- Terms stated by Open Language Profiles: the CEFR-J vocabulary and grammar profiles may be used for research and commercial purposes at no charge, provided the dataset is cited. Copyright remains with Tono Laboratory at TUFS.
- Official project page: http://www.cefr-j.org/download.html
- Retrieved: 1 October 2026

Suggested citation: The CEFR-J Wordlist Version 1.5. Compiled by Yukio Tono, Tokyo University of Foreign Studies.

## Octanove Vocabulary Profile C1/C2 1.0

- Dataset: Octanove Vocabulary Profile C1/C2
- Version: 1.0
- Creator: Octanove Labs
- Role in Lexora: lemma, part of speech, and CEFR for C1–C2
- File used: `data/vocabulary/raw/octanove-vocabulary-profile-c1c2-1.0.csv`
- Retrieved from: https://github.com/openlanguageprofiles/olp-en-cefrj/blob/master/octanove-vocabulary-profile-c1c2-1.0.csv
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Retrieved: 1 October 2026

## NGSL 1.2

- Dataset: New General Service List
- Version: 1.2 stats
- Creators: Charles Browne, Brent Culligan, and Joseph Phillips
- Role in Lexora: general-English tag and general frequency rank. No CEFR change.
- File used: `data/vocabulary/raw/ngsl-1.2.csv`
- Retrieved from: https://www.newgeneralservicelist.com/s/NGSL_12_stats.csv
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Project: https://www.newgeneralservicelist.com/new-general-service-list
- Retrieved: 1 October 2026

Suggested citation: Browne, C., Culligan, B. & Phillips, J. (2013). The New General Service List. Retrieved from https://www.newgeneralservicelist.com

## NGSL-Spoken 1.2

- Dataset: NGSL-Spoken
- Version: 1.2 stats
- Creators: Charles Browne and Brent Culligan
- Role in Lexora: spoken tag and spoken frequency rank. No CEFR change.
- File used: `data/vocabulary/raw/ngsl-spoken-1.2.csv`
- Retrieved from: https://www.newgeneralservicelist.com/s/NGSL-Spoken_12_stats.csv
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Project: https://www.newgeneralservicelist.com/ngsl-spoken
- Retrieved: 1 October 2026
- The published stats row for `TRUE` has rank `#N/A`. That row is rejected and is not given a spoken rank.

## NAWL 1.2

- Dataset: New Academic Word List
- Version: 1.2 stats
- Creators: Charles Browne, Brent Culligan, and Joseph Phillips
- Role in Lexora: academic tag and academic rank. No CEFR change.
- File used: `data/vocabulary/raw/nawl-1.2.csv`
- Retrieved from: https://www.newgeneralservicelist.com/s/NAWL_12_stats.csv
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Project: https://www.newgeneralservicelist.com
- Retrieved: 1 October 2026

## What Lexora adds

Lemma, POS, and CEFR are never invented from these source files. A headword whose part of speech is not a real category in these files is rejected instead of assigned a guessed category. The rejected rows are `to` marked `infinitive-to` in CEFR-J, `batter` with an empty part of speech in Octanove, and `remonstrate` marked `vern` in Octanove. `to` remains in the catalog as a preposition because that separate CEFR-J row is valid.

English definitions, Arabic meanings, example sentences, and inflection lists in version 4 are Lexora learning content. They are not taken from the datasets above. High-confidence topic links in `topics.json` were added the same way.

Because Octanove, NGSL, NGSL-Spoken, and NAWL use CC BY-SA 4.0, a published catalog that contains those entries needs this attribution and the ShareAlike terms. The app UI does not paste the license text.
