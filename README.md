# 상품정보관리 프로젝트

## ```ajax``` 기능을 활용하여 상품정보 보기 실행
## ```sitemesh3``` layout 적용
## ```mysql DB``` 

## 파일 업로드 기능 추가
* 파일업로드에서는 파일의 내용(파일 자체)를 직접 DB에 저장하기도 하지만, 그렇게 할경우 DBMS에 많은 무리가 생겨 성능상 문제가 된다.
* 파일은 ```public(resource)```으로 공개된 폴더에 저장을 하고 DB에는 파일의 경로, 이름만 저장하여 
* 보여줄때 그 경로를 img tag를 사용하여 보여준다.

### 파일 업로드 form
* 파일 업로드를 위해서 ```<input type="file" tag>``` 를 사용하고
* 파일을 선택할수 있도록 수행한다.

#### 중요!!!
* 파일 업로드 폼에는 반드시 enctype 속성을 지정한다.
* ```<form enctype="multipart/form-data">``` 라고 지정한다.

### 파일 size
* ```CommonsMultipartResolver``` 클래스에 파일 최대 업로드 크기를 지정해 주어야 한다.
* 단위 byte단위로 설정한다. 
* ```1KB = 1024```, ```1MB = 1024KB```, ```1MB = 1024 * 1024```

### 파일을 저장할 폴더
* ```servlet-context.xml```의 ```resources```로 폴더를 설정하고 외부에 개방을 해줘야 한다.
* 가상디렉토리 : ```resources tag```를 사용하여 ```mapping```으로 설정한 값
* 실제폴더 : ```location```으로 설정한 값
* web에서 ```server/context/mapping```으로 접근을 시도하면 실제로는
location폴더의 내용에 접근할수 있도록 설정하는 것이다.

* 로컬프로젝트에 있는 파일들을 프로젝트를 서버로 배포(deploy)하면 파일들이 모두 자동으로 복사되어 문제를 일으키지 않는다.
* 만약 서버가 실행된 상태에서 파일업로드를 통해서 서버에 복사한 파일은 실제 로컬에 없는 파일이기 때문에 만약 서버를  
clean 하거나 프로젝트를 다시 deploy하면 모든 내용이 삭제되어 버린다.
* 이러한 현상을 방지하기 위해서 files 폴더를 tomcat 서버와 별개의 장소에 만들어 두고 이 폴더를 외부에 개방을 한다.

```
<resources mapping="/files/**" 
		location="file:///c:/bizwork/files/" />
```
* ```resources mapping```을 위와 같이 설정하면 서버를 통해서 ```/files/``` 디렉토리에 접근을 하면 실제로는 ```c:/bizwork/files``` 폴더에 접근을 허락하는 것이다.

* 이 설정을 수행했으나 만약 ```c:/bizwork/files``` 폴더에 접근이 되지 않을 경우 
```BeanNameUrlHandlerMapping```을 ```servlet-context.xml```에 ```benas:bean```으로 등록을 해준다.

* ```BeanNameUrlHandlerMapping``` : ```Dispatcher```가 기본으로 사용하는 ```Mapping```인데 간혹 일부 기능에서 참조를 못하는 경우가 있어서 bean으로 설정을 한다.


## 다중파일 업로드
#### 파일을 여러개 선택하여 동시에 업로드 하기
* ```<input type="file">``` 에 ```multiple="multiple"```  속성을 추가하고
* ```controller```에서 ```MultipartHttpServletRequest``` 클래스로 데이터를 수신하기

* 수신한 파일 정보에서 MulipartFile들을 추출하여 각각 upload를 수행하고
* 파일이름 List를 생성하여 tbl_files 테이블에 insert를 수행한다 
* mybatis의 동적쿼리를 활용하여 다수의 insert를 한번에 처리한다.

#### 상품정보 추가와 상품정보 변경할경우 파일 업로드
* 1개의 파일을 업로드하는 경우 상품정보를 변경할때 기존 파일과 파일정보를 제거하고 새로운 파일을 업로드 및 정보 업데이트 수행
* 2개 이상의 파일을 업로드 할경우 상품추가, 상품변경에서 파일은 추가만 수행을 한다
* 필요없는 파일은 별도로 파일들만 삭제하는 기능을 구현한다.


### Vue 를 적용한  Spring MVC
