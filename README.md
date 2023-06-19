# 집에서 밥 먹장!
'집에서 밥 먹장!'(이하 '먹장')은 1인가구를 위한 식료품 재고 관리 및 로컬 기반 공유 플랫폼입니다. '먹장'은 크게 다음과 같은 두 가지 주요 기능을 통해 1인가구에게 식재료 관리 및 활용의 편의성을 제공합니다.  

**1. 식료품 재고 관리 서비스**
  - 가지고 있는 식료품을 등록하여 언제 어디서나 손쉽게 재고 파악 및 관리가 가능합니다.
  - 영수증 또는 온라인 장보기 서비스 구매 내역 사진을 업로드하면, OCR 기술을 통해 사진 속 텍스트를 인식하여 한 번에 여러 식료품을 등록할 수 있습니다.
  - 소비기한이 임박한 식료품에 대해 푸시알림을 드립니다.
  
**2. 로컬 기반 식료품 공유 서비스**
  - 반경 1km 내 식료품 나눔/교환/공동구매 게시글을 조회하거나 직접 등록할 수 있습니다.
  - 채팅으로 상세 거래 내용을 결정하고 거래를 진행합니다.
  - 거래 후기 시스템으로 신뢰성 있는 거래 문화를 만듭니다.

<br/>

## BrainStorm Frontend Member
|이름|기여 분야|연락처|
|:---:|---|:---:|
|이미림|식료품 직접/스마트 등록, 채팅|uraflower@ajou.ac.kr|
|이중원|회원가입 및 로그인, 게시글 등록, 상세 게시글 |wnddnjs823@ajou.ac.kr|
|조민주|식료품 조회 및 수정, 거래 목록/지도뷰, 마이페이지|pida6716@ajou.ac.kr|

<br/>

## 🛠 Skills
<img src="https://img.shields.io/badge/flutter-02569B?style=flat&logo=flutter&logoColor=white"> <img src="https://img.shields.io/badge/dart-0175C2?style=flat&logo=Dart&logoColor=white"/> <img src="https://img.shields.io/badge/firebase-FFCA28?style=flat&logo=firebase&logoColor=white"> <img src="https://img.shields.io/badge/github-181717?style=flat&logo=github&logoColor=white">

<br/>

## 사용 프레임워크

|Framework |Ver.|Description|
|------|---|---|
|step_progress_indicator|1.0.2|bar indicator made of a series of selected and unselected steps.|
|path_provider|2.0.15|find commonly used locations on the filesystem|
|cupertino_icons|1.0.2|asset repo containing the default set of icon assets|
|introduction_screen|3.1.7|Introduction Screen allows to have a screen on an app's first launch|
|google_fonts|4.0.3|use fonts from google|
|flutter_native_splash|2.2.19|customize this native splash screen background color and splash image|
|kpostal|0.5.1|search for Korean postal addresses using Kakao postcode service.|
|dio|5.1.2|A powerful HTTP client for Dart/Flutter|
|url_launcher|6.1.10|launching a URL|
|webview_flutter|4.2.0|provide a WebView widget|
|firebase_core|2.13.0|use the Firebase Core API|
|firebase_auth|4.6.1|use the Firebase Authentication API|
|logger|1.3.0|use and extensible logger which prints beautiful logs|
|image_picker|0.8.7+4|pick images from the image library|
|image_cropper|3.0.3|supports cropping images|
|http|0.13.6|Future-based library for making HTTP requests|
|shared_preferences|2.1.1|wrap platform-specific persistent storage for simple data|
|percent_indicator|4.2.3|make circular and Linear percent indicators|
|web_socket_channel|2.4.0|provides StreamChannel wrappers for WebSocket connections|
|fluttertoast|8.2.2|make two kinds of toast messages one which requires BuildContext other with No BuildContext|

<br/>

## 주요 디렉토리 구조
```bash
lib
├─models
├─pages
│  ├─chat
│  ├─deal
│  │  ├─detail
│  │  └─register
│  ├─home
│  ├─profile
│  └─start
├─providers
├─utilities
└─widgets
    ├─deal_detail
    ├─enter_chat
    ├─food
    ├─go_to_post
    └─register_post
``` 

- `lib/models`는 다음 기능에 관한 모델을 포함합니다: `사용자`, `식료품`, `거래 게시글`, `채팅`.
- `lib/pages`는 프로젝트의 각 화면들을 모아놓은 곳입니다.
- `lib/pages/chat`는 채팅 기능을 위한 화면을 모아놓은 곳입니다.
- `lib/pages/deal`는 식료품 공유 시스템을 위한 화면을 모아놓은 곳입니다.
- `lib/pages/home`는 식료품 재고 관리를 위한 화면을 모아놓은 곳입니다.
- `lib/pages/profile`는 사용자 정보 조회 및 관리를 위한 화면을 모아놓은 곳입니다.
- `lib/pages/start`는 회원가입 및 로그인을 위한 화면을 모아놓은 곳입니다.
- `lib/providers`에서 푸시 알림, 음식 거래 게시물 상태관리에 필요한 상태 관리를 합니다.
- `lib/utilities`는 개발에 필요한 유틸리티성 파일들을 모아놓은 곳입니다.
- `lib/widgets`는 재사용되는 위젯들을 모아놓은 곳입니다.

<br/>

## [코딩 컨벤션](https://github.com/BrainStorm-sc21/BrainStorm-FE/wiki/Convention)


