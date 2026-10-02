-- 24: 절차 11~15 일본어 개요 및 조건부 문구 보정
-- 일본어는 JL_PROCEDURE 및 JL_DOCUMENT 기본 컬럼을 사용합니다.
-- 기존 행만 절차 ID·문서명으로 UPDATE하며 삭제·초기화·신규 삽입은 하지 않습니다.
-- 출처:
--   11 https://www.city.minato.tokyo.jp/kikaku/kaikaku/mainanba/tutikado.html
--   12 https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html
--   13 https://www.city.minato.tokyo.jp/easyjp/life/waste/index.html
--   14 https://www.city.minato.tokyo.jp/chiikihoken/kenko/ninshin/ninshin/ninshin.html
--   15 https://www.city.minato.tokyo.jp/kyufu/20181019.html

-- 11. マイナンバーカードの申請・更新
UPDATE JL_PROCEDURE SET
    summary=N'マイナンバーカードの申請方法と、在留期間に応じたカードの更新を確認する案内です。',
    eligibility=N'マイナンバーカードの申請、受取、更新などの手続が必要な方が対象です。在留期間の更新後は、カードの有効期間更新が必要になる場合があります。',
    deadline_text=N'申請・受取の時期と、カードの有効期間更新が必要な時期を公式案内で確認します。',
    method_text=N'郵送、スマートフォン・パソコン、対応する証明写真機など、公式案内に示された方法で申請します。',
    notice=N'申請方法、交付、在留期間更新に伴うカードの更新条件は、港区の最新の公式案内で確認してください。'
WHERE id=11;

-- 12. コンビニ交付サービス
UPDATE JL_PROCEDURE SET
    summary=N'マイナンバーカードを使って、コンビニエンスストアで証明書を発行する方法の案内です。',
    eligibility=N'港区に住民登録があり、対象となる証明書を取得できる方が利用できます。発行できる証明書と条件は証明書の種類によって異なります。',
    deadline_text=N'利用できる時間と発行できる証明書の種類を公式案内で確認します。',
    method_text=N'暗証番号を登録したマイナンバーカードを使い、対応するコンビニエンスストアの端末で発行します。',
    notice=N'住民票の写し、印鑑登録証明書、課税・納税証明書などの発行対象と利用時間は、港区の最新の公式案内で確認してください。'
WHERE id=12;

-- 13. ごみの分別・排出・リサイクル
UPDATE JL_PROCEDURE SET
    summary=N'港区のごみの分別、排出方法、収集日、リサイクルについて確認する案内です。',
    eligibility=N'港区で生活し、ごみを出す方が対象です。建物や地域によって排出場所と収集曜日が異なるため、管理者と公式案内を確認します。',
    deadline_text=N'ごみの種類と地域ごとの収集日を確認し、決められた日の午前8時までに出します。',
    method_text=N'ごみを種類ごとに分別し、決められた排出場所と時間に出します。',
    notice=N'分別方法、収集曜日、排出場所は、港区の公式案内と建物の管理者に確認してください。'
WHERE id=13;

-- 14. 妊娠届と母子健康手帳
UPDATE JL_PROCEDURE SET
    summary=N'妊娠届を提出し、母子健康手帳や妊婦健康診査などの案内を確認するための手続です。',
    eligibility=N'港区に住み、妊娠したことが分かった方が対象です。妊婦健康診査の受診方法や支援内容は公式案内で確認します。',
    deadline_text=N'妊娠したことが分かったら、必要事項を確認して妊娠届を提出します。',
    method_text=N'各総合支所の窓口で妊娠届を提出し、母子健康手帳や妊婦健康診査の案内を受け取ります。',
    notice=N'妊娠届の提出先、受付時間、外国語対応、健診票の利用条件は、港区の最新の公式案内で確認してください。'
WHERE id=14;

-- 15. 出産後の支援と出産育児一時金
UPDATE JL_PROCEDURE SET
    summary=N'出産後に利用できる支援制度と、出産育児一時金の手続を確認する案内です。',
    eligibility=N'出産した方と子どもが、港区の制度や加入している公的医療保険の条件に該当する場合が対象です。支援制度ごとに対象条件が異なります。',
    deadline_text=N'制度ごとの申請期間と対象条件を、各制度の公式案内で確認します。',
    method_text=N'担当窓口で必要書類と申請方法を確認し、該当する制度の手続を行います。',
    notice=N'支援対象、支給条件、申請先は、家族の住所、保険の種類、子どもの登録状況などにより異なるため、最新の公式案内を確認してください。'
WHERE id=15;

-- 12. 条件付き書類
UPDATE JL_DOCUMENT SET condition_text=N'電子証明書などを利用する場合に必要です。'
WHERE procedure_id=12 AND name=N'暗証番号' AND requirement='REQUIRED';

-- 15. 条件付き書類
UPDATE JL_DOCUMENT SET condition_text=N'制度により必要な書類が異なります。'
WHERE procedure_id=15 AND name=N'出生に関する届出・証明書' AND requirement='CONDITIONAL';

UPDATE JL_DOCUMENT SET condition_text=N'出産育児一時金の申請時に確認される場合があります。'
WHERE procedure_id=15 AND name=N'健康保険の資格情報' AND requirement='CONDITIONAL';

COMMIT;
