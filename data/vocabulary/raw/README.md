# ملفات المفردات الخام

ضع الملفات هنا قبل تشغيل خط الأنابيب. لا تُرفع هذه الملفات إلى Git إذا لم تقرر ذلك.

الملفات المطلوبة، بهذه الأسماء:

- `cefrj-vocabulary-profile-1.5.csv`
- `octanove-vocabulary-profile-c1c2-1.0.csv`
- `ngsl-1.2.csv`
- `ngsl-spoken-1.2.csv`
- `nawl-1.2.csv`

ملفات اختيارية، لاحقاً:

- `vocabulary-forms.csv` بالأعمدة `lemma,pos,form`
- `vocabulary-topic-mappings.json` بالشكل `{"mappings":[{"lemma","pos","topicId","relevance"}]}`

أعمدة CEFR-J وOctanove المتوقعة: `headword`, `pos`, `CEFR`.

أعمدة NGSL وNGSL-Spoken وNAWL المتوقعة: عمود lemma باسم `Lemma` أو `Word` أو `headword`، وعمود رتبة باسم `Rank`. عمود `PoS` اختياري. إذا غاب عمود الجزء الكلامي وطابقت الكلمة أكثر من مدخل، لا تُنسَب الرتبة.

التفاصيل وأمر التوليد في `tools/vocabulary_pipeline/README.md`.
