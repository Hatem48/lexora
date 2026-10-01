# Lexora vocabulary pipeline

هذه الأداة تبني `assets/vocabulary/catalog.json` من ملفات المصادر. التطبيق لا يقرأ CSV عند التشغيل.

## أمر التوليد

من جذر المشروع:

```
dart run --directory=tools/vocabulary_pipeline bin/generate.dart
```

إذا نقص ملف مطلوب، يتوقف الأمر ولا يغيّر `catalog.json`.

الملف الحالي في التطبيق مجموعة تطوير (`datasetType: development`) لتجربة الواجهة، وليست ناتج هذا الأمر. عند نجاح التوليد يُستبدل الملف ويُكتب `datasetType: production`. التطبيق يحفظ هوية الاستيراد بصيغة `version:datasetType`، لذلك لا تمنع بيانات التطوير استيراد الكتالوج المنتج.

## المدخلات

توضع في `data/vocabulary/raw/` بهذه الأسماء:

| الملف | المصدر |
|---|---|
| `cefrj-vocabulary-profile-1.5.csv` | CEFR-J Vocabulary Profile 1.5 |
| `octanove-vocabulary-profile-c1c2-1.0.csv` | Octanove Vocabulary Profile C1/C2 1.0 |
| `ngsl-1.2.csv` | NGSL 1.2 with frequency rank |
| `ngsl-spoken-1.2.csv` | NGSL-Spoken 1.2 with frequency rank |
| `nawl-1.2.csv` | NAWL 1.2 with rank |

اختياري:

- `vocabulary-forms.csv` أعمدة `lemma,pos,form`. لا تُولَّد التصريفات تلقائياً.
- `vocabulary-topic-mappings.json` لربط لاحق بالمواضيع. `topics.json` الحالي لا يُستبدل.

## سياسة CEFR

1. المستوى يُقبل فقط من CEFR-J أو Octanove.
2. إذا قدّم مصدر واحد مستوى صالحاً واحداً، يُستخدم ذلك المستوى. إذا سرد المصدر نفسه مستويين، يُستبعد المدخل وتُكتب المستويات معاً في `conflicts.json`.
3. إذا قدّم المصدران المستوى نفسه، يُستخدم ويُسجَّل الاثنان في `sources.cefr`.
4. إذا اختلفا، لا يُختار مستوى. المدخل يُستبعد من الكتالوج ويُكتب في `build/vocabulary/conflicts.json`.
5. NGSL وNGSL-Spoken وNAWL لا تغيّر CEFR. كلمة بلا مستوى من المصدرين الأولين لا تدخل الكتالوج.
6. المفتاح هو `lemma + partOfSpeech`. `record` اسماً و`record` فعلاً مدخلان.
7. رتبة بلا جزء كلام تُربَط فقط إذا كان للكلمة مدخل واحد. وإلا تُتخطى وتُحسب في `ambiguousRanksSkipped`.
8. إذا اشترك اسم وفعل في نفس الكتابة، لا تُسنَد هذه الكتابة إلى أحدهما داخل `vocabulary_forms` حتى يحددها ملف التصريفات.

## المخرجات

- `assets/vocabulary/catalog.json`
- `build/vocabulary/summary.json`
- `build/vocabulary/statistics.json`
- `build/vocabulary/conflicts.json`
- `build/vocabulary/rejected.json` للصفوف المرفوضة، مثل رتبة `#N/A` أو جزء كلام غير معروف
- `build/vocabulary/topic_links.json` فارغ إلى أن يوجد ملف الربط

معرّف مكرر يوقف الكتابة. صف مرفوض لا يوقف بقية الكتالوج.

الأوزان في `config/priority_weights.json`. الحقول بلا مصدر تبقى فارغة أو `false` أو `null`.

الإسناد في `assets/vocabulary/ATTRIBUTION.md`.
