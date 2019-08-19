# Lottori - 스마트 로또 번호 발생기
최신 로또 정보를 확인하고 조회할 수 있는 앱. <br>
최근 15주간 미출현 번호, 자주 출현한 번호 등을 추출하는 알고리즘을 적용해 사용자에게 스마트 정보 제공
* 기간 : 2019.06 ~ 현재
* 소속 : 개인프로젝트
* 역할 : iOS 앱개발 및 배포
* 사용기술 : Swift5, AVFoundation(QR코드 인식을 위한 카메라), 오픈API
### 설계 (마인드맵)
<a href="/assets/LottoriDesign.pdf" target="_blank"><img src="/assets/LottoriDesign.png"></a>

### 스크린샷

<a href="/assets/mainPage.gif" target="_blank"><img src="/assets/mainPage.gif" alt="My Image" width="250"></a>
<a href="/assets/selectPage.gif" target="_blank"><img src="/assets/selectPage.gif" alt="My Image" width="250"></a>
<a href="/assets/randomPage.gif" target="_blank"><img src="/assets/randomPage.gif" alt="My Image" width="250"></a>

### 데모영상
<a href="https://www.youtube.com/watch?v=TYDtgXENrI4" target="_blank"><img src="/assets/LottoriThumnail.png"></a>

<br>

### 문제해결 아카이브
  * QR코드를 어떻게 인식하게 할까?
    * AVFoundation을 사용해서 카메라에 접근해서 QR코드를 읽을 수 있었다.
  * 역대 로또 번호를 비교 분석해서 역대 당첨 횟수와 금액을 조회하는 알고리즘이 필요하다.
    * 고차함수와 반복문의 enumerated() 를 활용해서 알고리즘을 구현할 수 있었다.
