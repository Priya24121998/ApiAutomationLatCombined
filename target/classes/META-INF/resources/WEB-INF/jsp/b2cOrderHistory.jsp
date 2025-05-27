<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History</title>
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

pagination {
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
		<h1>Order History</h1>
		<a href="b2cExportOrderDetails" class="export-button">Export to CSV</a>
	</div>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Environment</th>
				<th>Store</th>
				<th>Order ID</th>
				<th>User ID</th>
				<th>Delivery Mode</th>
				<th>Promo Code Applied or not</th>
				<th>Promo Code Value if applied</th>
				<th>Payment Type</th>
				<th>Date</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="order" items="${b2corderHistory}">
				<tr>
					<td>${order.id}</td>
					<td>${order.env}</td>
					<td>${order.store}</td>
					<td>${order.orderId}</td>
					<td>${order.userId}</td>
					<td>${order.deliveryMode}</td>
					<td>${order.promoCodeApplied}</td>
					<td>${order.promoCode}</td>
					<td>${order.paymentType}</td>
					<td>${order.date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">
		<c:forEach var="i" begin="1" end="${totalPages}">
			<a href="b2corderHistory?page=${i}"
				class="${i == currentPage ? 'active' : ''}">${i}</a>
		</c:forEach>
	</div>
	<div class="centered-link">
		<p>
			<a href="/homePage">Back to Home</a>
		</p>
	</div>

</body>
</html>
