<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="common/backToHome.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Creation History</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.header {
	background-color: #007bff; /* Blue color for header */
	color: white;
	padding: 20px;
	text-align: center;
	position: relative;
}

.header h1 {
	margin: 0;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
	border: 2px solid #333; /* Thicker border for the table */
}

th, td {
	border: 2px solid #333; /* Thicker border for table cells */
	padding: 10px;
	text-align: left;
}

th {
	background-color: #007bff; /* Blue color for table header */
	color: white; /* Header text color */
	font-weight: bold;
}

.pagination {
	text-align: center;
	margin: 20px 0;
}

.pagination a {
	margin: 0 5px;
	padding: 8px 16px;
	border: 1px solid #ddd;
	color: #333;
	text-decoration: none;
}

.pagination a.active {
	background-color: #007bff; /* Blue color for active page */
	color: white;
	border: 1px solid #007bff;
}

.export-button {
	display: inline-block;
	padding: 10px 20px;
	margin: 10px 0;
	background-color: #28a745; /* Green color for export button */
	color: white;
	text-decoration: none;
	border-radius: 5px;
	position: absolute;
	top: 20px;
	right: 20px;
}

.export-button:hover {
	background-color: #218838; /* Darker green on hover */
}
.centered-link {
    text-align: center;
    margin: 20px 0;
}

</style>
</head>
<body>
	<div class="header">
		<h1>User Creation History</h1>
		<a href="exportUserDetails" class="export-button">Export to CSV</a>
	</div>
	<table>
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Environment</th>
				<th scope="col">Store</th>
				<th scope="col">User ID</th>
				<th scope="col">Account</th>
				<th scope="col">Date</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="userCreation" items="${userCreationHistory}">
				<tr>
					<td>${userCreation.id}</td>
					<td>${userCreation.env}</td>
					<td>${userCreation.store}</td>
					<td>${userCreation.userId}</td>
					<td>${userCreation.account}</td>
					<td>${userCreation.date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">
		<c:forEach var="i" begin="1" end="${totalPages}">
			<a href="userCreationHistory?page=${i}"
				class="${i == currentPage ? 'active' : ''}">${i}</a>
		</c:forEach>
	</div>
	<div class="centered-link">
	<p> <a href="/home">Back to Home</a></p>
	</div>
	
</body>
</html>