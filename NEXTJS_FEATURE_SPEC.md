# Just Make Logo - Next.js 마이그레이션 전체 기능 명세서

## 1. 앱 레이아웃 & 반응형

### 전체 구조
- **데스크톱** (700px 이상): 좌측 프리뷰 (3) + 우측 컨트롤 패널 (1) 비율
- **모바일** (700px 미만): 상단 프리뷰 (3) + 하단 컨트롤 패널 (2) 세로 스택
- 상단 AppBar: 앱 로고, 타이틀, 다크모드 토글 버튼

### 테마
- 라이트/다크 모드 전환
- 테마 설정 로컬 저장 (localStorage)
- 일관된 디자인 토큰 (primary, foreground, muted, border, shadow, radius 등)

---

## 2. 로고 모드 (4가지)

| 모드 | 설명 |
|------|------|
| **Text Only** | 텍스트만으로 로고 생성 |
| **Image Only** | 이미지만으로 로고 생성 |
| **Text + Image** | 텍스트와 이미지 조합 |
| **SVG Only** | SVG 파일 업로드 후 배경 래핑 |

- 모드 전환은 Chip 버튼 UI로 선택
- 모드에 따라 관련 컨트롤 섹션이 조건부 표시/숨김

---

## 3. 텍스트 설정

### 3-1. 폰트 선택
- Google Fonts 39종 지원:
  - Workbench, Jersey 20, Noto Serif, Bebas Neue, Pacifico, Lobster, Raleway, Permanent Marker, Black Han Sans, Noto Sans KR, Montserrat, Poppins, Inter, Space Grotesk, Rubik, Outfit, Oswald, Anton, Righteous, Russo One, Orbitron, Audiowide, Bungee, Fredoka, Lexend, Nunito, Quicksand, Comfortaa, Rajdhani, Chakra Petch, Michroma, Teko, Electrolize, Exo 2, Megrim, Poiret One, Gruppo, Syncopate, Zen Dots
- 드롭다운 선택 UI
- "Install Font" 링크 → Google Fonts 페이지 오픈

### 3-2. 폰트 두께 (Weight)
- 9단계: 100(Thin), 200(ExtraLight), 300(Light), 400(Regular), 500(Medium), 600(SemiBold), 700(Bold), 800(ExtraBold), 900(Black)
- 폰트별 지원 두께만 선택 가능
- 폰트 변경 시 현재 두께가 미지원이면 첫 번째 지원 두께로 자동 전환

### 3-3. 텍스트 입력
- 멀티라인 지원: 1줄 / 2줄 / 3줄
- 각 줄 별도 입력 필드
- 빈 줄은 기본 placeholder 텍스트 사용

### 3-4. 텍스트 스타일링
- 텍스트 색상: 커스텀 컬러 피커
- 텍스트 패딩: 0~90% (5% 단위 슬라이더)
- FittedBox로 가용 공간에 자동 스케일링

---

## 4. 이미지 설정

### 4-1. 이미지 업로드
- 파일 피커로 이미지 선택
- 썸네일 미리보기 표시
- 이미지 변경/교체 버튼
- 이미지 제거 버튼

### 4-2. 이미지 레이아웃 (Text+Image 모드)
- **위치**: Top / Bottom / Left / Right
- **비율**: 10~90% (16단계) - 이미지와 텍스트 공간 비율 조절
- **간격(Gap)**: 0~50px (50단계) - 이미지와 텍스트 사이 간격
- **Fit 모드**: Contain / Cover / Fill

---

## 5. SVG 설정

### 5-1. SVG 업로드
- `.svg` 파일 업로드
- SVG 미리보기 표시
- SVG 변경/교체 버튼
- SVG 제거 버튼

### 5-2. SVG 내보내기 특수 처리
- 업로드된 SVG를 배경 + 패딩 + 클리핑으로 래핑하여 새 SVG로 내보내기
- 원형/둥근 사각형 클리핑 지원

---

## 6. 배경 설정

### 6-1. 배경 형태
- **사각형** (Rectangle) - 기본값
- **원형** (Circle) - oval 클리핑

### 6-2. 단색 배경
- 6개 퀵 프리셋 컬러: 흰색, 검정, 빨강, 파랑, 노랑, 초록
- 커스텀 컬러 피커 (bar 타입)
- 투명 배경 옵션 (체커보드 패턴으로 표시)

### 6-3. 그라디언트 배경 (현재 구현됨)
- 그라디언트 ON/OFF 토글
- 시작 색상 + 끝 색상 선택
- **그라디언트 타입**: Linear / Radial
- **Linear 방향 8가지**:
  - Top → Bottom
  - Bottom → Top
  - Left → Right
  - Right → Left
  - TopLeft → BottomRight (기본값)
  - TopRight → BottomLeft
  - BottomLeft → TopRight
  - BottomRight → TopLeft
- **프리셋 그라디언트 10종**: Sunset, Ocean, Mint, Peach, Night, Berry, Fire, Sky, Lime, Royal
- 프리셋 클릭 시 시작/끝 색상 즉시 적용

### 6-4. 고급 그라디언트 — Screen Studio 스타일 (미구현 → Next.js에서 구현)

> Screen Studio의 세련된 배경 그라디언트를 참고한 고급 기능.
> Next.js에서는 CSS gradient, Canvas API, WebGL(mesh) 조합으로 모두 구현 가능.

#### A. 멀티 컬러 스톱 (Multi-color Stops)
- 2개 이상의 색상 지점 추가/삭제 (최소 2개 ~ 최대 10개)
- 각 스톱 포인트의 위치(%) 조절 (0~100%)
- **그라디언트 바 위에서 드래그**로 스톱 위치 이동
- 바 위 클릭으로 새 스톱 추가, 바 밖으로 드래그하면 삭제
- 각 스톱별 개별 컬러 피커
- 실시간 프리뷰 바 (설정된 그라디언트를 가로 바로 시각화)

#### B. 자유 각도 (Angle)
- 8방향 프리셋 버튼 유지 + **0~360도 자유 각도** 추가
- 원형 다이얼 UI (마우스 드래그로 각도 조절)
- 숫자 직접 입력 필드
- 다이얼과 입력 필드 양방향 동기화

#### C. 그라디언트 타입 확장
| 타입 | 설명 | CSS 대응 |
|------|------|----------|
| **Linear** | 직선 방향 그라디언트 | `linear-gradient()` |
| **Radial** | 원형/타원형 확산 | `radial-gradient()` |
| **Conic** | 원뿔형 (시계방향 회전) | `conic-gradient()` |
| **Mesh** | 프리폼 컬러 블롭 (Screen Studio 핵심) | Canvas/WebGL |

#### D. Radial 그라디언트 고급 옵션
- 중심점 (center) X/Y 좌표 조절 (0~100%) — 2D 드래그 포인트 UI
- 반경 (radius) 조절 슬라이더
- 초점 (focal point) 위치 조절
- 타원형 비율 (가로/세로 비) 조절
- Shape: circle / ellipse 전환

#### E. Conic 그라디언트
- 시작 각도 설정 (0~360도)
- 중심점 X/Y 좌표 조절 — 2D 드래그
- 멀티 컬러 스톱 지원
- 반복 (repeating-conic-gradient) 옵션

#### F. Mesh Gradient (Screen Studio 핵심 기능)
- **2D 캔버스 위에 컬러 포인트(블롭) 배치**
- 각 포인트: 색상 + X/Y 위치 + 확산 반경
- **드래그로 포인트 위치 이동** (실시간 프리뷰)
- 포인트 추가/삭제 (최소 2개 ~ 최대 8개)
- 각 포인트별 컬러 피커
- 포인트 간 부드러운 색상 블렌딩 (Gaussian blur 기반)
- **구현 방식**: Canvas 2D에 각 포인트를 큰 radial-gradient로 그린 뒤 블러 합성, 또는 WebGL shader
- Mesh 프리셋 제공 (Screen Studio 스타일의 미리 정의된 배치)

#### G. 노이즈/그레인 텍스처 오버레이
- **노이즈 텍스처 ON/OFF 토글**
- 노이즈 강도(opacity) 조절: 0~100% 슬라이더
- 노이즈 크기(scale/grain size) 조절: Fine / Medium / Coarse
- 노이즈 타입: Uniform / Gaussian / Film grain
- 노이즈 색상: Monochrome(기본) / Chromatic(컬러 노이즈)
- **구현 방식**: SVG `<feTurbulence>` 필터 또는 Canvas noise generation
- 그라디언트 위에 오버레이로 합성 → 디지털 느낌 줄이고 자연스러운 질감 추가

#### H. 블러/글로우 효과
- 배경 블러 (Backdrop blur) 강도 조절: 0~50px
- 그라디언트 위 글로우(발광) 포인트 추가
  - 글로우 색상, 위치(X/Y), 반경, 강도(opacity) 설정
  - 최대 5개 글로우 포인트
- Inner glow / Outer glow 전환

#### I. 그라디언트 블렌딩/이징
- 색상 전환 곡선: Linear / Ease-in / Ease-out / Ease-in-out / Custom bezier
- 각 스톱 구간별 개별 전환 방식 설정
- CSS `color-interpolation` 지원: sRGB / OKLab (더 자연스러운 색상 전환)

#### J. Repeating 그라디언트
- Repeating Linear / Radial / Conic
- 반복 간격(크기) 조절
- 스트라이프/패턴 효과 생성 가능

#### K. 그라디언트 프리셋 시스템
- **빌트인 프리셋** (Screen Studio 스타일 고퀄리티 30종+)
  - 카테고리: Warm / Cool / Pastel / Vibrant / Dark / Mesh
  - 프리셋 미리보기 그리드 (작은 사각형으로 시각화)
  - 호버 시 프리뷰 확대
- **사용자 커스텀 프리셋 저장**
  - 현재 그라디언트 설정 전체를 프리셋으로 저장
  - 이름 지정, 삭제, 불러오기
  - localStorage 영구 저장

#### L. 그라디언트 애니메이션 (보너스)
- 그라디언트 서서히 움직이는 애니메이션 프리뷰 (내보내기에는 미적용)
- Mesh 포인트 자동 움직임 (ambient motion)
- 애니메이션 속도 조절
- 정지 상태로 캡처하여 내보내기

### 6-5. 테두리 둥글기 (Border Radius)
- 0~100px 슬라이더
- 사각형 배경일 때만 표시
- 값 표시 라벨

### 6-6. 캔버스 패딩
- 0~90% (5% 단위)
- 로고 전체 둘레의 여백 조절

---

## 7. 크기 설정

### 7-1. 일반 프리셋 (12종)
| 크기 |
|------|
| 16×16 |
| 32×32 |
| 48×48 |
| 96×96 |
| 128×128 |
| 192×192 |
| 256×256 |
| 512×512 |
| 1024×1024 |
| 1280×720 |
| 1920×1080 |
| Custom (직접 W×H 입력) |

### 7-2. 디바이스별 프리셋 그룹

#### Android (6종)
| 이름 | 크기 |
|------|------|
| mdpi | 48×48 |
| hdpi | 72×72 |
| xhdpi | 96×96 |
| xxhdpi | 144×144 |
| xxxhdpi | 192×192 |
| playstore | 512×512 |

#### iOS (17종)
| 이름 | 크기 |
|------|------|
| 20pt | 20×20 |
| 20pt @2x | 40×40 |
| 20pt @3x | 60×60 |
| 29pt | 29×29 |
| 29pt @2x | 58×58 |
| 29pt @3x | 87×87 |
| 40pt | 40×40 |
| 40pt @2x | 80×80 |
| 40pt @3x | 120×120 |
| 60pt @2x | 120×120 |
| 60pt @3x | 180×180 |
| 76pt | 76×76 |
| 76pt @2x | 152×152 |
| 83.5pt @2x | 167×167 |
| 512pt | 512×512 |
| 512pt @2x | 1024×1024 |
| App Store | 1024×1024 |

#### Web (6종)
| 이름 | 크기 |
|------|------|
| favicon | 16×16 |
| favicon-32 | 32×32 |
| apple-touch | 180×180 |
| android-chrome-192 | 192×192 |
| android-chrome-512 | 512×512 |
| og-image | 1200×630 |

#### macOS (7종)
| 이름 | 크기 |
|------|------|
| 16pt | 16×16 |
| 32pt | 32×32 |
| 64pt | 64×64 |
| 128pt | 128×128 |
| 256pt | 256×256 |
| 512pt | 512×512 |
| 1024pt | 1024×1024 |

#### Windows (6종)
| 이름 | 크기 |
|------|------|
| 16pt | 16×16 |
| 24pt | 24×24 |
| 32pt | 32×32 |
| 48pt | 48×48 |
| 64pt | 64×64 |
| 256pt | 256×256 |

---

## 8. 내보내기 (Export)

### 8-1. 포맷
| 포맷 | 설명 |
|------|------|
| **PNG** | 래스터, 투명 배경 지원 |
| **JPG** | 래스터, 95% 품질 |
| **SVG** | 벡터, 무한 확장 |

### 8-2. 스케일 배율 (래스터 전용)
- 1x / 2x / 3x / 4x
- SVG는 1x 고정
- 최종 출력 크기 표시: `W×H px` (래스터) / `W×H` (SVG)

### 8-3. 단일 내보내기
- 현재 설정대로 파일 하나 저장
- 파일명 규칙: `logo_WxH[@scale].ext`
  - 예: `logo_512x512.png`, `logo_512x512@2x.png`

### 8-4. 그룹 일괄 내보내기
- 디바이스 그룹(Android/iOS/Web/macOS/Windows) 선택 후 전체 크기 일괄 저장
- 저장 폴더 선택 다이얼로그
- 완료 시 성공 개수 + 플랫폼명 표시

### 8-5. SVG 내보내기 특수 처리
- Google Fonts `@import` URL 임베딩
- 폰트 weight별 URL 생성
- 그라디언트 정의 (`<linearGradient>`, `<radialGradient>`) 포함
- 클리핑 패스 (원형, 둥근 사각형) 포함
- TextPainter 기반 정확한 텍스트 크기 측정
- 텍스트 수직 중앙 정렬 (ascent 메트릭 사용)
- 멀티라인 텍스트 line-height 계산
- XML 특수문자 이스케이프 (`&`, `<`, `>`, `"`, `'`)

---

## 9. 프리셋 & 저장/불러오기

### 9-1. 컬러 프리셋 (로컬 저장)
- 현재 배경색 + 텍스트색 조합을 프리셋으로 저장
- 프리셋 이름 지정
- 프리셋 이름 변경
- 프리셋 삭제
- 프리셋 적용 → 즉시 색상 전환
- 반원 미리보기 UI (왼쪽=배경색, 오른쪽=텍스트색)
- localStorage (SharedPreferences) 영구 저장
- Bottom Sheet UI로 프리셋 목록 탐색

### 9-2. 전체 설정 프리셋 (JSON 파일)
- **저장 항목 전체 목록**:
  - 텍스트 내용 (각 줄)
  - 폰트 이름
  - 폰트 두께
  - 텍스트 줄 수
  - 텍스트 색상
  - 텍스트 패딩
  - 배경 색상
  - 배경 형태 (사각형/원형)
  - 캔버스 패딩
  - 테두리 둥글기
  - 캔버스 크기 (W×H)
  - 내보내기 포맷 (PNG/JPG/SVG)
  - 내보내기 스케일
  - 그라디언트 ON/OFF
  - 그라디언트 시작색
  - 그라디언트 끝색
  - 그라디언트 타입 (Linear/Radial)
  - 그라디언트 방향
  - 이미지 위치 (Top/Bottom/Left/Right)
  - 이미지/텍스트 비율
  - 이미지/텍스트 간격
  - 이미지 Fit 모드
  - 투명 배경 여부
- `.json` 파일로 저장/불러오기
- 파일 피커 다이얼로그 (`.json` 필터)
- Pretty-printed JSON 출력
- 이미지/SVG 파일은 프리셋에 미포함 (별도 관리)

---

## 10. 프리뷰 (실시간 미리보기)

### 10-1. 캔버스 프리뷰
- 모든 설정 변경 시 실시간 업데이트
- 선택된 크기의 종횡비 유지
- 크기 배지 표시 (W × H 형식)
- 테두리 및 그림자로 시각적 구분
- 윈도우 리사이즈 대응

### 10-2. 투명 배경 표시
- 투명 모드 시 체커보드 패턴 (8px 셀)
- 투명 영역 시각적 확인 가능

### 10-3. 텍스트 렌더링
- FittedBox로 가용 공간에 맞춰 자동 스케일
- 중앙 정렬 (수평 + 수직)
- 멀티라인 텍스트 각 줄 독립 렌더링

---

## 11. 상태 관리 (Next.js 설계 참고)

### 현재 Flutter 구조
- Riverpod 사용 (keepAlive=true)
- LogoNotifier → LogoState (immutable, copyWith 패턴)
- SharedPreferences로 컬러 프리셋 + 테마 영구 저장

### Next.js 권장 구조
- Zustand 또는 Jotai로 전역 상태 관리
- localStorage로 프리셋/테마 영구 저장
- Canvas API 또는 HTML/CSS + html-to-image로 프리뷰/내보내기
- SVG 내보내기는 DOM → string 직렬화

---

## 12. Next.js에서 추가/개선할 기능 목록

### 12-1. 고급 그라디언트 — Screen Studio 스타일 (섹션 6-4 참조)
- [ ] 멀티 컬러 스톱 (2~10개) + 드래그 바 UI
- [ ] 자유 각도 입력 (0~360도) + 원형 다이얼 UI
- [ ] Radial 중심점/반경/초점 조절 (2D 드래그 포인트)
- [ ] Conic(원뿔형) 그라디언트
- [ ] **Mesh Gradient** — 2D 캔버스 위 프리폼 컬러 블롭 (Canvas/WebGL)
- [ ] **노이즈/그레인 텍스처 오버레이** (SVG feTurbulence / Canvas noise)
- [ ] **블러/글로우 효과** (Backdrop blur + 글로우 포인트)
- [ ] Repeating 그라디언트 (Linear/Radial/Conic)
- [ ] 색상 전환 이징 곡선 + OKLab 색상 보간
- [ ] 그라디언트 프리뷰 바 + 드래그 스톱
- [ ] 고퀄리티 빌트인 프리셋 30종+ (카테고리별)
- [ ] 사용자 그라디언트 프리셋 저장
- [ ] 그라디언트 애니메이션 프리뷰 (정지 캡처로 내보내기)

### 12-2. UX 개선
- [ ] Undo/Redo (Ctrl+Z / Ctrl+Shift+Z)
- [ ] 최근 사용 프리셋 트래킹
- [ ] 컬러 프리셋 검색/필터
- [ ] 드래그 앤 드롭 이미지/SVG 업로드
- [ ] 클립보드 복사 (이미지)
- [ ] 키보드 단축키

### 12-3. 내보내기 개선
- [ ] WebP/AVIF 포맷 추가
- [ ] ICO 파일 (favicon) 직접 생성
- [ ] ZIP 일괄 다운로드 (그룹 내보내기)
- [ ] 다운로드 히스토리

### 12-4. 기타
- [ ] URL 공유 (설정을 URL 파라미터로 인코딩)
- [ ] 폰트 미리보기 (드롭다운에서 실제 폰트 렌더링)
- [ ] 커스텀 폰트 업로드 (woff2)
- [ ] 템플릿 갤러리 (미리 디자인된 로고 시작점)

---

## 13. 전체 데이터 모델 (LogoState)

```typescript
interface LogoState {
  // 모드
  mode: 'textOnly' | 'imageOnly' | 'textImage' | 'svgOnly';

  // 텍스트
  text1: string;
  text2: string;
  text3: string;
  textLines: 1 | 2 | 3;
  fontFamily: string;
  fontWeight: 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900;
  textColor: string; // hex
  textPadding: number; // 0~90, step 5

  // 배경
  backgroundColor: string; // hex
  backgroundShape: 'rectangle' | 'circle';
  isTransparent: boolean;
  canvasPadding: number; // 0~90, step 5
  borderRadius: number; // 0~100

  // 그라디언트
  useGradient: boolean;
  gradientStartColor: string; // hex
  gradientEndColor: string; // hex
  gradientType: 'linear' | 'radial' | 'conic' | 'mesh';
  gradientDirection:
    | 'topToBottom' | 'bottomToTop'
    | 'leftToRight' | 'rightToLeft'
    | 'topLeftToBottomRight' | 'topRightToBottomLeft'
    | 'bottomLeftToTopRight' | 'bottomRightToTopLeft';

  // 고급 그라디언트 (Next.js 신규 — Screen Studio 스타일)
  gradientStops?: Array<{ color: string; position: number; easing?: string }>; // 멀티 스톱
  gradientAngle?: number; // 0~360 자유 각도
  gradientCenterX?: number; // radial/conic 중심 X (0~1)
  gradientCenterY?: number; // radial/conic 중심 Y (0~1)
  gradientRadius?: number; // radial 반경
  gradientFocalX?: number; // radial 초점 X
  gradientFocalY?: number; // radial 초점 Y
  gradientEllipseRatio?: number; // radial 타원 비율
  gradientShape?: 'circle' | 'ellipse'; // radial 형태
  gradientRepeating?: boolean;
  colorInterpolation?: 'srgb' | 'oklab'; // 색상 보간 방식

  // Mesh Gradient (Screen Studio 핵심)
  useMeshGradient?: boolean;
  meshPoints?: Array<{
    color: string; // hex
    x: number; // 0~1 (캔버스 비율)
    y: number; // 0~1
    radius: number; // 확산 반경 (0~1)
  }>;

  // 노이즈/그레인 텍스처
  noiseEnabled?: boolean;
  noiseOpacity?: number; // 0~100
  noiseScale?: 'fine' | 'medium' | 'coarse';
  noiseType?: 'uniform' | 'gaussian' | 'filmGrain';
  noiseColor?: 'monochrome' | 'chromatic';

  // 블러/글로우
  backdropBlur?: number; // 0~50px
  glowPoints?: Array<{
    color: string;
    x: number; // 0~1
    y: number; // 0~1
    radius: number;
    opacity: number; // 0~1
  }>;

  // 이미지
  imageFile: File | null;
  imagePosition: 'top' | 'bottom' | 'left' | 'right';
  imageFlex: number; // 10~90
  imageGap: number; // 0~50
  imageFit: 'contain' | 'cover' | 'fill';

  // SVG
  svgFile: File | null;
  svgContent: string | null;

  // 내보내기
  canvasWidth: number;
  canvasHeight: number;
  exportFormat: 'png' | 'jpg' | 'svg';
  exportScale: 1 | 2 | 3 | 4;
}
```

---

## 14. 컬러 프리셋 데이터 모델

```typescript
interface ColorPreset {
  name: string;
  backgroundColor: string; // hex
  textColor: string; // hex
}
```

---

## 15. 그라디언트 프리셋 목록

| 이름 | 시작색 | 끝색 |
|------|--------|------|
| Sunset | #FF512F | #F09819 |
| Ocean | #2193B0 | #6DD5ED |
| Mint | #00B09B | #96C93D |
| Peach | #ED4264 | #FFEDBC |
| Night | #232526 | #414345 |
| Berry | #8E2DE2 | #4A00E0 |
| Fire | #FF416C | #FF4B2B |
| Sky | #56CCF2 | #2F80ED |
| Lime | #B2FF59 | #69F0AE |
| Royal | #141E30 | #243B55 |

---

## 16. 폰트별 지원 Weight 목록

```typescript
const fontWeights: Record<string, number[]> = {
  'Workbench': [400],
  'Jersey 20': [400],
  'Noto Serif': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Bebas Neue': [400],
  'Pacifico': [400],
  'Lobster': [400],
  'Raleway': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Permanent Marker': [400],
  'Black Han Sans': [400],
  'Noto Sans KR': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Montserrat': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Poppins': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Inter': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Space Grotesk': [300, 400, 500, 600, 700],
  'Rubik': [300, 400, 500, 600, 700, 800, 900],
  'Outfit': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Oswald': [200, 300, 400, 500, 600, 700],
  'Anton': [400],
  'Righteous': [400],
  'Russo One': [400],
  'Orbitron': [400, 500, 600, 700, 800, 900],
  'Audiowide': [400],
  'Bungee': [400],
  'Fredoka': [300, 400, 500, 600, 700],
  'Lexend': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Nunito': [200, 300, 400, 500, 600, 700, 800, 900],
  'Quicksand': [300, 400, 500, 600, 700],
  'Comfortaa': [300, 400, 500, 600, 700],
  'Rajdhani': [300, 400, 500, 600, 700],
  'Chakra Petch': [300, 400, 500, 600, 700],
  'Michroma': [400],
  'Teko': [300, 400, 500, 600, 700],
  'Electrolize': [400],
  'Exo 2': [100, 200, 300, 400, 500, 600, 700, 800, 900],
  'Megrim': [400],
  'Poiret One': [400],
  'Gruppo': [400],
  'Syncopate': [400, 700],
  'Zen Dots': [400],
};
```

---

## 17. 디바이스 프리셋 그룹 상세

```typescript
interface SizePreset {
  name: string;
  width: number;
  height: number;
}

interface DeviceGroup {
  platform: string;
  sizes: SizePreset[];
}

const deviceGroups: DeviceGroup[] = [
  {
    platform: 'Android',
    sizes: [
      { name: 'mdpi', width: 48, height: 48 },
      { name: 'hdpi', width: 72, height: 72 },
      { name: 'xhdpi', width: 96, height: 96 },
      { name: 'xxhdpi', width: 144, height: 144 },
      { name: 'xxxhdpi', width: 192, height: 192 },
      { name: 'playstore', width: 512, height: 512 },
    ],
  },
  {
    platform: 'iOS',
    sizes: [
      { name: '20pt', width: 20, height: 20 },
      { name: '20pt @2x', width: 40, height: 40 },
      { name: '20pt @3x', width: 60, height: 60 },
      { name: '29pt', width: 29, height: 29 },
      { name: '29pt @2x', width: 58, height: 58 },
      { name: '29pt @3x', width: 87, height: 87 },
      { name: '40pt', width: 40, height: 40 },
      { name: '40pt @2x', width: 80, height: 80 },
      { name: '40pt @3x', width: 120, height: 120 },
      { name: '60pt @2x', width: 120, height: 120 },
      { name: '60pt @3x', width: 180, height: 180 },
      { name: '76pt', width: 76, height: 76 },
      { name: '76pt @2x', width: 152, height: 152 },
      { name: '83.5pt @2x', width: 167, height: 167 },
      { name: '512pt', width: 512, height: 512 },
      { name: '512pt @2x', width: 1024, height: 1024 },
      { name: 'App Store', width: 1024, height: 1024 },
    ],
  },
  {
    platform: 'Web',
    sizes: [
      { name: 'favicon', width: 16, height: 16 },
      { name: 'favicon-32', width: 32, height: 32 },
      { name: 'apple-touch', width: 180, height: 180 },
      { name: 'android-chrome-192', width: 192, height: 192 },
      { name: 'android-chrome-512', width: 512, height: 512 },
      { name: 'og-image', width: 1200, height: 630 },
    ],
  },
  {
    platform: 'macOS',
    sizes: [
      { name: '16pt', width: 16, height: 16 },
      { name: '32pt', width: 32, height: 32 },
      { name: '64pt', width: 64, height: 64 },
      { name: '128pt', width: 128, height: 128 },
      { name: '256pt', width: 256, height: 256 },
      { name: '512pt', width: 512, height: 512 },
      { name: '1024pt', width: 1024, height: 1024 },
    ],
  },
  {
    platform: 'Windows',
    sizes: [
      { name: '16pt', width: 16, height: 16 },
      { name: '24pt', width: 24, height: 24 },
      { name: '32pt', width: 32, height: 32 },
      { name: '48pt', width: 48, height: 48 },
      { name: '64pt', width: 64, height: 64 },
      { name: '256pt', width: 256, height: 256 },
    ],
  },
];
```
