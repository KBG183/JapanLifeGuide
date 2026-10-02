-- 18: 생활행정 절차 9~19 문서 조건 문구의 한국어·영어 보완
-- JL_DOCUMENT_I18N 행이 있으면 조건만 갱신합니다. 삭제·초기화는 하지 않습니다.

UPDATE JL_DOCUMENT_I18N SET condition_text=N'외국인 주민이 미나토구 안에서 이사하는 경우입니다. 창구에서 절차를 진행하는 사람에게 본인확인서류가 필요합니다.' WHERE document_id=1000 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'For foreign residents moving within Minato City. Identification is required for the person filing at the counter.' WHERE document_id=1000 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'가지고 있는 사람에게만 필요합니다.' WHERE document_id=1001 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Only for people who have one.' WHERE document_id=1001 AND language_code='en';

UPDATE JL_DOCUMENT_I18N SET condition_text=N'창구 또는 우편으로 전출 신고를 제출하는 경우입니다.' WHERE document_id=1002 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'When filing the moving-out notification at a counter or by mail.' WHERE document_id=1002 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'신청자의 본인확인에 사용합니다.' WHERE document_id=1003 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Used to confirm the applicant’s identity.' WHERE document_id=1003 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'가지고 있는 사람에게만 필요하며, 해외 전출에서는 확인이 필요합니다.' WHERE document_id=1004 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Only for people who have one; it must be checked for an overseas move.' WHERE document_id=1004 AND language_code='en';

UPDATE JL_DOCUMENT_I18N SET condition_text=N'신청 방법에 따라 필요합니다.' WHERE document_id=22 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required depending on the application method.' WHERE document_id=22 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'체류기간과 관련된 갱신 때 필요합니다.' WHERE document_id=23 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required for a renewal related to the period of stay.' WHERE document_id=23 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'미나토구 주민등록이 있고 대상 증명서를 발급받을 수 있는 사람에게 필요합니다.' WHERE document_id=24 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required for eligible Minato residents obtaining an available certificate.' WHERE document_id=24 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'전자증명서 등을 사용하는 경우 필요합니다.' WHERE document_id=25 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required when using the electronic certificate or similar service.' WHERE document_id=25 AND language_code='en';

UPDATE JL_DOCUMENT_I18N SET condition_text=N'항상 필요합니다. 분리 방법과 수거일은 지역에 따라 확인합니다.' WHERE document_id=26 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Always required as a reference; sorting and collection days depend on the area.' WHERE document_id=26 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'건물별 배출 장소를 확인할 때 필요합니다.' WHERE document_id=27 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Needed to identify the collection place for your building.' WHERE document_id=27 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'임신 진단 후 임신 신고를 할 때 필요합니다.' WHERE document_id=28 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required when filing the pregnancy notification after a pregnancy diagnosis.' WHERE document_id=28 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'임신 신고 후 교부받습니다.' WHERE document_id=29 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Issued after the pregnancy notification.' WHERE document_id=29 AND language_code='en';

UPDATE JL_DOCUMENT_I18N SET condition_text=N'지원 제도별로 필요한 서류가 다릅니다.' WHERE document_id=30 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required documents differ by support program.' WHERE document_id=30 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'출산육아일시금 신청 시 확인될 수 있습니다.' WHERE document_id=31 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'May be checked when applying for the childbirth lump-sum allowance.' WHERE document_id=31 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'신청서 제출 시 항상 필요합니다.' WHERE document_id=32 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required when submitting the application.' WHERE document_id=32 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'신청 방법과 대상에 따라 필요합니다.' WHERE document_id=33 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Required depending on the application method and circumstances.' WHERE document_id=33 AND language_code='en';

UPDATE JL_DOCUMENT_I18N SET condition_text=N'중장기 체류자에게 해당합니다.' WHERE document_id=34 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Applies to mid- and long-term residents.' WHERE document_id=34 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'신청하는 체류 절차와 개인 상황에 따라 다릅니다.' WHERE document_id=35 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Depends on the immigration procedure and individual circumstances.' WHERE document_id=35 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'상담 내용에 따라 준비할 수 있습니다.' WHERE document_id=36 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'May be prepared depending on the consultation topic.' WHERE document_id=36 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'상담기관에 따라 필요할 수 있습니다.' WHERE document_id=37 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'May be required depending on the consultation service.' WHERE document_id=37 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'항상 확인해야 하는 방재·대피 정보입니다.' WHERE document_id=38 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Information that should always be checked for disaster preparedness and evacuation.' WHERE document_id=38 AND language_code='en';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'가족과 함께 긴급 연락처를 확인할 때 필요합니다.' WHERE document_id=39 AND language_code='ko';
UPDATE JL_DOCUMENT_I18N SET condition_text=N'Used to review emergency contacts with your household.' WHERE document_id=39 AND language_code='en';

COMMIT;
