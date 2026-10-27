-- 02: 공식 자료 기반 초기 안내. 가상 행정 요건이 아닙니다.
-- 01을 완료한 빈 프로젝트 테이블에 최초 한 번 실행하세요.
-- 확인일 2026-09-28. 출처별 한계와 검증 범위는 docs/sources.md 참고.
-- 기존 데이터 수정·삭제는 하지 않습니다. 중복 오류 발생 시 계속 실행하지 마세요.

INSERT INTO JL_REGION (id,parent_id,name) VALUES (1,NULL,N'東京都');
INSERT INTO JL_REGION (id,parent_id,name) VALUES (2,1,N'港区');
INSERT INTO JL_CATEGORY (id,name) VALUES (1,N'引っ越し・住民登録');

INSERT INTO JL_PROCEDURE
(id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision)
VALUES (1,2,1,N'海外から港区へ引っ越す',N'日本での暮らしを始める方へ。転入届の準備を確認します。',
N'海外から港区に住居を移す外国人住民。会社の所在地ではなく、実際に住む場所で判断します。',
N'港区で暮らし始めてから14日以内。入居前の届出はできません。',
N'総合支所の窓口サービス係、または台場分室の窓口で届出。',
N'本人による届出の基本案内です。代理人・在留カード後日交付などの個別条件は公式案内で確認してください。国外からの転入は、受付時間の注意事項も確認してください。',
'ABROAD','AFTER_ARRIVAL','Y',1);

INSERT INTO JL_PROCEDURE
(id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision)
VALUES (2,2,1,N'日本のほかの市区町村から港区へ引っ越す',N'日本国内で住所が変わる方へ。転出方法に応じて書類を確認します。',
N'日本のほかの市区町村から港区に住居を移す外国人住民。港区内の引っ越しは別の手続きです。',
N'港区で暮らし始めてから14日以内。カードを利用した転出では、転出予定日からの期限にも注意してください。',
N'総合支所の窓口サービス係、または台場分室の窓口で届出。',
N'本人による届出の基本案内です。カードを利用して転出した方は実物のカードが必要です。代理人・期限超過などは公式案内を確認してください。',
'DOMESTIC','AFTER_ARRIVAL','Y',1);

INSERT INTO JL_DOCUMENT VALUES (1,1,N'パスポート','REQUIRED',N'転入する方全員分。',1);
INSERT INTO JL_DOCUMENT VALUES (2,1,N'在留カードなど','REQUIRED',N'全員分。在留カード・特別永住者証明書等、該当する証明書。後日交付の場合は公式案内を確認。',2);
INSERT INTO JL_DOCUMENT VALUES (3,1,N'入国日が確認できる資料','CONDITIONAL',N'パスポートで入国日を確認できない場合。搭乗券や荷物タグなど。',3);
INSERT INTO JL_DOCUMENT VALUES (4,1,N'家族関係の証明と翻訳','CONDITIONAL',N'家族など2人以上で転入する場合。本国発行の原本と日本語訳。',4);
INSERT INTO JL_DOCUMENT VALUES (5,1,N'マイナンバーカード','CONDITIONAL',N'持っている方の分。必要な暗証番号等は公式案内で確認。',5);
INSERT INTO JL_DOCUMENT VALUES (6,1,N'年金手帳','CONDITIONAL',N'公式案内では国民年金に加入する方が対象。個別の加入条件は別途確認。',6);
INSERT INTO JL_DOCUMENT VALUES (7,2,N'窓口に来る方の本人確認書類','REQUIRED',N'使用できる書類は公式案内で確認。',1);
INSERT INTO JL_DOCUMENT VALUES (8,2,N'在留カードなど','REQUIRED',N'転入する外国人住民全員分の該当する証明書。',2);
INSERT INTO JL_DOCUMENT VALUES (9,2,N'転出証明書','CONDITIONAL',N'マイナンバーカードを利用した転出では省略できます。それ以外は前の自治体の証明書を準備。',3);
INSERT INTO JL_DOCUMENT VALUES (10,2,N'マイナンバーカード','CONDITIONAL',N'持っている方全員分。カードを利用した転出では提示が必要です。',4);

INSERT INTO JL_DOCUMENT_GUIDE VALUES (1,'ja',N'本人確認や入国日を確認するための旅券です。',N'転入する方全員分を用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (2,'ja',N'在留カード・特別永住者証明書など、該当する在留関係の証明書です。',N'転入する外国人住民全員分を用意します。後日交付の場合は公式案内を確認してください。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (3,'ja',N'パスポートで入国日を確認できない場合に補う資料です。',N'搭乗券や荷物タグなど、入国日を確認できる資料を用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (4,'ja',N'家族関係を確認するための本国発行原本と日本語訳です。',N'家族など2人以上で転入する場合に用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (5,'ja',N'マイナンバーを確認するためのカードです。',N'持っている方の分を用意します。必要な暗証番号などは公式案内で確認してください。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (6,'ja',N'国民年金の加入手続きで確認する場合がある手帳です。',N'国民年金に加入する方が対象です。個別の加入条件は別途確認してください。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (7,'ja',N'窓口で手続きをする方の本人確認に使う書類です。',N'使用できる書類は公式案内で確認してください。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (8,'ja',N'転入する外国人住民の在留関係を確認する証明書です。',N'転入する外国人住民全員分を用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (9,'ja',N'前の市区町村から転出したことを示す証明書です。',N'マイナンバーカードを利用した転出で省略できる場合があります。それ以外は前の自治体の証明書を用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (10,'ja',N'マイナンバーを確認するためのカードです。',N'持っている方全員分を用意します。カードを利用した転出では提示が必要です。');

INSERT INTO JL_DOCUMENT_GUIDE VALUES (1,'ko',N'본인 확인과 입국일 확인에 사용하는 여권입니다.',N'전입하는 사람 전원의 여권을 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (2,'ko',N'재류카드·특별영주자증명서 등 해당하는 재류 관련 증명서입니다.',N'전입하는 외국인 주민 전원의 서류를 준비합니다. 후일 교부인 경우 공식 안내를 확인해 주세요.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (3,'ko',N'여권으로 입국일을 확인할 수 없을 때 보완하는 자료입니다.',N'탑승권이나 수하물 태그 등 입국일을 확인할 수 있는 자료를 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (4,'ko',N'가족관계를 확인하기 위한 본국 발행 원본과 일본어 번역문입니다.',N'가족 등 2명 이상이 전입하는 경우 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (5,'ko',N'마이넘버를 확인하기 위한 카드입니다.',N'카드를 가지고 있는 사람의 카드를 준비합니다. 필요한 비밀번호 등은 공식 안내를 확인해 주세요.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (6,'ko',N'국민연금 가입 절차에서 확인할 수 있는 수첩입니다.',N'국민연금 가입 대상자에게 해당합니다. 개인별 가입 조건은 별도로 확인해 주세요.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (7,'ko',N'창구에서 절차를 진행하는 사람의 본인 확인에 사용하는 서류입니다.',N'사용할 수 있는 서류는 공식 안내를 확인해 주세요.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (8,'ko',N'전입하는 외국인 주민의 재류 관련 사항을 확인하는 증명서입니다.',N'전입하는 외국인 주민 전원의 서류를 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (9,'ko',N'이전 시구정촌에서 전출했다는 것을 보여주는 증명서입니다.',N'마이넘버카드를 이용한 전출은 생략할 수 있는 경우가 있습니다. 그 외에는 이전 지자체의 증명서를 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (10,'ko',N'마이넘버를 확인하기 위한 카드입니다.',N'카드를 가진 사람 전원의 카드를 준비합니다. 카드를 이용한 전출에서는 제시가 필요합니다.');

INSERT INTO JL_DOCUMENT_GUIDE VALUES (1,'en',N'A passport used to confirm identity and the date of entry.',N'Prepare one for everyone moving in.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (2,'en',N'An applicable residence-related certificate, such as a residence card or special permanent resident certificate.',N'Prepare one for every foreign resident moving in. Check the official guidance if it will be issued later.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (3,'en',N'Supporting material used when the entry date cannot be confirmed from the passport.',N'Prepare a boarding pass, baggage tag, or similar material showing the entry date.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (4,'en',N'The original document issued in your home country and a Japanese translation used to confirm family relationships.',N'Prepare these when two or more family members move in.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (5,'en',N'A card used to confirm your My Number.',N'Prepare it for people who have one. Check the official guidance for required PINs and other details.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (6,'en',N'A handbook that may be checked during National Pension enrollment procedures.',N'This applies to people who are joining the National Pension. Check individual eligibility separately.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (7,'en',N'Identification used to confirm the person visiting the service counter.',N'Check the official guidance for acceptable documents.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (8,'en',N'A certificate used to confirm the residence status of foreign residents moving in.',N'Prepare one for every foreign resident moving in.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (9,'en',N'A certificate showing that you moved out of your previous municipality.',N'It may be omitted when you used a My Number Card to move out. Otherwise prepare the certificate from the previous municipality.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (10,'en',N'A card used to confirm your My Number.',N'Prepare it for everyone who has one. It must be presented when you used it to move out.');


INSERT INTO JL_STEP VALUES (1,1,1,N'自分の条件を確認',N'本人・家族・入国日の確認方法に応じて、公式案内を読みます。');
INSERT INTO JL_STEP VALUES (2,1,2,N'書類と窓口を確認',N'該当する書類を用意し、受付時間を確認します。');
INSERT INTO JL_STEP VALUES (3,1,3,N'窓口で転入届を提出',N'入居後、期限内に窓口へ。届出用紙は窓口でも受け取れます。');
INSERT INTO JL_STEP VALUES (4,2,1,N'転出方法を確認',N'前の自治体での転出方法に応じて、証明書またはカードを準備します。');
INSERT INTO JL_STEP VALUES (5,2,2,N'本人確認書類などを準備',N'必要な書類と、持っている方のカードを確認します。');
INSERT INTO JL_STEP VALUES (6,2,3,N'窓口で転入届を提出',N'港区で暮らし始めた後、期限内に窓口で手続きをします。');

INSERT INTO JL_SOURCE VALUES (1,1,N'港区：転入届（公式の詳しい案内）',
'https://www.city.minato.tokyo.jp/shibamadosa/kurashi/todokede/hikkoshi/tennyu.html',DATE '2026-09-28',DATE '2026-07-02');
INSERT INTO JL_SOURCE VALUES (2,2,N'港区：転入届（公式の詳しい案内）',
'https://www.city.minato.tokyo.jp/shibamadosa/kurashi/todokede/hikkoshi/tennyu.html',DATE '2026-09-28',DATE '2026-07-02');
INSERT INTO JL_SOURCE VALUES (3,1,N'港区生活ガイド：引っ越し（やさしい日本語）',
'https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/moving.html',DATE '2026-09-28',DATE '2020-10-01');
INSERT INTO JL_SOURCE VALUES (4,2,N'港区生活ガイド：引っ越し（やさしい日本語）',
'https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/moving.html',DATE '2026-09-28',DATE '2020-10-01');

-- 개별 지소 주소를 확인하기 전에는 주소·좌표를 만들어 넣지 않습니다.
INSERT INTO JL_OFFICE VALUES (1,N'各総合支所の窓口サービス係・台場分室',NULL,
'https://www.city.minato.tokyo.jp/shibamadosa/kurashi/todokede/hikkoshi/tennyu.html',
N'訪問する窓口の住所と受付時間は、公式案内から確認してください。');
INSERT INTO JL_PROC_OFFICE VALUES (1,1);
INSERT INTO JL_PROC_OFFICE VALUES (2,1);
COMMIT;
