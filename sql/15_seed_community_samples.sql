-- 15: 커뮤니티 6개 게시판별 샘플 게시글 3개씩, 총 18개
-- 사용자가 마지막으로 보낸 이미지를 모든 샘플 게시글에 연결합니다.
-- 기존 데이터는 삭제하지 않습니다. 같은 작성자의 같은 제목은 다시 만들지 않습니다.
-- 이미지 파일: community-uploads/sample-last-user-image.png
-- 작성자 계정: klad312
DECLARE
  v_member_id NUMBER;
  v_post_id NUMBER;
  v_count NUMBER;
  v_file_size NUMBER := 32131;

  PROCEDURE seed_post(
    p_category VARCHAR2,
    p_title NVARCHAR2,
    p_body NCLOB
  ) IS
  BEGIN
    BEGIN
      SELECT id INTO v_post_id
        FROM JL_COMMUNITY_POST
       WHERE member_id = v_member_id
         AND title = p_title
         AND ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        SELECT JL_COMMUNITY_POST_SEQ.NEXTVAL INTO v_post_id FROM DUAL;
        INSERT INTO JL_COMMUNITY_POST
          (id, member_id, category, title, body, status, created_at, updated_at)
        VALUES
          (v_post_id, v_member_id, p_category, p_title, p_body,
           'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    END;

    SELECT COUNT(*) INTO v_count
      FROM JL_COMMUNITY_IMAGE
     WHERE post_id = v_post_id
       AND stored_name = 'sample-last-user-image.png';

    IF v_count = 0 THEN
      INSERT INTO JL_COMMUNITY_IMAGE
        (id, post_id, original_name, stored_name, content_type,
         file_size, display_order, created_at)
      VALUES
        (JL_COMMUNITY_IMAGE_SEQ.NEXTVAL, v_post_id,
         N'사용자가 보낸 샘플 이미지.png',
         'sample-last-user-image.png', 'image/png',
         v_file_size, 1, CURRENT_TIMESTAMP);
    END IF;
  END;
BEGIN
  BEGIN
    SELECT id INTO v_member_id
      FROM JL_MEMBER
     WHERE login_id = 'klad312'
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('klad312 회원을 찾지 못해 샘플 게시글을 만들지 않았습니다.');
      RETURN;
  END;

  -- ADMIN: 행정 질문
  seed_post('ADMIN', N'[샘플] 미나토구 생활행정 안내를 커뮤니티에서 확인해 보세요', N'행정절차와 실제 생활 경험을 함께 확인하는 샘플 게시글입니다.');
  seed_post('ADMIN', N'[샘플][행정] 전입신고 전에 준비할 서류가 궁금합니다', N'전입신고와 재류카드 관련 준비사항을 질문하는 샘플 게시글입니다.');
  seed_post('ADMIN', N'[샘플][행정] 구청 방문 전에 확인할 사항을 알려 주세요', N'미나토구 행정 창구 방문 전 확인할 내용을 테스트하는 샘플 게시글입니다.');

  -- HOME: 집·계약·생활
  seed_post('HOME', N'[샘플] 일본 생활 관련 질문을 자유롭게 남겨 주세요', N'집 계약, 전입신고, 생활 준비와 관련된 질문을 올리는 샘플 게시글입니다.');
  seed_post('HOME', N'[샘플][생활] 일본에서 집을 구할 때 확인할 점', N'보증금, 계약기간, 관리비 등 주거 정보를 나누는 샘플 게시글입니다.');
  seed_post('HOME', N'[샘플][생활] 생활용품을 구하기 좋은 장소가 있나요', N'미나토구 주변 생활용품 구매 정보를 테스트하는 샘플 게시글입니다.');

  -- STUDENT: 유학생 생활
  seed_post('STUDENT', N'[샘플][유학생] 유학생활 중 필요한 행정절차', N'학교생활과 일본 생활을 함께 준비하는 유학생용 샘플 게시글입니다.');
  seed_post('STUDENT', N'[샘플][유학생] 미나토구에서 공부하기 좋은 장소', N'도서관과 조용한 공부 장소 정보를 공유하는 샘플 게시글입니다.');
  seed_post('STUDENT', N'[샘플][유학생] 일본어가 서툴 때 이용할 수 있는 안내', N'다국어 안내와 생활 도움을 확인하는 샘플 게시글입니다.');

  -- WORK: 취업·직장
  seed_post('WORK', N'[샘플][취업] 일본에서 취업을 시작할 때 준비할 것', N'취업 후 필요한 신고와 생활 준비를 확인하는 샘플 게시글입니다.');
  seed_post('WORK', N'[샘플][취업] 직장 근처 생활정보를 공유해 주세요', N'출퇴근, 점심, 생활 편의시설 정보를 나누는 샘플 게시글입니다.');
  seed_post('WORK', N'[샘플][취업] 근무 시작 후 필요한 절차 질문', N'회사에 입사한 뒤 확인할 행정절차를 질문하는 샘플 게시글입니다.');

  -- MEETUP: 같이 밥·동네 모임
  seed_post('MEETUP', N'[샘플] 유학생·취업자 생활 경험을 나누는 글', N'같은 지역에서 생활하는 사람들이 정보를 나누는 샘플 게시글입니다.');
  seed_post('MEETUP', N'[샘플][모임] 주말에 같이 밥 먹을 분을 찾아요', N'미나토구 주변 식사 모임 기능을 테스트하는 샘플 게시글입니다.');
  seed_post('MEETUP', N'[샘플][모임] 일본 생활 첫 달 경험을 공유합니다', N'새로 이사 온 사람들의 생활 경험을 나누는 샘플 게시글입니다.');

  -- GENERAL: 일반 생활
  seed_post('GENERAL', N'[샘플][일반] 일본 생활을 시작하며 알게 된 점', N'일본 생활 전반의 경험을 공유하는 샘플 게시글입니다.');
  seed_post('GENERAL', N'[샘플][일반] 미나토구에서 자주 이용하는 장소', N'주민들이 이용하는 장소와 생활 팁을 나누는 샘플 게시글입니다.');
  seed_post('GENERAL', N'[샘플][일반] 커뮤니티 이용 테스트 글입니다', N'게시글 목록과 상세 화면을 확인하기 위한 샘플 게시글입니다.');
END;
/
COMMIT;

SELECT p.category, COUNT(*) AS sample_count
  FROM JL_COMMUNITY_POST p
 WHERE p.member_id = (SELECT id FROM JL_MEMBER WHERE login_id = 'klad312' AND ROWNUM = 1)
   AND p.title LIKE N'[샘플]%'
 GROUP BY p.category
 ORDER BY p.category;
