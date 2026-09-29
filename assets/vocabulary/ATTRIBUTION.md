# Vocabulary source attribution

The `catalog.json` currently in the app is original practice text marked `datasetType: development`. It is not the CEFR-J, Octanove, NGSL, or NAWL lists, and its definitions were written for trying the app. Those licensed sources apply only after the vocabulary pipeline replaces the file with `datasetType: production`.

Lexora does not ship the upstream word lists inside the app binary until a generated `catalog.json` is produced. When that file is published, cite the sources that were actually merged.

## CEFR-J Vocabulary Profile 1.5

- Compiler: Yukio Tono, Tono Laboratory, Tokyo University of Foreign Studies
- Role in Lexora: CEFR levels A1–B2
- Redistribution used by this pipeline: Open Language Profiles `cefrj-vocabulary-profile-1.5.csv`
- Terms stated by Open Language Profiles: research and commercial use with no charge, provided the dataset is cited. Copyright remains with Tono Laboratory at TUFS.
- Source page: http://www.cefr-j.org/download.html
- Profile copy: https://github.com/openlanguageprofiles/olp-en-cefrj

Suggested citation: The CEFR-J Wordlist Version 1.5. Compiled by Yukio Tono, Tokyo University of Foreign Studies.

## Octanove Vocabulary Profile C1/C2 1.0

- Creator: Octanove Labs
- Role in Lexora: CEFR levels C1–C2
- File: `octanove-vocabulary-profile-c1c2-1.0.csv`
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Profile copy: https://github.com/openlanguageprofiles/olp-en-cefrj

## NGSL 1.2

- Creators: Charles Browne, Brent Culligan, and Joseph Phillips
- Role in Lexora: General English membership and frequency rank
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Project: https://www.newgeneralservicelist.com/new-general-service-list

Suggested citation: Browne, C., Culligan, B. & Phillips, J. (2013). The New General Service List. Retrieved from https://www.newgeneralservicelist.com

## NGSL-Spoken 1.2

- Creators: Charles Browne and Brent Culligan
- Role in Lexora: Spoken English membership and frequency rank
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Project: https://www.newgeneralservicelist.com/ngsl-spoken

## NAWL 1.2

- Creators: Charles Browne, Brent Culligan, and Joseph Phillips
- Role in Lexora: academic membership and academic rank
- License: Creative Commons Attribution-ShareAlike 4.0 International
- Project: https://www.newgeneralservicelist.com

## What Lexora adds

CEFR levels are copied only from CEFR-J or Octanove. Frequency and academic flags are copied only from NGSL, NGSL-Spoken, and NAWL. Definitions, Arabic meanings, and examples are left empty unless a later licensed source is added. Inflections are not invented.

Because Octanove, NGSL, NGSL-Spoken, and NAWL use CC BY-SA 4.0, a published `catalog.json` that contains those entries needs the same attribution and ShareAlike terms. This file is the place those notices live. The app UI does not paste the license text.
