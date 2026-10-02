-- 21: 절차 16~19 일본어 단계 제목 보정
-- 기존 단계 행의 기본 제목만 절차 ID와 단계 번호로 UPDATE합니다.
-- 삭제·초기화·신규 단계 삽입은 하지 않습니다.

-- 16. 児童手当の申請
UPDATE JL_STEP SET title=N'対象条件を確認' WHERE procedure_id=16 AND step_no=1;
UPDATE JL_STEP SET title=N'申請時期を確認' WHERE procedure_id=16 AND step_no=2;
UPDATE JL_STEP SET title=N'申請書を提出' WHERE procedure_id=16 AND step_no=3;

-- 17. 在留カード・在留手続の確認
UPDATE JL_STEP SET title=N'在留状況を確認' WHERE procedure_id=17 AND step_no=1;
UPDATE JL_STEP SET title=N'手続の種類を選択' WHERE procedure_id=17 AND step_no=2;
UPDATE JL_STEP SET title=N'出入国在留管理庁の案内を確認' WHERE procedure_id=17 AND step_no=3;

-- 18. 外国人相談窓口を利用する
UPDATE JL_STEP SET title=N'相談内容を整理' WHERE procedure_id=18 AND step_no=1;
UPDATE JL_STEP SET title=N'相談言語と時間を確認' WHERE procedure_id=18 AND step_no=2;
UPDATE JL_STEP SET title=N'電話または窓口で相談' WHERE procedure_id=18 AND step_no=3;

-- 19. 災害・事故・緊急時の備え
UPDATE JL_STEP SET title=N'防災情報を確認' WHERE procedure_id=19 AND step_no=1;
UPDATE JL_STEP SET title=N'緊急連絡先を確認' WHERE procedure_id=19 AND step_no=2;
UPDATE JL_STEP SET title=N'家族と対応方法を共有' WHERE procedure_id=19 AND step_no=3;

COMMIT;
