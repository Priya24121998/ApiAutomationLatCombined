<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="common/navigationUserCreation.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Multiple User Creation</title>
<style>
body {
    font-family: 'Helvetica Neue', Arial, sans-serif;
    text-align: center;
    background-color: #f0f2f5;
    color: #333;
    margin: 0;
    padding: 0;
}

.message-container {
    margin: 50px auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #fff;
    width: 60%;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.message-container h1 {
    color: #007bff; /* Blue color */
    font-size: 24px;
}

.alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 4px;
    display: inline-block;
    text-align: center;
}

.alert-success {
    color: green; 
    background-color: transparent; 
    border-color: transparent;
}

.alert-danger {
    color: #721c24;
    background-color: #f8d7da;
    border-color: #f5c6cb;
}

button {
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}
</style>
<script>
function downloadCSV() {
    let csvContent = "data:text/csv;charset=utf-8,User ID,Password,Account,Email\n";
    <c:forEach var="user" items="${userList}">
        csvContent += "${user.userId},${user.password},${user.account},${user.emailId}\n";
    </c:forEach>
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", "user_creation_report.csv");
    document.body.appendChild(link);
    link.click();
}
</script>
</head>
<body>
    <div class="message-container">
        <h1>Multiple User Creation Result Page</h1>
        <c:choose>
            <c:when test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">Users created successfully</div>
                <button onclick="downloadCSV()">Download CSV</button>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger" role="alert">User creation failed</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
