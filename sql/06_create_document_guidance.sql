-- 06: 준비 서류 상세 안내
-- 기존 JL_DOCUMENT 데이터를 수정하거나 삭제하지 않습니다.
-- Oracle 설치가 완료된 계정에서 한 번만 실행하세요.

CREATE TABLE JL_DOCUMENT_GUIDE (
    document_id NUMBER(19) NOT NULL REFERENCES JL_DOCUMENT(id),
    language_code VARCHAR2(5) NOT NULL,
    description NVARCHAR2(1000) NOT NULL,
    preparation_note NVARCHAR2(1000) NOT NULL,
    CONSTRAINT jl_doc_guide_pk PRIMARY KEY (document_id, language_code),
    CONSTRAINT jl_doc_guide_lang_ck CHECK (language_code IN ('ja','ko','en'))
);

CREATE INDEX jl_doc_guide_lang_ix ON JL_DOCUMENT_GUIDE(language_code);

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
COMMIT;
