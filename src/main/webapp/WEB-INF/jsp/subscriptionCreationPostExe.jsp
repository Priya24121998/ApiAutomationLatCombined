<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subscription Confirmation</title>
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
    color: #28a745;
    font-size: 24px;
}

.details {
    text-align: left;
    margin-top: 20px;
}

.details p {
    margin: 10px 0;
}

.download-button {
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.download-button:hover {
    background-color: #0056b3;
}

.alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 4px;
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
.link-container {
    margin-top: 20px;
}

.link-container a {
    margin: 0 10px; /* Add space between links */
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script>
function downloadPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    doc.text("Subscription Confirmation", 10, 10);
    doc.text("Environment: " + document.getElementById("environment").innerText, 10, 20);
    doc.text("Store: " + document.getElementById("store").innerText, 10, 30);
    doc.text("Subscription ID: " + document.getElementById("subscriptionId").innerText, 10, 40);
    doc.text("User ID: " + document.getElementById("userId").innerText, 10, 50);
    doc.text("Account: " + document.getElementById("account").innerText, 10, 60);
    doc.text("Subscription Type: " + document.getElementById("subscriptionType").innerText, 10, 70);
    doc.text("Payment Type: " + document.getElementById("paymentType").innerText, 10, 80);
    doc.text("Date: " + document.getElementById("date").innerText, 10, 90);

    doc.save("subscription_confirmation.pdf");
}
</script>
</head>
<body>
    <div class="message-container">
        <c:choose>
            <c:when test="${not empty successMessage}">
                <h1>Subscription Successful!</h1>
                <div class="alert alert-success" role="alert">${successMessage}</div>
                <p style="color: green;">Thank you for subscribing. Here are your subscription details:</p>
                <div class="details">
                    <p><strong>Environment:</strong> <span id="environment">${subscriptionMessageAtt.env}</span></p>
                    <p><strong>Store:</strong> <span id="subscriptionId">${subscriptionMessageAtt.store}</span></p>
                    <p><strong>Order ID:</strong> <span id="userId">${subscriptionMessageAtt.orderId}</span></p>
                    <p><strong>Subscription Id:</strong> <span id="subscriptionType">${subscriptionMessageAtt.subscriptionId}</span></p>
                    <p><strong>Rental Type:</strong> <span id="rentalType">${subscriptionMessageAtt.rentalType}</span></p>
                    <p><strong>Rental Isbn:</strong> <span id="rentalIsbn">${subscriptionMessageAtt.rentalIsbn}</span></p>
                    <p><strong>Rental Id:</strong> <span id="rentalId">${subscriptionMessageAtt.rentalId}</span></p>
                    <p><strong>User Id:</strong> <span id="userId">${subscriptionMessageAtt.userId}</span></p>
                    <p><strong>Delivery Mode:</strong> <span id="deliveryMode">${subscriptionMessageAtt.deliveryMode}</span></p>
                    <p><strong>Payment Type:</strong> <span id="paymentType">${subscriptionMessageAtt.paymentType}</span></p>
                    <p><strong>Date:</strong> <span id="date">${subscriptionMessageAtt.date}</span></p>
                </div>
                <button class="download-button" onclick="downloadPDF()">Download Report</button>
            </c:when>
            <c:otherwise>
                <h1>Subscription Failed</h1>
                <div class="alert alert-danger" role="alert">${errorMessage}</div>
                <p>There was an issue with your subscription. Please try again later.</p>
            </c:otherwise>
        </c:choose>
       <div class="link-container">
            <a href="homePage">Back To Home</a>
            <a href="subscriptionCreation?store=${param.store}">Previous Page</a>
            <a href="b2cSuborderHistory">History Page</a>
        </div>
    </div>
</body>
</html>
