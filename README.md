# 대여안대여(Project_D)
개인 간 물품 대여를 중개하는 어플리케이션/웹 사이트
```
```
## Tech stack & Open-source libraries
* Tool : Eclipse Photon (4.8)
* Android Studio (3.5.5)
* Spring Tool Suite3 v.3.9.11
* DataBase : Oracle Database 11g Express Edition
```
```
## DB
![0 웹_DB](https://user-images.githubusercontent.com/78471888/106755655-b3465280-6671-11eb-97f5-5f1139c623ee.png)
```
```
## App
```
```
### 1. App 담당 파트
* ***로그인***(LoginActivity.java)
* ***SNS 로그인(네이버/)***(카카오 - GlobalApplication.java / SessionCallback.java)
* ***회원가입***(SignUpFormActivity.java) - 이메일 보내기(GMailSender.java / JSSEProvider.java)
* ***위치 기반 서비스***(LocationActivity.java / SocialLocationActivity.java / GpsTracker.java) 
* ***아이디/비밀번호 찾기***(SearchIDActivity.java / IdFragment.java / PwFragment.java)
```
```
#### 1) 로그인
```
```
![1 로그인 화면](https://user-images.githubusercontent.com/78471888/106757777-1cc76080-6674-11eb-8805-238930fa6146.png)
* 이메일 형식의 아이디 사용 
* 네이버, 카카오 API를 활용한 SNS 로그인 및 회원정보 저장 구현
```
```
#### 2) 회원가입
![2 회원가입 화면](https://user-images.githubusercontent.com/78471888/106758117-7af44380-6674-11eb-895d-da21dd8761eb.png)
* 인증하기 버튼 클릭 시 해당 아이디(이메일)로 인증번호 메일 발송 
* 정해진 시간 내(5분)에 인증 다이얼로그에 인증번호를 입력하면 이메일 인증 완료
```
```
#### 3) 위치 찾기 화면
![3 위치 찾기 화면](https://user-images.githubusercontent.com/78471888/106758292-b131c300-6674-11eb-939e-551255a4d22c.png)![6 메인 화면](https://user-images.githubusercontent.com/78471888/106758326-bbec5800-6674-11eb-8968-6da7a83db268.png)![7 마이 페이지 화면](https://user-images.githubusercontent.com/78471888/106758366-c4dd2980-6674-11eb-97d3-82577a33ad70.png)
* Google Map APT를 활용하여 사용자의 위치 정보 출력 및 DB에 저장
* 메인 페이지 및 마이 페이지의 gps 버튼 클릭 시 위치 재설정 가능 & 위치 정보 DB 업데이트
```
```
#### 4) 아이디/비밀번호 찾기 화면
![4 아이디 찾기 화면](https://user-images.githubusercontent.com/78471888/106759719-6ca72700-6676-11eb-9d4f-2549181aa040.png)![5 비밀번호 찾기 화면](https://user-images.githubusercontent.com/78471888/106759748-73ce3500-6676-11eb-89de-a3670cd55a4f.png)
* 탭 형식 UI를 활용하여 아이디/비밀번호 찾기 화면 구현
* 핸드폰 번호를 입력 받고 회원 DB 조회 후, 인증번호 발송
* 인증번호 입력 후, 아이디의 일부분을 다이얼로그에 띄움 
* 아이디(이메일 주소)를 통해 인증번호를 발송하여 비밀번호 재설정 & DB 업데이트

___

## Web
```
```
### 1. Web 담당 파트
* 로그인
* SNS 로그인(네이버/카카오)
* 회원가입 
* 아이디/비밀번호 찾기
* Google Map API
```
```
#### 1) 로그인
![1 로그인](https://user-images.githubusercontent.com/78471888/106760753-767d5a00-6677-11eb-8e8f-0ed14deb6e4b.png)
* 이메일, 비밀번호를 통한 로그인가능
* 로그인 후 닉네임 출력, 로그아웃, 마이페이지로 화면 전환 가능
* Naver, Kakao API를 활용하여 SNS 로그인 구현
```
```
#### 2) 회원가입
![2 회원가입(유효성)](https://user-images.githubusercontent.com/78471888/106761071-ce1bc580-6677-11eb-8126-906a2c26aeff.png)
* 회원가입 시 Spring-Security를 활용한 비밀번호 암호화 처리
* 유효성 검사를 통한 회원 가입 폼 생성
* 회원가입 완료 후, 해당 아이디(이메일)로 인증 메일 전송
* 해당 링크를 클릭(인증 토큰 DB 저장)한 후에 로그인이 가능
```
```
#### 3) 아이디/비밀번호 찾기
![5 아이디 찾기 화면](https://user-images.githubusercontent.com/78471888/106761538-43879600-6678-11eb-9879-f377f974412f.png)
* 이름과 핸드폰 번호 입력 후, DB에 저장된 회원 정보와 일치할 경우 아이디(이메일)의 일부를 화면에 출력
```
```
![6 비밀번호 찾기 화면](https://user-images.githubusercontent.com/78471888/106761676-6c0f9000-6678-11eb-8be0-dced9719d09b.png)
* 이름과 아이디(이메일) 입력 후, DB에 저장된 회원 정보와 일치할 경우 비밀번호 재설정 메일 발송
```
```
![3 비밀번호 재설정 메일](https://user-images.githubusercontent.com/78471888/106761467-310d5c80-6678-11eb-8f51-3fc3423248c8.png)
![4 비밀번호 재설정](https://user-images.githubusercontent.com/78471888/106761902-9f521f00-6678-11eb-85e9-b2236ac84af5.png)
* 사용자에게 재설정할 비밀번호를 입력 받은 후 DB 업데이트```
```
```
#### 4) 상세 페이지안의 google map
![7 상세페이지1](https://user-images.githubusercontent.com/78471888/106762149-e6d8ab00-6678-11eb-8ad6-aaf371574a41.png)
* 주소 부분을 클릭하면 해당 주소 반경을 google map을 통해 띄움













