-- 19: 절차 11~19의 창구·담당기관 연결 보완
-- 기존 테이블과 기존 행을 삭제하지 않습니다.
-- 동일한 기관이 이미 있으면 다시 삽입하지 않고, 절차 연결만 공식 기관으로 교체합니다.

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'港区マイナンバーカード案内', NULL,
       'https://www.city.minato.tokyo.jp/kikaku/kaikaku/mainanba/tutikado.html',
       N'申請方法、交付、更新の最新案内は港区公式ページで確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/kikaku/kaikaku/mainanba/tutikado.html');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'港区コンビニ交付サービス案内', NULL,
       'https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html',
       N'取得できる証明書、対象条件、利用時間は公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'みなとリサイクル清掃事務所', NULL,
       'https://www.city.minato.tokyo.jp/gomigenryou/kurashi/gomi/kate/bunbetsu/',
       N'分別方法・収集曜日・排出場所は公式案内と建物の管理者に確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/gomigenryou/kurashi/gomi/kate/bunbetsu/');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'各総合支所区民課保健福祉係（妊娠届）', NULL,
       'https://www.city.minato.tokyo.jp/chiikihoken/kenko/ninshin/ninshin/ninshin.html',
       N'妊娠届の提出先、受付時間、外国語対応は公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/chiikihoken/kenko/ninshin/ninshin/ninshin.html');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'港区国保の出産育児一時金窓口', NULL,
       'https://www.city.minato.tokyo.jp/kyufu/20181019.html',
       N'直接支払制度を利用しない場合や海外出産などの申請方法は公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/kyufu/20181019.html');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'各総合支所区民課保健福祉係（児童手当）', NULL,
       'https://www.city.minato.tokyo.jp/kodomokyufu/kodomo/kodomo/jidoteate.html',
       N'申請方法、公務員の申請先、必要書類は公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/kodomokyufu/kodomo/kodomo/jidoteate.html');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'出入国在留管理庁の在留手続案内', NULL,
       'https://www.moj.go.jp/isa/applications/procedures/',
       N'申請書・必要書類・受付先は手続の種類に応じて出入国在留管理庁の公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.moj.go.jp/isa/applications/procedures/');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'港区外国人相談窓口', NULL,
       'https://www.city.minato.tokyo.jp/easyjp/en/consultation/',
       N'電話・窓口での相談方法、受付時間、対応言語は公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/easyjp/en/consultation/');

INSERT INTO JL_OFFICE (id, name, address, homepage_url, note)
SELECT jl_office_seq.NEXTVAL, N'港区防災・避難情報案内', NULL,
       'https://www.city.minato.tokyo.jp/easyjp/accidentanddisaster/',
       N'避難所・防災アプリ・緊急対応の情報は港区の公式案内で確認してください。'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/easyjp/accidentanddisaster/');

-- 기관명·안내를 다국어로 표시합니다.
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'미나토구 마이넘버카드 안내',N'신청·교부·갱신의 최신 안내는 미나토구 공식 페이지에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/kikaku/kaikaku/mainanba/tutikado.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Minato City My Number Card guidance',N'Check the official Minato City page for the latest application, collection, and renewal guidance.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/kikaku/kaikaku/mainanba/tutikado.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'미나토구 편의점 교부 안내',N'발급 가능한 증명서·대상 조건·이용시간은 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Minato City convenience-store certificate guidance',N'Check the official guidance for available certificates, eligibility, and hours.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'미나토 리사이클 청소사무소',N'분별 방법·수거 요일·배출 장소는 공식 안내와 건물 관리자에게 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/gomigenryou/kurashi/gomi/kate/bunbetsu/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Minato Recycling and Cleaning Office',N'Check the official guidance and your building manager for sorting, collection days, and the disposal place.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/gomigenryou/kurashi/gomi/kate/bunbetsu/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'각 종합지소 구민과 보건복지계(임신 신고)',N'임신 신고 장소·접수시간·외국어 대응은 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/chiikihoken/kenko/ninshin/ninshin/ninshin.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Residents and Welfare Section of a Regional City Office (pregnancy notification)',N'Check the official guidance for the filing location, hours, and language support.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/chiikihoken/kenko/ninshin/ninshin/ninshin.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'미나토구 국민건강보험 출산육아일시금 창구',N'직접지급제도를 이용하지 않거나 해외 출산인 경우의 신청방법은 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/kyufu/20181019.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Minato National Health Insurance childbirth benefit service',N'Check the official guidance for cases such as not using direct payment or giving birth overseas.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/kyufu/20181019.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'각 종합지소 구민과 보건복지계(아동수당)',N'신청 방법·공무원 신청처·필요서류는 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/kodomokyufu/kodomo/kodomo/jidoteate.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Residents and Welfare Section of a Regional City Office (child allowance)',N'Check the official guidance for the application method, public-employee filing office, and documents.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/kodomokyufu/kodomo/kodomo/jidoteate.html' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'출입국재류관리청 재류절차 안내',N'신청서·필요서류·접수처는 절차별 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.moj.go.jp/isa/applications/procedures/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Immigration Services Agency immigration-procedure guidance',N'Check the official procedure-specific guidance for forms, documents, and filing locations.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.moj.go.jp/isa/applications/procedures/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'미나토구 외국인 상담 창구',N'전화·창구 상담 방법·운영시간·지원 언어는 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/easyjp/en/consultation/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Minato City consultation desk for foreign residents',N'Check the official guidance for phone or counter access, hours, and supported languages.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/easyjp/en/consultation/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'ko',N'미나토구 방재·대피 정보 안내',N'대피소·방재 앱·긴급 대응 정보는 미나토구 공식 안내에서 확인합니다.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/easyjp/accidentanddisaster/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='ko');
INSERT INTO JL_OFFICE_I18N (office_id, language_code, name, note)
SELECT o.id,'en',N'Minato City disaster-prevention and evacuation information',N'Check the official Minato City guidance for shelters, the disaster app, and emergency response.' FROM JL_OFFICE o WHERE o.homepage_url='https://www.city.minato.tokyo.jp/easyjp/accidentanddisaster/' AND NOT EXISTS (SELECT 1 FROM JL_OFFICE_I18N i WHERE i.office_id=o.id AND i.language_code='en');

-- 기존 절차-창구 연결을 삭제하지 않고, 공식 기관으로 교체합니다.
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/kikaku/kaikaku/mainanba/tutikado.html') WHERE procedure_id=11;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/conveniencestore.html') WHERE procedure_id=12;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/gomigenryou/kurashi/gomi/kate/bunbetsu/') WHERE procedure_id=13;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/chiikihoken/kenko/ninshin/ninshin/ninshin.html') WHERE procedure_id=14;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/kyufu/20181019.html') WHERE procedure_id=15;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/kodomokyufu/kodomo/kodomo/jidoteate.html') WHERE procedure_id=16;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.moj.go.jp/isa/applications/procedures/') WHERE procedure_id=17;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/easyjp/en/consultation/') WHERE procedure_id=18;
UPDATE JL_PROC_OFFICE SET office_id=(SELECT id FROM JL_OFFICE WHERE homepage_url='https://www.city.minato.tokyo.jp/easyjp/accidentanddisaster/') WHERE procedure_id=19;

COMMIT;
