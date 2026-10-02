-- 20: 절차 12~19 일본어 단계 설명 보정
-- 기존 단계 행의 일본어 기본 설명만 UPDATE합니다. 삭제·초기화는 하지 않습니다.
-- 출처: 미나토구 편의점 교부, 쓰레기, 임신·출산, 아동수당, 상담·방재 안내 및 출입국재류관리청 안내

-- 12. コンビニ交付サービス
UPDATE JL_STEP SET description=N'発行できる証明書の種類と対象条件を確認します。' WHERE procedure_id=12 AND step_no=1;
UPDATE JL_STEP SET description=N'マイナンバーカードと暗証番号を使ってコンビニで証明書を発行します。' WHERE procedure_id=12 AND step_no=2;

-- 13. ごみの分別・排出・リサイクル
UPDATE JL_STEP SET description=N'可燃ごみ・不燃ごみ・資源など、港区の分別区分を確認します。' WHERE procedure_id=13 AND step_no=1;
UPDATE JL_STEP SET description=N'港区の分別ガイドやごみ分別アプリで地域の収集日を確認します。' WHERE procedure_id=13 AND step_no=2;
UPDATE JL_STEP SET description=N'建物の管理者に排出場所を確認し、決められた日の午前8時までに出します。' WHERE procedure_id=13 AND step_no=3;

-- 14. 妊娠届と母子健康手帳
UPDATE JL_STEP SET description=N'医療機関で妊娠の診断を受けた後、妊娠届を提出します。' WHERE procedure_id=14 AND step_no=1;
UPDATE JL_STEP SET description=N'妊娠届の提出後、母子健康手帳と母と子の保健バッグなどを受け取ります。' WHERE procedure_id=14 AND step_no=2;
UPDATE JL_STEP SET description=N'妊婦健康診査や新生児聴覚検査などの案内を確認します。' WHERE procedure_id=14 AND step_no=3;

-- 15. 出産後の支援と出産育児一時金
UPDATE JL_STEP SET description=N'出産後に利用できる支援制度の対象者と条件を確認します。' WHERE procedure_id=15 AND step_no=1;
UPDATE JL_STEP SET description=N'出生届、出生通知、出産育児一時金など制度ごとの必要書類を確認します。' WHERE procedure_id=15 AND step_no=2;
UPDATE JL_STEP SET description=N'制度ごとの担当窓口または公式の申請方法で手続きをします。' WHERE procedure_id=15 AND step_no=3;

-- 16. 児童手当の申請
UPDATE JL_STEP SET description=N'児童の年齢、養育状況、住所などの支給条件を確認します。' WHERE procedure_id=16 AND step_no=1;
UPDATE JL_STEP SET description=N'出生や転入などの翌日から15日以内を目安に申請時期を確認します。' WHERE procedure_id=16 AND step_no=2;
UPDATE JL_STEP SET description=N'港区の窓口・郵送・マイナポータルなど、該当する方法で申請します。公務員は勤務先に申請します。' WHERE procedure_id=16 AND step_no=3;

-- 17. 在留カード・在留手続の確認
UPDATE JL_STEP SET description=N'在留資格、在留期間、在留カードの有効期間と記載事項を確認します。' WHERE procedure_id=17 AND step_no=1;
UPDATE JL_STEP SET description=N'在留期間更新、在留資格変更、再交付など該当する手続を選びます。' WHERE procedure_id=17 AND step_no=2;
UPDATE JL_STEP SET description=N'手続ごとの申請書、写真、旅券、在留カードなどの必要書類を公式案内で確認します。' WHERE procedure_id=17 AND step_no=3;

-- 18. 外国人相談窓口を利用する
UPDATE JL_STEP SET description=N'相談したい行政・生活上の問題、住所、期限などを整理します。' WHERE procedure_id=18 AND step_no=1;
UPDATE JL_STEP SET description=N'相談窓口ごとの対応言語、相談曜日、受付時間を確認します。' WHERE procedure_id=18 AND step_no=2;
UPDATE JL_STEP SET description=N'電話または窓口で相談します。必要な場合は本人確認書類の要否を事前に確認します。' WHERE procedure_id=18 AND step_no=3;

-- 19. 災害・事故・緊急時の備え
UPDATE JL_STEP SET description=N'港区の防災情報、避難所、避難経路、防災アプリを平常時に確認します。' WHERE procedure_id=19 AND step_no=1;
UPDATE JL_STEP SET description=N'警察、消防・救急、家族、勤務先・学校などの緊急連絡先を確認します。' WHERE procedure_id=19 AND step_no=2;
UPDATE JL_STEP SET description=N'家族と避難場所、連絡方法、非常用持出品を事前に決めておきます。' WHERE procedure_id=19 AND step_no=3;

COMMIT;
