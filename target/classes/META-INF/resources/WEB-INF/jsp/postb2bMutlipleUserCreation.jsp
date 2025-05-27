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

.details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap-align: left;
    margin-top: 20px;
    justify-items: start;
}

.user-details {
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.user-details p {
    margin: 10px 0;
    text-align: left
}

.user-details strong {
    display: inline-block
    width: 150px; 
    color: #007bff;
}

.user-details span {
    display: inline-block
    color: #333;
}

.pagination {
    margin-top: 20px;
    text-align: center;
}

.pagination button {
    padding: 10px 20px;
    background-color: #fff;
    color: #333;
    border: 1px solid #fff;
    border-radius: 5px;
    cursor: pointer;
    margin: 0 5px;
}

.pagination button:hover {
    background-color: #fff;
    color: #333;
}

.pagination button.active {
    background-color: #fff;
    color: #333;
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

a {
    color: #007bff;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script>
const itemsPerPage = 3;
let currentPage = 1;

function showPage(page) {
    const userDetails = document.querySelectorAll('.user-details');
    const totalItems = userDetails.length;
    const totalPages = Math.ceil(totalItems / itemsPerPage);

    userDetails.forEach((item, index) => {
        item.style.display = (index >= (page - 1) * itemsPerPage && index < page * itemsPerPage) ? 'block' : 'none';
    });

    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    for (let i = 1; i <= totalPages; i++) {
        const button = document.createElement('button');
        button.innerText = i;
        button.classList.add('page-button');
        if (i === page) {
            button.classList.add('active');
        }
        button.addEventListener('click', () => {
            currentPage = i;
            showPage(currentPage);
        });
        pagination.appendChild(button);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    showPage(currentPage);
});
</script>
</head>
<body>
    <div class="message-container">
        <h1>Multiple User Creation Result Page</h1>
        <c:choose>
            <c:when test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">Users created successfully</div>
                <div class="details" id="userDetails">
                    <c:forEach var="user" items="${userList}">
                        <div class="user-details">
                            <p><strong>Environment:</strong> <span class="userId">${user.env}</span></p>
                            <p><strong>User ID:</strong> <span class="userId">${user.userId}</span></p>
                            <p><strong>Store:</strong> <span class="store">${user.store}</span></p>
                            <p><strong>Password:</strong> <span class="password">${user.password}</span></p>
                            <p><strong>Account:</strong> <span class="account">${user.account}</span></p>
                            <p><strong>Email:</strong> <span class="emailId">${user.emailId}</span></p>
                            <p><strong>Date:</strong> <span class="date">${user.date}</span></p>
                        </div>
                    </c:forEach>
                </div>
                <div class="pagination" id="pagination"></div>
                <form action="downloadCsvFileForCurrentExecution" method="post">
                    <button type="submit">Download CSV</button>
                </form>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger" role="alert">User creation failed</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
