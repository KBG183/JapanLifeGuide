-- 23: 절차 16~18 조건부 서류의 일본어 조건 문구 보정
-- 일본어는 JL_DOCUMENT 기본 condition_text를 사용하므로 해당 값만 UPDATE합니다.
-- 조건부 문서의 기존 행을 절차 ID와 일본어 문서명으로 지정합니다.

-- 16. 児童手当の申請
UPDATE JL_DOCUMENT SET condition_text=N'申請方法や申請者・児童の状況により必要です。'
WHERE procedure_id=16 AND name=N'申請者の確認書類' AND requirement='CONDITIONAL';

-- 17. 在留カード・在留手続の確認
UPDATE JL_DOCUMENT SET condition_text=N'申請する在留手続や個人の状況により必要な書類が異なります。'
WHERE procedure_id=17 AND name=N'申請内容に応じた書類' AND requirement='CONDITIONAL';

-- 18. 外国人相談窓口を利用する
UPDATE JL_DOCUMENT SET condition_text=N'相談機関や相談内容により必要になる場合があります。'
WHERE procedure_id=18 AND name=N'本人確認書類' AND requirement='CONDITIONAL';

COMMIT;
