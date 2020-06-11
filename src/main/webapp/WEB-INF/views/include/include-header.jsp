<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<style>
	header.container-fluid {
		margin-bottom: 0px;
		border-bottom-left-radius: 0px;
		border-bottom-right-radius: 0px;
	}
	
	nav.navbar {
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
	}
</style>
<header class="container-fluid jumbotron text-center bg-success">
	<h3>상품정보 관리</h3>
	<p>대한 쇼핑몰 상품정보 관리자 화면</p>
</header>
<nav class="navbar navbar-expand-sm  bg-dark navbar-dark">
	<ul class="navbar-nav">
		<li><a class="navbar-brand nav-link" href="#">Home</a></li>
		<li class="nav-item"><a class="nav-link" href="#">상품등록</a></li>
		<li class="nav-item"><a class="nav-link" href="#">재고관리</a></li>
		<li class="nav-item"><a class="nav-link disabled" href="#">관리자</a>
		</li>
	</ul>
</nav>