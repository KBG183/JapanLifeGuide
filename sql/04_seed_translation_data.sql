-- 04: 초기 절차의 한국어·영어 번역 데이터
-- 03_create_translation_tables.sql 실행 후 SOLO 계정으로 1회 실행합니다.
-- 공식 원문을 대체하지 않는 번역 초안이므로 배포 전 검토하세요.

INSERT INTO JL_PROCEDURE_I18N VALUES (1,'ko',N'해외에서 미나토구로 이사',N'일본 생활을 시작하는 분을 위한 전입 신고 준비 안내입니다.',N'해외에서 미나토구로 거주지를 옮기는 외국인 주민입니다. 회사 소재지가 아니라 실제 거주지를 기준으로 판단합니다.',N'미나토구에서 생활을 시작한 날부터 14일 이내입니다. 입주 전 신고는 할 수 없습니다.',N'종합지소 창구서비스계 또는 다이바 분실 창구에서 신고합니다.',N'본인이 신고하는 경우의 기본 안내입니다. 대리인이나 재류카드 후일 교부 등 개별 조건은 공식 안내를 확인해 주세요.');
INSERT INTO JL_PROCEDURE_I18N VALUES (1,'en',N'Moving to Minato City from overseas',N'A guide to preparing your moving-in notification when starting life in Japan.',N'Foreign residents moving their home to Minato City from overseas. Use your actual residence, not your company address.',N'Within 14 days after starting to live in Minato City. You cannot file before moving in.',N'File at the counter service section of a general branch office or at the Daiba branch.',N'This is a basic guide for filing in person. Check the official guidance for individual conditions such as representatives or a residence card issued later.');
INSERT INTO JL_PROCEDURE_I18N VALUES (2,'ko',N'일본의 다른 시구정촌에서 미나토구로 이사',N'일본 국내에서 주소가 바뀌는 분을 위한 전입 신고 안내입니다.',N'일본의 다른 시구정촌에서 미나토구로 거주지를 옮기는 외국인 주민입니다.',N'미나토구에서 생활을 시작한 날부터 14일 이내입니다. 마이넘버카드를 이용한 전출은 전출 예정일 관련 기한도 확인해 주세요.',N'종합지소 창구서비스계 또는 다이바 분실 창구에서 신고합니다.',N'본인이 신고하는 경우의 기본 안내입니다. 마이넘버카드를 이용해 전출한 경우 카드 실물이 필요합니다.');
INSERT INTO JL_PROCEDURE_I18N VALUES (2,'en',N'Moving to Minato City from another municipality in Japan',N'A guide to the moving-in notification when your address changes within Japan.',N'Foreign residents moving their home to Minato City from another municipality in Japan.',N'Within 14 days after starting to live in Minato City. If you used a My Number Card for moving out, also check the deadline related to the scheduled moving-out date.',N'File at the counter service section of a general branch office or at the Daiba branch.',N'This is a basic guide for filing in person. If you used a My Number Card to move out, bring the physical card.');

INSERT INTO JL_DOCUMENT_I18N VALUES (1,'ko',N'여권',N'전입하는 사람 전원의 여권입니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (1,'en',N'Passport',N'For everyone moving in.');
INSERT INTO JL_DOCUMENT_I18N VALUES (2,'ko',N'재류카드 등',N'전원 필요. 재류카드·특별영주자증명서 등 해당 증명서를 준비합니다. 후일 교부인 경우 공식 안내를 확인해 주세요.');
INSERT INTO JL_DOCUMENT_I18N VALUES (2,'en',N'Residence card or equivalent',N'For everyone. Prepare the applicable certificate, such as a residence card or special permanent resident certificate. Check the official guidance if it will be issued later.');
INSERT INTO JL_DOCUMENT_I18N VALUES (3,'ko',N'입국일을 확인할 수 있는 자료',N'여권으로 입국일을 확인할 수 없는 경우 탑승권이나 수하물 태그 등을 준비합니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (3,'en',N'Proof of the date of entry',N'If the entry date cannot be confirmed from your passport, prepare a boarding pass, baggage tag, or similar document.');
INSERT INTO JL_DOCUMENT_I18N VALUES (4,'ko',N'가족관계 증명서와 번역문',N'가족 등 2명 이상이 전입하는 경우 본국 발행 원본과 일본어 번역문을 준비합니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (4,'en',N'Proof of family relationship and translation',N'When two or more family members move in, prepare the original issued in your home country and a Japanese translation.');
INSERT INTO JL_DOCUMENT_I18N VALUES (5,'ko',N'마이넘버카드',N'보유한 사람의 카드입니다. 필요한 비밀번호 등은 공식 안내를 확인해 주세요.');
INSERT INTO JL_DOCUMENT_I18N VALUES (5,'en',N'My Number Card',N'For people who have one. Check the official guidance for required PINs and other details.');
INSERT INTO JL_DOCUMENT_I18N VALUES (6,'ko',N'연금 수첩',N'공식 안내상 국민연금 가입 대상자에게 해당합니다. 개인별 가입 조건은 별도로 확인해 주세요.');
INSERT INTO JL_DOCUMENT_I18N VALUES (6,'en',N'Pension handbook',N'According to the official guidance, this applies to people joining the National Pension. Check individual eligibility separately.');
INSERT INTO JL_DOCUMENT_I18N VALUES (7,'ko',N'창구 방문자의 본인확인서류',N'사용할 수 있는 서류는 공식 안내를 확인해 주세요.');
INSERT INTO JL_DOCUMENT_I18N VALUES (7,'en',N'ID for the person visiting the counter',N'Check the official guidance for acceptable documents.');
INSERT INTO JL_DOCUMENT_I18N VALUES (8,'ko',N'재류카드 등',N'전입하는 외국인 주민 전원의 해당 증명서입니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (8,'en',N'Residence card or equivalent',N'For every foreign resident moving in.');
INSERT INTO JL_DOCUMENT_I18N VALUES (9,'ko',N'전출증명서',N'마이넘버카드를 이용한 전출은 생략할 수 있습니다. 그 외에는 이전 지자체의 증명서를 준비합니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (9,'en',N'Moving-out certificate',N'This may be omitted when you used a My Number Card to move out. Otherwise prepare the certificate from your previous municipality.');
INSERT INTO JL_DOCUMENT_I18N VALUES (10,'ko',N'마이넘버카드',N'보유한 모든 사람의 카드입니다. 마이넘버카드를 이용한 전출은 제시해야 합니다.');
INSERT INTO JL_DOCUMENT_I18N VALUES (10,'en',N'My Number Card',N'For everyone who has one. It must be presented when you used it to move out.');

INSERT INTO JL_STEP_I18N VALUES (1,'ko',N'본인 조건 확인',N'본인·가족·입국일 확인 방법에 따라 공식 안내를 읽습니다.');
INSERT INTO JL_STEP_I18N VALUES (1,'en',N'Check your situation',N'Read the official guidance based on how you will confirm your identity, family, and entry date.');
INSERT INTO JL_STEP_I18N VALUES (2,'ko',N'서류와 창구 확인',N'해당 서류를 준비하고 접수 시간을 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (2,'en',N'Check documents and counter',N'Prepare the applicable documents and check the reception hours.');
INSERT INTO JL_STEP_I18N VALUES (3,'ko',N'창구에서 전입 신고 제출',N'입주 후 기한 내에 창구를 방문합니다. 신고서는 창구에서 받을 수 있습니다.');
INSERT INTO JL_STEP_I18N VALUES (3,'en',N'File the moving-in notification',N'Visit the counter within the deadline after moving in. You can receive the form at the counter.');
INSERT INTO JL_STEP_I18N VALUES (4,'ko',N'전출 방법 확인',N'이전 지자체에서의 전출 방법에 따라 증명서 또는 카드를 준비합니다.');
INSERT INTO JL_STEP_I18N VALUES (4,'en',N'Check how you moved out',N'Prepare the certificate or card required for the way you moved out of the previous municipality.');
INSERT INTO JL_STEP_I18N VALUES (5,'ko',N'본인확인서류 등 준비',N'필요한 서류와 보유 중인 카드를 확인합니다.');
INSERT INTO JL_STEP_I18N VALUES (5,'en',N'Prepare identification and other documents',N'Check the required documents and any cards you have.');
INSERT INTO JL_STEP_I18N VALUES (6,'ko',N'창구에서 전입 신고 제출',N'미나토구에서 생활을 시작한 후 기한 내에 창구에서 절차를 진행합니다.');
INSERT INTO JL_STEP_I18N VALUES (6,'en',N'File the moving-in notification',N'Complete the procedure at the counter within the deadline after starting to live in Minato City.');

INSERT INTO JL_SOURCE_I18N VALUES (1,'ko',N'미나토구: 전입 신고 공식 안내');
INSERT INTO JL_SOURCE_I18N VALUES (1,'en',N'Minato City: Official moving-in notification guide');
INSERT INTO JL_SOURCE_I18N VALUES (2,'ko',N'미나토구: 전입 신고 공식 안내');
INSERT INTO JL_SOURCE_I18N VALUES (2,'en',N'Minato City: Official moving-in notification guide');
INSERT INTO JL_SOURCE_I18N VALUES (3,'ko',N'미나토구 생활 가이드: 이사');
INSERT INTO JL_SOURCE_I18N VALUES (3,'en',N'Minato City living guide: Moving');
INSERT INTO JL_SOURCE_I18N VALUES (4,'ko',N'미나토구 생활 가이드: 이사');
INSERT INTO JL_SOURCE_I18N VALUES (4,'en',N'Minato City living guide: Moving');

INSERT INTO JL_OFFICE_I18N VALUES (1,'ko',N'각 종합지소 창구서비스계·다이바 분실',N'방문할 창구의 주소와 접수 시간은 공식 안내에서 확인해 주세요.');
INSERT INTO JL_OFFICE_I18N VALUES (1,'en',N'Counter service section of each general branch office and Daiba branch',N'Check the address and reception hours of the counter you will visit in the official guidance.');
COMMIT;
