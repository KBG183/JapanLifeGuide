-- 17: 공식 안내 대조 후 생활행정 절차 9~19의 필요서류 설명 보완
-- Oracle 실행 전 전체 내용을 확인하고 실행하십시오.
-- 기존 행만 UPDATE하며, 테이블·기존 데이터 삭제 및 초기화는 하지 않습니다.
-- 공식 출처는 각 절차의 상세 화면에 연결된 JL_SOURCE URL을 기준으로 합니다.

-- 9. 港区内で引っ越すときの転居届
UPDATE JL_DOCUMENT SET condition_text=N'外国人住民が転居する場合。本人確認書類は窓口で手続きする人に必要です。' WHERE id=1000;
UPDATE JL_DOCUMENT_GUIDE SET description=N'外国人住民の住所変更を確認する在留カード・特別永住者証明書などです。', preparation_note=N'転居する外国人住民全員分を用意します。発行元は出入国在留管理庁です。' WHERE document_id=1000 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'외국인 주민의 주소 변경과 체류 자격을 확인하는 재류카드·특별영주자증명서 등입니다.', preparation_note=N'이사하는 외국인 주민 전원의 서류를 준비합니다. 발급기관은 출입국재류관리청입니다.' WHERE document_id=1000 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Residence cards or special permanent resident certificates used to confirm the address change and residence status of foreign residents.', preparation_note=N'Prepare one for every foreign resident who is moving. These are issued by the Immigration Services Agency.' WHERE document_id=1000 AND language_code='en';
UPDATE JL_DOCUMENT SET condition_text=N'マイナンバーカードを持っている人。' WHERE id=1001;
UPDATE JL_DOCUMENT_GUIDE SET description=N'住所変更の際にカード情報と電子証明書を確認するカードです。', preparation_note=N'持っている人全員分を持参し、必要な暗証番号を確認します。発行・更新方法は港区または地方公共団体情報システム機構の案内を確認します。' WHERE document_id=1001 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'주소 변경 때 카드 정보와 전자증명서를 확인하는 카드입니다.', preparation_note=N'보유한 사람 전원의 카드를 지참하고 필요한 비밀번호를 확인합니다. 발급·갱신 방법은 미나토구 공식 안내를 확인합니다.' WHERE document_id=1001 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The card used to confirm card information and electronic certificates after an address change.', preparation_note=N'Bring the card for every person who has one and confirm the required PINs. Check Minato City guidance for issuance or renewal.' WHERE document_id=1001 AND language_code='en';

-- 10. 港区から引っ越すときの転出届
UPDATE JL_DOCUMENT SET condition_text=N'窓口または郵送で転出届を提出する場合。' WHERE id=1002;
UPDATE JL_DOCUMENT_GUIDE SET description=N'転出届を記入する住民異動届です。', preparation_note=N'窓口または郵送で提出する場合に用意します。用紙は港区の窓口または公式申請書ダウンロードから入手できます。' WHERE document_id=1002 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'전출 신고를 작성하는 주민이동신고서입니다.', preparation_note=N'창구 또는 우편으로 제출할 때 준비합니다. 서식은 미나토구 창구 또는 공식 신청서 다운로드에서 받을 수 있습니다.' WHERE document_id=1002 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The resident-movement form used to file a moving-out notification.', preparation_note=N'Prepare it for counter or mail filing. Obtain it from a Minato City counter or the official application-form download page.' WHERE document_id=1002 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'本人確認に使用する公的な身分証明書です。', preparation_note=N'窓口では本人確認書類の提示とコピーが必要です。郵送では本人確認書類のコピーを同封します。健康保険資格確認書を使う場合は記号・番号等をマスキングします。' WHERE document_id=1003 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'신청자의 본인을 확인하는 공적 신분증입니다.', preparation_note=N'창구에서는 본인확인서류를 제시하고 사본을 제출할 수 있습니다. 우편 신청은 사본을 동봉합니다. 건강보험 자격확인서를 사용할 때는 기호·번호 등을 가립니다.' WHERE document_id=1003 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Official identification used to confirm the applicant.', preparation_note=N'For counter filing, present the document and allow a copy to be made. For mail filing, enclose a copy. Mask the relevant numbers if using a health-insurance eligibility certificate.' WHERE document_id=1003 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'マイナポータルでのオンライン転出や国外転出で確認するカードです。', preparation_note=N'持っている人全員分を確認します。オンライン申請では対応するスマートフォン等、署名用・利用者証明用等の暗証番号が必要です。' WHERE document_id=1004 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'마이넘버 포털 온라인 전출이나 해외 전출 때 확인하는 카드입니다.', preparation_note=N'보유한 사람 전원의 카드를 확인합니다. 온라인 신청에는 대응 스마트폰 등과 전자증명서 비밀번호가 필요합니다.' WHERE document_id=1004 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The card used for online moving-out filings and overseas moves.', preparation_note=N'Check the card for every person who has one. Online filing requires a compatible device and the relevant electronic-certificate PINs.' WHERE document_id=1004 AND language_code='en';

-- 11. マイナンバーカードの申請・更新
UPDATE JL_DOCUMENT_GUIDE SET description=N'マイナンバーカードの申請に使用する交付申請書です。', preparation_note=N'郵送・オンライン・対応する証明写真機のいずれかで申請します。申請書の二次元コードが必要な方法があります。' WHERE document_id=22 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'마이넘버 카드 신청에 사용하는 교부 신청서입니다.', preparation_note=N'우편·온라인·대응 증명사진 기기 중 방법을 선택합니다. 방법에 따라 신청서의 QR코드가 필요합니다.' WHERE document_id=22 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The application form used to apply for a My Number Card.', preparation_note=N'Apply by mail, online, or at a participating ID-photo booth. Some methods require the QR code on the form.' WHERE document_id=22 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'在留期間や本人確認を確認する在留カードです。', preparation_note=N'在留期間更新後など、カードの有効期間更新が必要な場合があります。更新時の必要書類は出入国在留管理庁の手続ごとの案内を確認します。' WHERE document_id=23 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'체류기간과 본인을 확인하는 재류카드입니다.', preparation_note=N'체류기간 갱신 후 등 카드 유효기간 갱신이 필요한 경우가 있습니다. 갱신 서류는 출입국재류관리청의 절차별 안내를 확인합니다.' WHERE document_id=23 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The residence card used to confirm your period of stay and identity.', preparation_note=N'You may need a validity-period renewal after renewing your period of stay. Check the Immigration Services Agency guidance for the applicable procedure.' WHERE document_id=23 AND language_code='en';

-- 12. コンビニ交付サービス
UPDATE JL_DOCUMENT_GUIDE SET description=N'暗証番号を登録したマイナンバーカードです。', preparation_note=N'港区に住民登録があり、対象の証明書を取得できる人が使用します。カードの利用者証明用電子証明書と暗証番号を確認します。' WHERE document_id=24 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'비밀번호를 등록한 마이넘버 카드입니다.', preparation_note=N'미나토구에 주민등록이 있고 대상 증명서를 발급받을 수 있는 사람이 사용합니다. 이용자증명용 전자증명서와 비밀번호를 확인합니다.' WHERE document_id=24 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'A My Number Card with a registered PIN.', preparation_note=N'Use it if you are registered as a Minato resident and eligible for the certificate. Confirm the user-certificate PIN.' WHERE document_id=24 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'証明書の発行時に入力する利用者証明用電子証明書の暗証番号です。', preparation_note=N'暗証番号は他人に教えません。住民票、印鑑登録証明書など、取得できる証明書と対象条件は港区の公式案内で確認します。' WHERE document_id=25 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'증명서 발급 때 입력하는 이용자증명용 전자증명서 비밀번호입니다.', preparation_note=N'비밀번호를 다른 사람에게 알려주지 않습니다. 발급 가능한 증명서와 대상 조건은 미나토구 공식 안내에서 확인합니다.' WHERE document_id=25 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The user-certificate PIN entered when obtaining a certificate.', preparation_note=N'Do not share the PIN. Check Minato City guidance for available certificates and eligibility.' WHERE document_id=25 AND language_code='en';

-- 13. ごみの分別・排出・リサイクル
UPDATE JL_DOCUMENT_GUIDE SET description=N'資源・ごみの種類と分別方法、排出時のルールを確認する港区の公式ガイドです。', preparation_note=N'日本語・英語・韓国語などの分別ガイドブックを港区公式ページから確認します。収集曜日は地域別カレンダーまたはごみ分別アプリで確認します。' WHERE document_id=26 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'자원·쓰레기 종류와 분리 방법, 배출 규칙을 확인하는 미나토구 공식 가이드입니다.', preparation_note=N'미나토구 공식 페이지에서 일본어·영어·한국어 등의 분별 가이드북을 확인합니다. 수거 요일은 지역별 달력이나 쓰레기 분별 앱에서 확인합니다.' WHERE document_id=26 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Minato City’s official guide to waste categories, sorting methods, and disposal rules.', preparation_note=N'Use the Japanese, English, or Korean guidebook on the official Minato City page. Check collection days in the area calendar or waste-sorting app.' WHERE document_id=26 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'建物ごとのごみ置き場を確認するための案内です。', preparation_note=N'ごみを出す場所は、マンションの管理人・管理会社・建物の所有者に確認します。' WHERE document_id=27 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'건물별 쓰레기 배출 장소를 확인하기 위한 안내입니다.', preparation_note=N'배출 장소는 아파트 관리인·관리회사·건물 소유자에게 확인합니다.' WHERE document_id=27 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Information used to identify the waste collection place for your building.', preparation_note=N'Ask the building manager, property manager, or owner where to put waste.' WHERE document_id=27 AND language_code='en';

-- 14. 妊娠届と母子健康手帳
UPDATE JL_DOCUMENT_GUIDE SET description=N'医療機関で妊娠の診断を受けた区民が提出する届出です。', preparation_note=N'各総合支所区民課保健福祉係に、妊娠が分かった後なるべく早く届け出ます。届出窓口で必要事項と本人確認について確認します。' WHERE document_id=28 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'의료기관에서 임신 진단을 받은 미나토구 주민이 제출하는 신고입니다.', preparation_note=N'임신을 알게 된 후 가능한 한 빨리 각 종합지소 구민과 보건복지계에 신고합니다. 창구에서 필요한 사항과 본인확인 방법을 확인합니다.' WHERE document_id=28 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The notification submitted by a Minato resident after a medical institution confirms pregnancy.', preparation_note=N'File it as soon as possible with the Residents and Welfare Section of a Regional City Office. Confirm the required information and identification at the counter.' WHERE document_id=28 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'妊娠中・出産後・子どもの健康記録を記入する手帳です。', preparation_note=N'妊娠届を提出すると交付されます。交付後は妊婦健診、出産、子どもの健診・予防接種のときに持参します。' WHERE document_id=29 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'임신·출산·자녀의 건강 기록을 적는 수첩입니다.', preparation_note=N'임신 신고 후 교부받습니다. 이후 임산부 검진, 출산, 자녀의 건강검진·예방접종 때 지참합니다.' WHERE document_id=29 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The handbook for recording health information during pregnancy, childbirth, and child care.', preparation_note=N'It is issued after the pregnancy notification. Bring it to pregnancy checkups, childbirth-related care, child health checkups, and vaccinations.' WHERE document_id=29 AND language_code='en';

-- 15. 出産後の支援と出産育児一時金
UPDATE JL_DOCUMENT_GUIDE SET description=N'出生後の各制度で提出・確認する出生届や証明書です。', preparation_note=N'出生届、出生通知、各種助成など制度により必要書類と提出先が異なります。対象制度の公式案内または担当窓口で確認します.' WHERE document_id=30 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'출산 후 각 제도에서 제출·확인하는 출생 신고서와 증명서입니다.', preparation_note=N'출생신고, 출생통지, 각종 지원은 제도별 필요서류와 제출처가 다릅니다. 해당 제도의 공식 안내나 담당 창구에서 확인합니다.' WHERE document_id=30 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Birth notifications and certificates submitted or checked for postpartum programs.', preparation_note=N'Required documents and submission offices differ by program, such as the birth notification, birth notice, and support programs. Confirm with the official guidance or responsible counter.' WHERE document_id=30 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'公的医療保険の加入状況を確認する資料です。', preparation_note=N'出産育児一時金は加入している公的医療保険により手続きが異なります。港区国保で直接支払制度を利用しない場合や海外出産の場合は、公式案内に従って各総合支所等へ申請します.' WHERE document_id=31 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'공적 의료보험 가입 상태를 확인하는 자료입니다.', preparation_note=N'출산육아일시금은 가입한 공적 의료보험에 따라 절차가 다릅니다. 미나토구 국민건강보험에서 직접지급제도를 이용하지 않거나 해외에서 출산한 경우 공식 안내에 따라 신청합니다.' WHERE document_id=31 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Document used to confirm public health-insurance coverage.', preparation_note=N'The procedure for the childbirth lump-sum allowance depends on your public insurer. For Minato National Health Insurance, confirm the application process for cases such as not using direct payment or giving birth overseas.' WHERE document_id=31 AND language_code='en';

-- 16. 児童手当の申請
UPDATE JL_DOCUMENT_GUIDE SET description=N'児童手当を受けるための認定請求書です。', preparation_note=N'出生・転入等の翌日から15日以内を目安に申請します。各総合支所区民課保健福祉係、郵送またはマイナポータルで提出できます。公務員は勤務先に申請します.' WHERE document_id=32 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'아동수당을 받기 위한 인정청구서입니다.', preparation_note=N'출생·전입 등의 다음 날부터 15일 이내를 기준으로 신청합니다. 각 종합지소 창구, 우편 또는 마이넘버 포털로 제출할 수 있습니다. 공무원은 근무처에 신청합니다.' WHERE document_id=32 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The certification-claim form for child allowance.', preparation_note=N'As a general rule, apply within 15 days after the day following birth or moving in. Submit it at a Regional City Office, by mail, or through My Number Portal. Public employees apply through their employer.' WHERE document_id=32 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'申請者、配偶者、児童などの状況を確認するための書類です。', preparation_note=N'本人確認書類、個人番号確認書類、請求者名義の口座資料を基本に、該当者は健康保険・加入年金資料、海外居住歴を確認する旅券写し、代理人の委任状等を用意します.' WHERE document_id=33 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'신청자·배우자·자녀 등의 상황을 확인하기 위한 서류입니다.', preparation_note=N'본인확인서류, 개인번호 확인서류, 신청자 명의 계좌자료를 기본으로 준비합니다. 해당자는 건강보험·가입연금 자료, 해외 거주 이력을 확인하는 여권 사본, 대리인의 위임장 등을 추가합니다.' WHERE document_id=33 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Documents used to confirm the applicant, spouse, and child circumstances.', preparation_note=N'Prepare identification, Individual Number documents, and proof of the claimant’s bank account. Depending on the case, also prepare health-insurance or pension documents, a passport copy showing overseas residence history, or a proxy authorization.' WHERE document_id=33 AND language_code='en';

-- 17. 在留カード・在留手続の確認
UPDATE JL_DOCUMENT_GUIDE SET description=N'中長期在留者に交付される在留カードです。', preparation_note=N'有効期間、在留資格、氏名・住所などの記載事項を確認します。紛失・汚損・記載事項変更・有効期間更新は出入国在留管理庁の該当手続を確認します.' WHERE document_id=34 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'중장기 체류자에게 교부되는 재류카드입니다.', preparation_note=N'유효기간, 체류자격, 이름·주소 등 기재사항을 확인합니다. 분실·훼손·기재사항 변경·유효기간 갱신은 출입국재류관리청의 해당 절차를 확인합니다.' WHERE document_id=34 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'The residence card issued to mid- and long-term residents.', preparation_note=N'Check its validity, status of residence, name, address, and other entries. For loss, damage, changes, or validity renewal, follow the applicable Immigration Services Agency procedure.' WHERE document_id=34 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'申請する在留手続に応じて提出する書類です。', preparation_note=N'在留期間更新、在留資格変更、資格外活動などで必要書類が異なります。申請書、写真、旅券または在留資格証明書、現在の在留カードなど、該当する出入国在留管理庁のチェックリストを確認します.' WHERE document_id=35 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'신청하는 체류 절차에 따라 제출하는 서류입니다.', preparation_note=N'체류기간 갱신, 체류자격 변경, 자격 외 활동 등 절차에 따라 필요서류가 다릅니다. 신청서·사진·여권 또는 체류자격증명서·현재 재류카드 등 해당 출입국재류관리청 체크리스트를 확인합니다.' WHERE document_id=35 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Documents submitted for the specific immigration procedure.', preparation_note=N'Requirements differ for period renewal, status changes, and permission for activities outside your status. Check the Immigration Services Agency checklist for the application, photo, passport or certificate of status, current residence card, and other applicable documents.' WHERE document_id=35 AND language_code='en';

-- 18. 外国人相談窓口を利用する
UPDATE JL_DOCUMENT SET condition_text=N'相談内容により必要になる場合があります。' WHERE id=36;
UPDATE JL_DOCUMENT_GUIDE SET description=N'相談したい生活・行政上の問題を整理したメモです。', preparation_note=N'相談内容、住所、期限、相手の機関から受けた案内などを整理します。必須書類ではありませんが、相談を円滑にします。' WHERE document_id=36 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'상담하려는 생활·행정 문제를 정리한 메모입니다.', preparation_note=N'상담 내용·주소·기한·상대 기관에서 받은 안내 등을 정리합니다. 필수 서류는 아니지만 상담을 원활하게 하는 데 도움이 됩니다.' WHERE document_id=36 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Notes organizing the daily-life or administrative issue you want to discuss.', preparation_note=N'Write the issue, address, deadline, and any notice received from another office. This is not mandatory but helps the consultation.' WHERE document_id=36 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'相談機関から求められる場合がある本人確認書類です。', preparation_note=N'港区の外国人相談は電話または窓口で利用できます。本人確認書類が必要かどうかは相談内容と窓口に事前確認します.' WHERE document_id=37 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'상담기관에서 요구할 수 있는 본인확인서류입니다.', preparation_note=N'미나토구 외국인 상담은 전화 또는 창구로 이용할 수 있습니다. 본인확인서류가 필요한지는 상담 내용과 창구에 미리 확인합니다.' WHERE document_id=37 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Identification that a consultation service may request.', preparation_note=N'Minato City foreign-resident consultation is available by phone or at a counter. Confirm in advance whether identification is needed for your case.' WHERE document_id=37 AND language_code='en';

-- 19. 災害・事故・緊急時の備え
UPDATE JL_DOCUMENT_GUIDE SET description=N'災害への備え、避難場所、避難経路、防災情報を確認する公式案内です。', preparation_note=N'港区の防災ページや防災アプリで避難所・避難経路を平常時に確認します。非常用持出袋には水・食料・ライト・薬・パスポート・在留カードなどを準備します.' WHERE document_id=38 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'재난 대비, 대피 장소·경로와 방재 정보를 확인하는 공식 안내입니다.', preparation_note=N'평상시에 미나토구 방재 페이지나 방재 앱으로 대피소와 경로를 확인합니다. 비상용 가방에는 물·식량·손전등·약·여권·재류카드 등을 준비합니다.' WHERE document_id=38 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Official guidance for disaster preparedness, evacuation places, routes, and emergency information.', preparation_note=N'Check shelters and routes in advance through Minato City’s disaster-prevention page or app. Prepare water, food, a light, medicine, passport, residence card, and other emergency items.' WHERE document_id=38 AND language_code='en';
UPDATE JL_DOCUMENT_GUIDE SET description=N'緊急時に連絡する機関と電話番号を整理するメモです。', preparation_note=N'110（警察）、119（火事・救急）などの緊急番号、家族の連絡先、勤務先・学校・管理会社の連絡先を家族と確認します。' WHERE document_id=39 AND language_code='ja';
UPDATE JL_DOCUMENT_GUIDE SET description=N'긴급 시 연락할 기관과 전화번호를 정리하는 메모입니다.', preparation_note=N'110(경찰), 119(화재·구급) 등 긴급번호와 가족·직장·학교·관리회사 연락처를 가족과 함께 확인합니다.' WHERE document_id=39 AND language_code='ko';
UPDATE JL_DOCUMENT_GUIDE SET description=N'Notes listing emergency services and important telephone numbers.', preparation_note=N'Review 110 for police, 119 for fire or ambulance, and contact details for family, work, school, and the property manager with your household.' WHERE document_id=39 AND language_code='en';

UPDATE JL_DOCUMENT_GUIDE SET description=N'妊娠中・出産後・子どもの健康記録を記入する手帳です。', preparation_note=N'妊娠届を提出すると交付されます。交付後は妊婦健診、出産、子どもの健診・予防接種のときに持参します。' WHERE document_id=29 AND language_code='ja';

-- 공식 안내에 있으나 기존 행에 없던 조건부 문서를 추가합니다.
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 9, N'窓口で手続きする人の本人確認書類', 'REQUIRED', N'窓口で手続きをする人に必要です。', 3 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=9 AND name=N'窓口で手続きする人の本人確認書類');
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 9, N'国民健康保険資格確認書', 'CONDITIONAL', N'港区の国民健康保険に加入している人のみ。', 4 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=9 AND name=N'国民健康保険資格確認書');
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 10, N'印鑑登録証', 'CONDITIONAL', N'港区で印鑑登録している人のみ。', 4 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=10 AND name=N'印鑑登録証');
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 10, N'国民健康保険資格確認書', 'CONDITIONAL', N'港区の国民健康保険に加入している人のみ。', 5 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=10 AND name=N'国民健康保険資格確認書');
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 10, N'返信用封筒', 'CONDITIONAL', N'郵送で転出届を提出する場合。', 6 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=10 AND name=N'返信用封筒');
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 11, N'顔写真', 'CONDITIONAL', N'郵送または対応する申請方法で必要です。', 3 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=11 AND name=N'顔写真');
INSERT INTO JL_DOCUMENT (id, procedure_id, name, requirement, condition_text, display_order)
SELECT jl_document_seq.NEXTVAL, 11, N'交付通知書と本人確認書類', 'REQUIRED', N'カード受取時に必要です。', 4 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM JL_DOCUMENT WHERE procedure_id=11 AND name=N'交付通知書と本人確認書類');

INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'창구 방문자의 본인확인서류', N'창구에서 절차를 진행하는 사람에게 필요합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'窓口で手続きする人の本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'Identification for the person filing at the counter', N'Required for the person filing at the counter.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'窓口で手続きする人の本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'국민건강보험 자격확인서', N'미나토구 국민건강보험 가입자에게만 해당합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'National Health Insurance eligibility certificate', N'Only for people enrolled in Minato City National Health Insurance.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'인감등록증', N'미나토구에서 인감등록을 한 사람에게만 해당합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'印鑑登録証' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'Personal seal registration card', N'Only for people with a seal registered in Minato City.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'印鑑登録証' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'국민건강보험 자격확인서', N'미나토구 국민건강보험 가입자에게만 해당합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'National Health Insurance eligibility certificate', N'Only for people enrolled in Minato City National Health Insurance.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'회신용 봉투', N'우편으로 전출 신고를 제출할 때 필요합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'返信用封筒' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'Return envelope', N'Required when filing the moving-out notification by mail.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'返信用封筒' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'얼굴 사진', N'우편 또는 해당 신청 방법에서 필요합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'顔写真' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'Face photograph', N'Required for mail or applicable application methods.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'顔写真' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'ko', N'교부 통지서와 본인확인서류', N'카드를 수령할 때 필요합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'交付通知書と本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='ko');
INSERT INTO JL_DOCUMENT_I18N (document_id, language_code, name, condition_text)
SELECT d.id, 'en', N'Issuance notice and identification', N'Required when receiving the card.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'交付通知書と本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_I18N i WHERE i.document_id=d.id AND i.language_code='en');

INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'窓口で手続きをする人の本人確認書類です。',N'港区が受け付ける本人確認書類を用意します。' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'窓口で手続きする人の本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'창구에서 절차를 진행하는 사람의 본인확인서류입니다.',N'미나토구가 인정하는 본인확인서류를 준비합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'窓口で手続きする人の本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'Identification for the person filing at the counter.',N'Prepare identification accepted by Minato City.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'窓口で手続きする人の本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'港区の国民健康保険に加入している人の資格を確認する書類です。',N'港区国保に加入している人だけ、資格確認書を用意します。' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'미나토구 국민건강보험 가입 자격을 확인하는 서류입니다.',N'미나토구 국민건강보험 가입자만 자격확인서를 준비합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'A document confirming Minato City National Health Insurance coverage.',N'Prepare it only if you are enrolled in Minato City National Health Insurance.' FROM JL_DOCUMENT d WHERE d.procedure_id=9 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');

-- 추가 문서의 상세 설명은 기존 문서와 같은 공식 조건을 사용합니다.
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'港区で印鑑登録している人に返却する印鑑登録証です。',N'港区で印鑑登録している人だけ、転出届のときに返却します。' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'印鑑登録証' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'미나토구에서 인감등록을 한 사람이 반납하는 인감등록증입니다.',N'미나토구에서 인감등록을 한 사람만 전출 신고 때 반납합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'印鑑登録証' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'The personal seal registration card returned by people registered in Minato City.',N'Only people with a seal registered in Minato City return it when filing to move out.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'印鑑登録証' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'港区の国民健康保険に加入している人が返却する資格確認書です。',N'港区国保に加入している人だけ、転出届のときに返却します。' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'미나토구 국민건강보험 가입자가 반납하는 자격확인서입니다.',N'미나토구 국민건강보험 가입자만 전출 신고 때 반납합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'The eligibility certificate returned by people enrolled in Minato City National Health Insurance.',N'Only people enrolled in Minato City National Health Insurance return it when moving out.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'国民健康保険資格確認書' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'郵送で転出証明書を返送してもらうための封筒です。',N'宛先を記入し、必要な切手を貼った返信用封筒を同封します。' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'返信用封筒' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'전출증명서를 돌려받기 위한 회신용 봉투입니다.',N'주소를 적고 필요한 우표를 붙인 회신용 봉투를 동봉합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'返信用封筒' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'A return envelope for sending the moving-out certificate.',N'Write the address and attach the required postage before enclosing it.' FROM JL_DOCUMENT d WHERE d.procedure_id=10 AND d.name=N'返信用封筒' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');

INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'申請に添付する本人の顔写真です。',N'郵送申請など、方法に応じて指定規格の写真を用意します。' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'顔写真' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'신청서에 첨부하는 본인 얼굴 사진입니다.',N'우편 신청 등 방법에 따라 지정 규격의 사진을 준비합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'顔写真' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'The applicant’s face photograph attached to the application.',N'Prepare a photograph meeting the specified requirements for the applicable method.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'顔写真' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ja',N'カード受取時に提示する交付通知書と本人確認書類です。',N'交付通知書に記載された受取場所と必要な本人確認書類を確認します。' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'交付通知書と本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ja');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'ko',N'카드 수령 때 제시하는 교부 통지서와 본인확인서류입니다.',N'교부 통지서에 적힌 수령 장소와 필요한 본인확인서류를 확인합니다.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'交付通知書と本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='ko');
INSERT INTO JL_DOCUMENT_GUIDE (document_id, language_code, description, preparation_note)
SELECT d.id,'en',N'The issuance notice and identification presented when collecting the card.',N'Check the collection place on the notice and the identification required for collection.' FROM JL_DOCUMENT d WHERE d.procedure_id=11 AND d.name=N'交付通知書と本人確認書類' AND NOT EXISTS (SELECT 1 FROM JL_DOCUMENT_GUIDE g WHERE g.document_id=d.id AND g.language_code='en');

COMMIT;
