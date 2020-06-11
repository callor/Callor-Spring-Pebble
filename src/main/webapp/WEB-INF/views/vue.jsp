<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품정보 관리</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
div {
	margin: 5px;
}

div.row {
	margin: 0 auto;
}

div#p_list {
	height: 600px;
	overflow: auto;
}

#p_image {
	position: relative;
}

#p_image:hover {
	background-color: rgba(0, 0, 0, 0.3);
}
</style>
<script>
	$(function() {
		Vue.component('todo-item', {
			  // 이제 todo-item 컴포넌트는 "prop" 이라고 하는
			  // 사용자 정의 속성 같은 것을 입력받을 수 있습니다.
			  // 이 prop은 todo라는 이름으로 정의했습니다.
			  props: ['todo'],
			  template: '<li>{{ todo.text }}</li>'
		})
		
		// Vue 인스턴스 생성
		new Vue({
		  el: '#msg1',
		  data: {
		    message: '안녕하세요 처음 시작하는 Vue!'
		  }
		})
		
		// let 변수를 지정하여 인스턴스 생성
		// 베열표시
		let appArray = new Vue({
			  el: '#array',
			  data: {
			    groceryList: [
			      { id: 0, text: '대한민국만세' },
			      { id: 1, text: '우리나라만세' },
			      { id: 2, text: 'Republic of Korea' }
			    ]
			  }
		})
		
		// var 변수를 지정하여 인스턴스 생성
		// 버튼 클릭 이벤트
		var appButton = new Vue({
			  el: '#btn-view',
			  data: {
			    message: ''
			  },
			  methods: {
				  btnClick: function () {
			      // this.message = this.message.split('').reverse().join('')
			      this.message = '버튼을 클릭했군요'
			    }
			  }
		})
		
	})
	

</script>
</head>
<section class="container-fluid">
	<%@ include file="/WEB-INF/views/include/include-header.jsp" %>
	<article>
	<h3>Message 표시</h3>
	<div id="msg1">{{message}}</div>
	
	<h3>배열표시</h3>
	<div id="array">
  		<ol>
    	<!--
      		이제 각 todo-item 에 todo 객체를 제공합니다.
      		화면에 나오므로, 각 항목의 컨텐츠는 동적으로 바뀔 수 있습니다.
      		또한 각 구성 요소에 "키"를 제공해야합니다 (나중에 설명 됨).
     	-->
    	<todo-item
      		v-for="item in groceryList"
      		v-bind:todo="item"
      		v-bind:key="item.id"
    	/>
  		</ol>
	</div>
	<h3>버튼이벤트</h3>
	<div id="btn-view">
		<p>{{ message }}</p>
  		<button v-on:click="btnClick">Click ME</button>
	</div>
	
	</article>
	<%@ include file="/WEB-INF/views/include/include-footer.jsp" %>
</section>
</html>