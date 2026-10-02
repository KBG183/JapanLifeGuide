-- H2 preview seed for the life-procedure expansion.
-- Oracle data was added separately with the approved SQL.

INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(9,2,1,N'港区内で引っ越すときの転居届',N'港区内で住所を変更したときの届出です。',N'港区内で新しい住所に引っ越した人。',N'引っ越した日から14日以内。',N'各総合支所の窓口で届出。',N'必要書類は公式案内を確認してください。','DOMESTIC','MOVING_OR_UPDATE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(10,2,1,N'港区から引っ越すときの転出届',N'港区外へ引っ越すときの届出です。',N'港区外へ引っ越す人。',N'方法により届出期間が異なります。',N'マイナポータル、窓口、郵送で届出。',N'国内転出と国外転出の条件を公式案内で確認してください。','DOMESTIC','MOVING_OR_UPDATE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(11,2,1,N'マイナンバーカードの申請・更新',N'マイナンバーカードの申請と更新を確認します。',N'住民登録をしている人など。',N'カードの有効期間と更新時期を確認。',N'郵便、スマートフォン・パソコン、証明用写真機で申請。',N'在留期間の更新後はカードの更新が必要になる場合があります。','DOMESTIC','MOVING_OR_UPDATE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(12,2,1,N'コンビニ交付サービス',N'マイナンバーカードで証明書を取得する方法です。',N'条件を満たす港区の住民。',N'利用時間と対象証明書を確認。',N'暗証番号を登録したカードでコンビニで発行。',N'発行できる証明書と手数料は公式案内を確認してください。','DOMESTIC','DAILY_LIFE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(13,2,1,N'ごみの分別・排出・リサイクル',N'ごみの分け方と出し方を確認します。',N'港区でごみを出す人。',N'地域の収集日を確認。',N'種類ごとに分別して指定場所へ排出。',N'排出場所は建物の管理者にも確認してください。','DOMESTIC','DAILY_LIFE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(14,2,1,N'妊娠届と母子健康手帳',N'妊娠届と母子健康手帳を確認します。',N'港区に住み妊娠が分かった人。',N'妊娠が分かったら届出。',N'各総合支所で届出。',N'健診票などの条件は公式案内を確認してください。','DOMESTIC','DAILY_LIFE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(15,2,1,N'出産後の支援と出産育児一時金',N'出産後の支援制度を確認します。',N'出産後の支援対象者。',N'制度ごとの申請期間を確認。',N'担当窓口へ必要書類を確認して申請。',N'住民登録と保険の条件を制度ごとに確認してください。','DOMESTIC','DAILY_LIFE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(16,2,1,N'児童手当の申請',N'出生や転入後の児童手当を確認します。',N'子どもを養育する保護者。',N'出生・転入後の申請時期を確認。',N'公式案内に従って申請。',N'子どもと保護者の条件を確認してください。','DOMESTIC','DAILY_LIFE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(17,2,1,N'在留カード・在留手続の確認',N'在留カードと在留手続を公式案内で確認します。',N'日本に滞在する外国人。',N'在留期間とカード有効期間を確認。',N'出入国在留管理庁の手続を確認。',N'許可の判断は出入国在留管理庁が行います。','ABROAD','WORK_OR_SCHOOL','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(18,2,1,N'外国人相談窓口を利用する',N'外国人向け相談窓口と多言語相談を確認します。',N'生活や行政について相談したい外国人。',N'相談日と時間を確認。',N'電話または窓口で相談。',N'言語と受付時間は機関ごとに異なります。','DOMESTIC','DAILY_LIFE','Y',1);
INSERT INTO JL_PROCEDURE (id,region_id,category_id,title,summary,eligibility,deadline_text,method_text,notice,situation,phase_code,published,revision) VALUES
(19,2,1,N'災害・事故・緊急時の備え',N'災害や事故などの緊急時に備えます。',N'港区に住む人や滞在する人。',N'平常時に連絡先と避難情報を確認。',N'公式の防災・緊急案内を確認。',N'緊急時は関係機関の公式案内を優先してください。','DOMESTIC','DAILY_LIFE','Y',1);

INSERT INTO JL_PROCEDURE_I18N VALUES (9,'ko',N'미나토구 안에서 이사할 때 전거 신고',N'미나토구 안에서 주소를 변경할 때 하는 신고입니다.',N'미나토구 안에서 새 주소로 이사한 사람.',N'이사한 날부터 14일 이내.',N'각 종합지소 창구에서 신고합니다.',N'필요 서류는 공식 안내를 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (9,'en',N'Change of Address within Minato City',N'An address change notification for moving within Minato City.',N'People moving to a new address within Minato City.',N'Within 14 days after moving.',N'File at a Regional City Office counter.',N'Check the official guidance for required documents.');
INSERT INTO JL_PROCEDURE_I18N VALUES (10,'ko',N'미나토구 밖으로 이사할 때 전출 신고',N'미나토구 밖으로 이사할 때 하는 신고입니다.',N'미나토구 밖으로 이사하는 사람.',N'방법에 따라 신고 기간이 다릅니다.',N'마이넘버 포털·창구·우편으로 신고합니다.',N'국내·해외 전출 조건을 공식 안내에서 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (10,'en',N'Moving Out of Minato City',N'A moving-out notification for people leaving Minato City.',N'People moving outside Minato City.',N'Timing depends on the filing method.',N'File online, at a counter, or by mail.',N'Check the official requirements for domestic or overseas moves.');
INSERT INTO JL_PROCEDURE_I18N VALUES (11,'ko',N'마이넘버 카드 신청·갱신',N'마이넘버 카드 신청과 갱신을 확인합니다.',N'주민등록을 한 사람 등.',N'카드 유효기간과 갱신 시기를 확인합니다.',N'우편·스마트폰·PC·증명사진 기기로 신청합니다.',N'재류기간 연장 후 카드 갱신이 필요할 수 있습니다.');
INSERT INTO JL_PROCEDURE_I18N VALUES (11,'en',N'Apply for or Renew a My Number Card',N'Check how to apply for or renew a My Number Card.',N'Registered residents and other eligible people.',N'Check the card validity and renewal timing.',N'Apply by mail, smartphone, computer, or photo booth.',N'Renewal may be needed after extending your period of stay.');
INSERT INTO JL_PROCEDURE_I18N VALUES (12,'ko',N'편의점 증명서 발급',N'마이넘버 카드로 증명서를 발급받는 방법입니다.',N'조건을 충족하는 미나토구 주민.',N'이용시간과 대상 증명서를 확인합니다.',N'비밀번호를 등록한 카드로 발급합니다.',N'증명서 종류와 수수료는 공식 안내를 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (12,'en',N'Obtaining Certificates at Convenience Stores',N'How to obtain certificates using a My Number Card.',N'Eligible residents of Minato City.',N'Check the available hours and certificates.',N'Use a card with a registered PIN.',N'Check the official guidance for certificate types and fees.');
INSERT INTO JL_PROCEDURE_I18N VALUES (13,'ko',N'쓰레기 분리·배출·재활용',N'쓰레기 분리와 배출 방법을 확인합니다.',N'미나토구에서 쓰레기를 배출하는 사람.',N'지역 수거일을 확인합니다.',N'종류별로 분리해 지정 장소에 배출합니다.',N'배출 장소는 건물 관리자에게도 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (13,'en',N'Waste Sorting, Collection, and Recycling',N'Check how to sort and dispose of waste.',N'People disposing of waste in Minato City.',N'Check the collection day for your area.',N'Sort waste and put it in the designated place.',N'Ask the building manager about the collection place.');
INSERT INTO JL_PROCEDURE_I18N VALUES (14,'ko',N'임신 신고와 모자건강수첩',N'임신 신고와 모자건강수첩을 확인합니다.',N'미나토구에 거주하며 임신 사실을 알게 된 사람.',N'임신 사실을 알게 되면 신고합니다.',N'각 종합지소에서 신고합니다.',N'건강검진 관련 조건은 공식 안내를 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (14,'en',N'Pregnancy Notification and Maternal and Child Health Handbook',N'Check pregnancy notification and the handbook.',N'People living in Minato City who learn they are pregnant.',N'File a notification after learning about the pregnancy.',N'File at a Regional City Office.',N'Check the official guidance for checkup conditions.');
INSERT INTO JL_PROCEDURE_I18N VALUES (15,'ko',N'출산 후 지원과 출산육아일시금',N'출산 후 지원 제도를 확인합니다.',N'출산 후 지원 대상자.',N'제도별 신청기간을 확인합니다.',N'담당 창구에 신청합니다.',N'거주지와 보험 조건을 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (15,'en',N'Postpartum Support and Childbirth Benefit',N'Check support programs after childbirth.',N'People eligible for postpartum support.',N'Check the application period for each program.',N'Apply through the responsible office.',N'Check residence and insurance requirements.');
INSERT INTO JL_PROCEDURE_I18N VALUES (16,'ko',N'아동수당 신청',N'출생이나 전입 후 아동수당을 확인합니다.',N'자녀를 양육하는 보호자.',N'출생·전입 후 신청시기를 확인합니다.',N'공식 안내에 따라 신청합니다.',N'자녀와 보호자의 조건을 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (16,'en',N'Apply for Child Allowance',N'Check child allowance after a birth or move.',N'Guardians raising children.',N'Check the application timing after a birth or move.',N'Apply according to the official guidance.',N'Check the child and guardian requirements.');
INSERT INTO JL_PROCEDURE_I18N VALUES (17,'ko',N'재류카드·재류절차 확인',N'재류카드와 재류절차를 공식 안내에서 확인합니다.',N'일본에 체류하는 외국인.',N'재류기간과 카드 유효기간을 확인합니다.',N'출입국재류관리청 절차를 확인합니다.',N'허가 판단은 출입국재류관리청이 합니다.');
INSERT INTO JL_PROCEDURE_I18N VALUES (17,'en',N'Check Residence Cards and Immigration Procedures',N'Check residence cards and immigration procedures.',N'Foreign nationals staying in Japan.',N'Check the period of stay and card validity.',N'Check Immigration Services Agency procedures.',N'Approval is decided by the Immigration Services Agency.');
INSERT INTO JL_PROCEDURE_I18N VALUES (18,'ko',N'외국인 상담 창구 이용',N'외국인 상담 창구와 다국어 상담을 확인합니다.',N'생활·행정 상담이 필요한 외국인.',N'상담일과 시간을 확인합니다.',N'전화 또는 창구에서 상담합니다.',N'언어와 시간은 기관별로 다릅니다.');
INSERT INTO JL_PROCEDURE_I18N VALUES (18,'en',N'Use Foreign Resident Consultation Services',N'Check foreign resident and multilingual consultation services.',N'Foreign residents needing daily-life or administrative advice.',N'Check consultation days and hours.',N'Consult by telephone or at a counter.',N'Languages and hours differ by service.');
INSERT INTO JL_PROCEDURE_I18N VALUES (19,'ko',N'재난·사고·긴급 상황 대비',N'재난·사고·긴급 상황에 대비합니다.',N'미나토구에 거주하거나 체류하는 사람.',N'평상시에 연락처와 대피 정보를 확인합니다.',N'공식 방재·긴급 안내를 확인합니다.',N'긴급 시 관계기관의 공식 안내를 따릅니다.');
INSERT INTO JL_PROCEDURE_I18N VALUES (19,'en',N'Prepare for Disasters and Emergencies',N'Prepare for disasters, accidents, and emergencies.',N'People living or staying in Minato City.',N'Check contacts and evacuation information in advance.',N'Check official disaster and emergency guidance.',N'Follow the official guidance of the relevant service in an emergency.');

INSERT INTO JL_DOCUMENT VALUES (40,9,N'在留カードまたは特別永住者証明書','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (41,10,N'住民異動届','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (42,11,N'個人番号カード交付申請書','CONDITIONAL',N'申請方法により必要です。',1);
INSERT INTO JL_DOCUMENT VALUES (43,12,N'マイナンバーカード','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (44,13,N'ごみ分別ガイドブック','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (45,14,N'妊娠届','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (46,15,N'出産に関する届出・証明書','CONDITIONAL',N'制度ごとに異なります。',1);
INSERT INTO JL_DOCUMENT VALUES (47,16,N'児童手当認定請求書','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (48,17,N'在留カード','REQUIRED',NULL,1);
INSERT INTO JL_DOCUMENT VALUES (49,18,N'相談内容のメモ','CONDITIONAL',N'상담 내용을 정리할 때 준비합니다.',1);
INSERT INTO JL_DOCUMENT VALUES (50,19,N'防災情報・避難情報','REQUIRED',NULL,1);

INSERT INTO JL_DOCUMENT_GUIDE VALUES (40,'ja',N'住所変更を確認するカードです。',N'転居する人全員分を用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (40,'ko',N'주소 변경을 확인하는 카드입니다.',N'이사하는 사람 전원의 서류를 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (40,'en',N'A card used to confirm the address change.',N'Prepare it for everyone moving.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (41,'ja',N'住所変更の届出書です。',N'公式案内で提出方法を確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (41,'ko',N'주소 변경 신고서입니다.',N'공식 안내에서 제출 방법을 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (41,'en',N'The form for reporting a move.',N'Check the filing method in the official guidance.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (42,'ja',N'カード申請に使う書類です。',N'申請方法を確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (42,'ko',N'카드 신청에 사용하는 서류입니다.',N'신청 방법을 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (42,'en',N'The form used for card application.',N'Check the application method.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (43,'ja',N'証明書発行に使用するカードです。',N'有効なカードと暗証番号を用意します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (43,'ko',N'증명서 발급에 사용하는 카드입니다.',N'유효한 카드와 비밀번호를 준비합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (43,'en',N'The card used for certificate services.',N'Prepare a valid card and PIN.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (44,'ja',N'ごみの分け方を確認するガイドです。',N'地域の収集日も確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (44,'ko',N'쓰레기 분리 방법을 확인하는 가이드입니다.',N'지역 수거일도 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (44,'en',N'A guide for sorting waste.',N'Also check the collection day for your area.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (45,'ja',N'妊娠を届け出る書類です。',N'窓口で必要事項を確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (45,'ko',N'임신을 신고하는 서류입니다.',N'창구에서 필요한 내용을 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (45,'en',N'The pregnancy notification form.',N'Confirm the required information at the counter.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (46,'ja',N'出産後の制度で確認する書類です。',N'制度ごとの必要書類を確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (46,'ko',N'출산 후 제도에서 확인하는 서류입니다.',N'제도별 필요 서류를 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (46,'en',N'Documents checked for postpartum programs.',N'Check the requirements for each program.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (47,'ja',N'児童手当の申請書です。',N'最新の書式を確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (47,'ko',N'아동수당 신청서입니다.',N'최신 서식을 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (47,'en',N'The child allowance application form.',N'Check the latest form.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (48,'ja',N'在留状況を確認するカードです。',N'有効期間を確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (48,'ko',N'재류 상태를 확인하는 카드입니다.',N'유효기간을 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (48,'en',N'The card used to confirm residence status.',N'Check its validity.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (49,'ja',N'相談内容を整理するメモです。',N'주소와 기한을 정리합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (49,'ko',N'상담 내용을 정리하는 메모입니다.',N'주소와 기한을 정리합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (49,'en',N'Notes for organizing your consultation.',N'Note the address and deadline.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (50,'ja',N'防災と避難の公式情報です。',N'平常時に確認します。');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (50,'ko',N'방재와 대피에 관한 공식 정보입니다.',N'평상시에 확인합니다.');
INSERT INTO JL_DOCUMENT_GUIDE VALUES (50,'en',N'Official information about disaster preparedness and evacuation.',N'Check it in advance.');

INSERT INTO JL_STEP VALUES (54,9,1,N'必要書類を確認',N'在留カードなどを確認します。');
INSERT INTO JL_STEP VALUES (55,9,2,N'転居届を提出',N'引っ越した後14日以内に届け出ます。');
INSERT INTO JL_STEP VALUES (56,10,1,N'方法を選ぶ',N'マイナポータル、窓口、郵送を確認します。');
INSERT INTO JL_STEP VALUES (57,10,2,N'書類を準備',N'本人確認書類などを確認します。');
INSERT INTO JL_STEP VALUES (58,10,3,N'転出届を提出',N'選択した方法で提出します。');
INSERT INTO JL_STEP VALUES (59,11,1,N'申請方法を選ぶ',N'郵便、オンライン、写真機から選びます。');
INSERT INTO JL_STEP VALUES (60,11,2,N'更新時期を確認',N'在留期間とカード期限を確認します。');
INSERT INTO JL_STEP VALUES (61,12,1,N'証明書を確認',N'発行できる証明書を確認します。');
INSERT INTO JL_STEP VALUES (62,12,2,N'コンビニで発行',N'カードと暗証番号を使います。');
INSERT INTO JL_STEP VALUES (63,13,1,N'分別方法を確認',N'ごみの種類を確認します。');
INSERT INTO JL_STEP VALUES (64,13,2,N'決められた場所に出す',N'収集日と場所を確認します。');
INSERT INTO JL_STEP VALUES (65,14,1,N'妊娠届を提出',N'妊娠届を提出します。');
INSERT INTO JL_STEP VALUES (66,14,2,N'母子健康手帳を受け取る',N'母子健康手帳と案内を受け取ります。');
INSERT INTO JL_STEP VALUES (67,15,1,N'対象制度を確認',N'出産後の支援制度を確認します。');
INSERT INTO JL_STEP VALUES (68,15,2,N'担当窓口へ申請',N'必要書類を確認して申請します。');
INSERT INTO JL_STEP VALUES (69,16,1,N'対象条件を確認',N'子どもと保護者の条件を確認します。');
INSERT INTO JL_STEP VALUES (70,16,2,N'申請書を提出',N'公式案内に従って申請します。');
INSERT INTO JL_STEP VALUES (71,17,1,N'在留状況を確認',N'在留資格と有効期間を確認します。');
INSERT INTO JL_STEP VALUES (72,17,2,N'公式手続を確認',N'出入国在留管理庁の案内を確認します。');
INSERT INTO JL_STEP VALUES (73,18,1,N'相談内容を整理',N'相談したい内容と期限を整理します。');
INSERT INTO JL_STEP VALUES (74,18,2,N'相談窓口を利用',N'電話または窓口で相談します。');
INSERT INTO JL_STEP VALUES (75,19,1,N'防災情報を確認',N'災害と避難の公式情報を確認します。');
INSERT INTO JL_STEP VALUES (76,19,2,N'緊急連絡先を確認',N'状況別の連絡先を確認します。');

INSERT INTO JL_SOURCE VALUES (22,9,N'港区：引っ越し（転居届）','https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/moving.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (23,10,N'港区：転出届','https://www.city.minato.tokyo.jp/shibamadosa/kurashi/todokede/hikkoshi/tenshutsu.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (24,11,N'港区：マイナンバーカード','https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/individualnumbercard.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (25,12,N'港区：コンビニ交付サービス','https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (26,13,N'港区：ごみのきまりとリサイクル','https://www.city.minato.tokyo.jp/easyjp/life/waste/index.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (27,14,N'港区：出産','https://www.city.minato.tokyo.jp/easyjp/child/childbirthandrearing/childbirth.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (28,15,N'港区：出産','https://www.city.minato.tokyo.jp/easyjp/child/childbirthandrearing/childbirth.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (29,16,N'港区：児童手当','https://www.city.minato.tokyo.jp/kodomokyufu/kodomo/kodomo/jidoteate.html',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (30,17,N'出入国在留管理庁：手続の種類から探す','https://www.moj.go.jp/isa/applications/procedures/',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (31,18,N'港区：外国語で相談したいとき','https://www.city.minato.tokyo.jp/easyjp/consultation/',DATE '2026-10-01',NULL);
INSERT INTO JL_SOURCE VALUES (32,19,N'港区：事故や災害に備える','https://www.city.minato.tokyo.jp/easyjp/accidentanddisaster/',DATE '2026-10-01',NULL);

INSERT INTO JL_PROC_OFFICE VALUES (9,1);
INSERT INTO JL_PROC_OFFICE VALUES (10,1);
INSERT INTO JL_PROC_OFFICE VALUES (11,1);
INSERT INTO JL_PROC_OFFICE VALUES (12,1);
INSERT INTO JL_PROC_OFFICE VALUES (13,1);
INSERT INTO JL_PROC_OFFICE VALUES (14,1);
INSERT INTO JL_PROC_OFFICE VALUES (15,1);
INSERT INTO JL_PROC_OFFICE VALUES (16,1);
INSERT INTO JL_PROC_OFFICE VALUES (18,1);
INSERT INTO JL_PROC_OFFICE VALUES (19,1);

-- Document names for preview language switching
INSERT INTO JL_DOCUMENT_I18N VALUES (40,'ko',N'재류카드 또는 특별영주자증명서',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (40,'en',N'Residence Card or Special Permanent Resident Certificate',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (41,'ko',N'주민이동신고서',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (41,'en',N'Moving Notification Form',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (42,'ko',N'개인번호 카드 교부 신청서',N'신청 방법에 따라 필요합니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (42,'en',N'My Number Card Application Form',N'Required depending on the application method.');
INSERT INTO JL_DOCUMENT_I18N VALUES (43,'ko',N'마이넘버 카드',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (43,'en',N'My Number Card',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (44,'ko',N'쓰레기 분별 가이드북',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (44,'en',N'Waste Sorting Guidebook',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (45,'ko',N'임신 신고서',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (45,'en',N'Pregnancy Notification',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (46,'ko',N'출생 관련 신고·증명서',N'제도별로 다릅니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (46,'en',N'Birth-Related Notifications and Certificates',N'Requirements differ by program.');
INSERT INTO JL_DOCUMENT_I18N VALUES (47,'ko',N'아동수당 인정 신청서',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (47,'en',N'Child Allowance Application Form',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (48,'ko',N'재류카드',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (48,'en',N'Residence Card',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (49,'ko',N'상담 내용 메모',N'상담 내용을 정리할 때 준비합니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (49,'en',N'Consultation Notes',N'Prepare when organizing your consultation.');
INSERT INTO JL_DOCUMENT_I18N VALUES (50,'ko',N'방재 정보·대피 정보',NULL);
INSERT INTO JL_DOCUMENT_I18N VALUES (50,'en',N'Disaster Prevention and Evacuation Information',NULL);

-- Step translations for preview language switching
INSERT INTO JL_STEP_I18N VALUES (54,'ko',N'필요 서류 확인',N'이사하는 사람 전원의 재류카드 등과 마이넘버 카드를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (54,'en',N'Check required documents',N'Check residence cards and My Number Cards for everyone moving.');
INSERT INTO JL_STEP_I18N VALUES (55,'ko',N'전거 신고 제출',N'이사한 후 14일 이내에 창구에서 신고합니다.');
INSERT INTO JL_STEP_I18N VALUES (55,'en',N'File the change of address notification',N'File at a counter within 14 days after moving.');
INSERT INTO JL_STEP_I18N VALUES (56,'ko',N'전출 방법 선택',N'마이넘버 포털, 창구, 우편 중 방법을 공식 안내에서 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (56,'en',N'Choose a filing method',N'Check the official guidance for online, counter, or mail filing.');
INSERT INTO JL_STEP_I18N VALUES (57,'ko',N'필요 서류 준비',N'본인확인서류, 주민이동신고서, 마이넘버 카드를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (57,'en',N'Prepare required documents',N'Check identification, the moving notification, and the My Number Card.');
INSERT INTO JL_STEP_I18N VALUES (58,'ko',N'전출 신고 제출',N'선택한 방법으로 미나토구에 신고하고 전입지 절차를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (58,'en',N'File the moving-out notification',N'File with Minato City and confirm the procedure at the new municipality.');
INSERT INTO JL_STEP_I18N VALUES (59,'ko',N'신청 방법 선택',N'우편, 스마트폰·PC, 증명사진 기기 중 방법을 선택합니다.');
INSERT INTO JL_STEP_I18N VALUES (59,'en',N'Choose an application method',N'Choose mail, smartphone or computer, or an ID photo booth.');
INSERT INTO JL_STEP_I18N VALUES (60,'ko',N'갱신 시기 확인',N'재류기간과 카드 유효기간을 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (60,'en',N'Check renewal timing',N'Check your period of stay and card validity.');
INSERT INTO JL_STEP_I18N VALUES (61,'ko',N'발급 가능한 증명서 확인',N'발급 가능한 증명서의 종류를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (61,'en',N'Check available certificates',N'Check the types of certificates available.');
INSERT INTO JL_STEP_I18N VALUES (62,'ko',N'편의점에서 발급',N'마이넘버 카드와 비밀번호를 사용해 발급합니다.');
INSERT INTO JL_STEP_I18N VALUES (62,'en',N'Obtain the certificate',N'Use your My Number Card and PIN at a convenience store.');
INSERT INTO JL_STEP_I18N VALUES (63,'ko',N'쓰레기 종류 확인',N'가연성·불연성·재활용 등 쓰레기 종류를 분류합니다.');
INSERT INTO JL_STEP_I18N VALUES (63,'en',N'Check the waste category',N'Sort waste into burnable, non-burnable, recyclable, and other categories.');
INSERT INTO JL_STEP_I18N VALUES (64,'ko',N'정해진 장소에 배출',N'수거일과 장소를 확인해 정해진 시간까지 배출합니다.');
INSERT INTO JL_STEP_I18N VALUES (64,'en',N'Put waste in the designated place',N'Check the collection day and place, then put waste out by the specified time.');
INSERT INTO JL_STEP_I18N VALUES (65,'ko',N'임신 신고 제출',N'임신 사실을 알게 되면 임신 신고를 합니다.');
INSERT INTO JL_STEP_I18N VALUES (65,'en',N'File the pregnancy notification',N'File the notification after learning about the pregnancy.');
INSERT INTO JL_STEP_I18N VALUES (66,'ko',N'모자건강수첩 받기',N'모자건강수첩과 관련 안내를 받습니다.');
INSERT INTO JL_STEP_I18N VALUES (66,'en',N'Receive the handbook',N'Receive the handbook and related information.');
INSERT INTO JL_STEP_I18N VALUES (67,'ko',N'대상 제도 확인',N'출산 후 이용할 수 있는 지원의 대상과 조건을 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (67,'en',N'Check eligible programs',N'Check the programs and requirements available after childbirth.');
INSERT INTO JL_STEP_I18N VALUES (68,'ko',N'담당 창구에 신청',N'필요 서류를 확인해 담당 창구에 신청합니다.');
INSERT INTO JL_STEP_I18N VALUES (68,'en',N'Apply through the responsible office',N'Check the required documents and apply through the responsible office.');
INSERT INTO JL_STEP_I18N VALUES (69,'ko',N'대상 여부 확인',N'자녀와 보호자의 조건을 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (69,'en',N'Check eligibility',N'Check the child and guardian requirements.');
INSERT INTO JL_STEP_I18N VALUES (70,'ko',N'신청서 제출',N'공식 안내에 따라 신청합니다.');
INSERT INTO JL_STEP_I18N VALUES (70,'en',N'Submit the application',N'Apply according to the official guidance.');
INSERT INTO JL_STEP_I18N VALUES (71,'ko',N'재류 상태 확인',N'재류자격과 유효기간을 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (71,'en',N'Check residence status',N'Check your status and validity period.');
INSERT INTO JL_STEP_I18N VALUES (72,'ko',N'공식 절차 확인',N'출입국재류관리청의 안내를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (72,'en',N'Check official procedures',N'Check the guidance from the Immigration Services Agency.');
INSERT INTO JL_STEP_I18N VALUES (73,'ko',N'상담 내용 정리',N'상담할 내용과 기한을 정리합니다.');
INSERT INTO JL_STEP_I18N VALUES (73,'en',N'Organize your questions',N'Organize the issue and deadline for your consultation.');
INSERT INTO JL_STEP_I18N VALUES (74,'ko',N'상담 창구 이용',N'전화 또는 창구에서 상담합니다.');
INSERT INTO JL_STEP_I18N VALUES (74,'en',N'Use a consultation service',N'Consult by telephone or at a counter.');
INSERT INTO JL_STEP_I18N VALUES (75,'ko',N'재난 정보 확인',N'재난과 대피에 관한 공식 정보를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (75,'en',N'Check disaster information',N'Check official information about disasters and evacuation.');
INSERT INTO JL_STEP_I18N VALUES (76,'ko',N'긴급 연락처 확인',N'사고·화재·구급 등 상황별 연락처를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (76,'en',N'Check emergency contacts',N'Check contacts for accidents, fires, medical emergencies, and other situations.');
