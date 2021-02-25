# Photos App

사진 API 를 사용하여 앱 만들기.

## 화면 동작

> 스크린샷을 누르면 Youtube 영상으로 이동합니다. 

[![Video Label](http://img.youtube.com/vi/P5-yaIQWo68/0.jpg)](https://youtu.be/P5-yaIQWo68?t=0s)

### Photo list

<img src="https://user-images.githubusercontent.com/37286026/107846584-3876f780-6e28-11eb-820a-f0d51853c391.png" width="200">

### Photo

<img src="https://user-images.githubusercontent.com/37286026/107846586-39a82480-6e28-11eb-84d3-234eefbdc30f.png" width="200">

- 화면 터치 후 닫기 버튼이 나옵니다. 이를 통하여 리스트로 이동 가능.

### Search

<img src="https://user-images.githubusercontent.com/37286026/107846587-3b71e800-6e28-11eb-9c6a-c40de902da4d.png" width="200">

- 사용자가 검색했던 list 를 보여줍니다.
- 해당 list 를 터치할 시 text 에 맞는 검색 리스트가 보여집니다.
- 검색창의 모든 글자를 지우면 검색기록 화면이 보여집니다.

## 고려한 점

- Coordinator pattern 적용
- Cell 에서 Networking 을 하기보다 따로 관리하여 부드러운 이미지 처리 결과 고려
- private 할 수 있는 것은 최대한 private 하게 작성
- Xib, code 를 통한 UI 작업을 보여주기 위해 두가지 경우 모두 작성
- image 처리 중 memory 사용량에 대한 고민
- massive 한 ViewController 가 되지 않도록 최대한 작업을 나누었습니다.
- TabBarController 적용
- 중복을 피하기 위한 제네릭, 상속 사용
- 제시된 앱이 내부적으로 어떻게 작성되어있을까? 를 생각하며 작성 했습니다.

## 구조

### MVC
![MVC](https://user-images.githubusercontent.com/37286026/107844051-9f3de600-6e13-11eb-947b-eb9c0e787c19.png)

### Coordinate pattern
![Coordinate](https://user-images.githubusercontent.com/37286026/107844052-a2d16d00-6e13-11eb-908e-90223f2ff547.png)

## Code Documents
[Corde Doc WIKI](https://github.com/sangbeomLee/Photos/wiki/Cord-Document)

## 고민
[고민 정리](https://github.com/sangbeomLee/Photos/wiki/시행착오)
