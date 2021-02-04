# Deuqoo(진행중)
드라마를 좋아하는 사람들이 활동할 수 있는 온라인 익명 커뮤니티(only Web)
```
```
```
```
### 1. 초기 화면 설계
* [Kakao Oven](https://ovenapp.io/project/3AI9X293pfm4aMLmUVGdfTZVDUTwBfMt#5jRDR, "화면설계주소")
```
```
```
```
### 2. Tech stack & Open-source libraries
* Tool : Eclipse Photon (4.8)
* Spring Tool Suite4 v.4.7.1 (Spring legacy)
* DataBase : Oracle Database 11g Express Edition
```
```
```
```
### 3. 화면 구성
```
```
#### 1) 메인 화면
![메인 페이지](https://user-images.githubusercontent.com/78471888/106889693-b9990500-672b-11eb-8d5f-07460cf42447.png)
* 헤더
  * 로그인(SNS 로그인)
  * 회원가입
  * 카테고리
    * jQuery를 활용한 슬라이드 드롭다운 기능 有
    * 스크롤을 카테고리 영역 밑으로 내릴 경우 화면 상단에 고정시켜 카테고리의 접근성을 )
* 본문: 게시판의 글 미리보기 / 방영중인 드라마 포스터 (jQuery를 활용한 슬라이드 기능)
* 푸터: 공지사항 게시글 미리보기 (newticker 형식)
```
```
#### 2) 로그인 화면
![로그인 화면](https://user-images.githubusercontent.com/78471888/106890821-37114500-672d-11eb-832a-8943ecdbfafd.png)
![소셜 로그인 페이지](https://user-images.githubusercontent.com/78471888/106891035-848db200-672d-11eb-9c0c-5726fc33f235.png)
* 이메일, 비밀번호를 통한 로그인가능
* 로그인 후 닉네임 출력, 로그아웃, 마이페이지로 화면 전환 가능
* Naver, Kakao API를 활용하여 SNS 로그인 구현
```
```
#### 3) 회원가입 화면
![회원가입 페이지](https://user-images.githubusercontent.com/78471888/106892230-1d70fd00-672f-11eb-8f7b-13170b11a983.png)
* 회원가입 시 Spring-Security를 활용한 비밀번호 암호화 처리
* 유효성 검사를 통한 회원 가입 폼 생성
* 회원가입 완료 후, 해당 아이디(이메일)로 인증 메일 전송
* 해당 링크를 클릭(인증 토큰 DB 저장)한 후에 로그인이 가능
```
```
#### 4) 불판 관련 페이지
드라마 본방을 달리는 회원들간의 채팅이 이루어질 수 있는 페이지
```
```
#### ① 불판 목록
![불판 페이지](https://user-images.githubusercontent.com/78471888/106892522-88bacf00-672f-11eb-9768-6aaeabe55338.png)
![불판 말머리 검색 페이지](https://user-images.githubusercontent.com/78471888/106892371-5315e600-672f-11eb-9a8e-05752b0198db.png)
* 로그인 후에 채팅방 개설 가능(로그인 후에만 글쓰기 버튼이 보임)
* 한드, 미드, 영드, 일드, 중드, 기타 기준으로 게시글 분류
* 해당 게시글 클릭 시 채팅창으로 연결
* 다른 게시판과 달리 채팅방 제목만 검색 기능
* 다른 게시판과 달리 목록 페이지에서 글 수정/삭제가 
* 밀머리 검색 기능 → 말머리(드라마 이름)를 클릭하면 해당 드라마의 채팅방만 출력
* 페이징 처리
```
```
#### ② 채팅방 개설(불판 글쓰기) 페이지
![불판 글쓰기 페이지](https://user-images.githubusercontent.com/78471888/106893112-69707180-6730-11eb-8906-517f1033eaea.png)
* 다른 게시판과 달리 제목과 말머리, 드라마 분류(한드, 미드, ...)만 입력받음
```
```
#### ③ 채팅방
![불판 채팅 페이지](https://user-images.githubusercontent.com/78471888/106893551-10eda400-6731-11eb-8818-00d4f4f6e0e2.png)
* Websocket 라이브러리 + Stomp 프로토콜을 활용하여 실시간 채팅 서비스 지원
* 다대일 채팅 
```
```
#### 5) 드라마 리뷰 페이지
드라마를 감상한 회원들이 후기글을 작성할 수 있는 페이지
```
```
#### ① 드라마 리뷰 목록 페이지
* 화면 구성과 게시글 분류, 말머리 검색 기능, 페이징 처리는 불판 목록 페이지와 동일
* 게시글 제목 및 내용 검색 기능
* 게시글 클릭 시 글 상세 페이지로 연결
```
```
#### ② 리뷰 글쓰기 페이지
![리뷰 글쓰기 페이지](https://user-images.githubusercontent.com/78471888/106894550-77bf8d00-6732-11eb-9572-58f9e9c22c19.png)
* 말머리, 드라마 분류, 제목, 내용을 입력 받음
* Naver Smart Editor Tool을 삽입하여 사용자가 글 작성을 보다 편리하게 할 수 있도록 함
* 특히, 위와 같이 이미지를 업로드 하면 내용을 입력받는 폼에 바로 확인할 수 있게끔 함
```
```
#### ③ 리뷰 글 상세 페이지

