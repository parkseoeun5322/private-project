# 대여안대여(Project_D)
개인 간 물품 대여를 중개하는 어플리케이션/웹 사이트


## Tech stack & Open-source libraries
* Tool : Eclipse Photon (4.8)
* Android Studio (3.5.5)
* Spring Tool Suite3 v.3.9.11
* DataBase : Oracle Database 11g Express Edition

## DB
![0 웹_DB](https://user-images.githubusercontent.com/78471888/106755655-b3465280-6671-11eb-97f5-5f1139c623ee.png)

## App

### 1. App 담당 파트
* ***로그인***(LoginActivity.java)
* ***SNS 로그인***(카카오 - GlobalApplication.java / SessionCallback.java)
* ***회원가입***(SignUpFormActivity.java) - 이메일 보내기(GMailSender.java / JSSEProvider.java)
* ***위치 찾기 화면***(LocationActivity.java / SocialLocationActivity.java / GpsTracker.java) 
* ***아이디/비밀번호 찾기 화면***(SearchIDActivity.java / IdFragment.java / PwFragment.java)


#### 1) 로그인

![1 로그인 화면](https://user-images.githubusercontent.com/78471888/106757777-1cc76080-6674-11eb-8805-238930fa6146.png)
* 이메일 형식의 아이디 사용 
* 네이버, 카카오 API를 활용한 SNS 로그인 및 회원정보 저장 구현


#### 2) 회원가입
![2 회원가입 화면](https://user-images.githubusercontent.com/78471888/106758117-7af44380-6674-11eb-895d-da21dd8761eb.png)
인증하기 버튼 클릭 시 해당 아이디(이메일)로 인증번호 메일 발송 
→ 정해진 시간 내(5분)에 인증 다이얼로그에 인증번호를 입력하면 이메일 인증 완료


#### 3) 위치 찾기 화면
![3 위치 찾기 화면](https://user-images.githubusercontent.com/78471888/106758292-b131c300-6674-11eb-939e-551255a4d22c.png)![6 메인 화면](https://user-images.githubusercontent.com/78471888/106758326-bbec5800-6674-11eb-8968-6da7a83db268.png)![7 마이 페이지 화면](https://user-images.githubusercontent.com/78471888/106758366-c4dd2980-6674-11eb-97d3-82577a33ad70.png)






