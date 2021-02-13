# Photos App

> Kakaopay iOS 사전 과제

사진 API 를 사용하여 요구사항을 충족하는 앱을 만들기.

## 화면 동작

> 스크린샷을 누르면 Youtube 영상으로 이동합니다. 

[![Video Label](http://img.youtube.com/vi/P5-yaIQWo68/0.jpg)](https://youtu.be/P5-yaIQWo68?t=0s)

## 기능

- 과제로 주어진 기능과 동일
- 사진 검색 후 기록을 표시

## 고려한 점

- Coordinator pattern 적용
- Cell 에서 Networking 을 하기보다 따로 관리하여 부드러운 이미지 처리 결과 고려
- private 할 수 있는 것은 최대한 private 하게 작성
- Xib, code 를 통한 UI 작업을 보여주기 위해 두가지 경우 모두 작성 (ex - PhotosViewController.xib), (ex - PhotoSearchViewController)
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
