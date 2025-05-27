<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="common/navigationb2b.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Confirmation</title>
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
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    window.downloadPDF = function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.text("Order Confirmation", 10, 10);
        doc.text("Environment: " + document.getElementById("environment").innerText, 10, 20);
        doc.text("Store: " + document.getElementById("store").innerText, 10, 30);
        doc.text("Order ID: " + document.getElementById("orderId").innerText, 10, 40);
        doc.text("User ID: " + document.getElementById("userId").innerText, 10, 50);
        doc.text("Account: " + document.getElementById("account").innerText, 10, 60);
        doc.text("Delivery Mode: " + document.getElementById("deliveryMode").innerText, 10, 70);
        doc.text("Payment Type: " + document.getElementById("paymentType").innerText, 10, 80);
        doc.text("Date: " + document.getElementById("date").innerText, 10, 90);

        doc.save("order_confirmation.pdf");
    };
});
</script>
</head>
<body>
    <div class="message-container">
        <c:choose>
            <c:when test="${not empty successMessage}">
                <h1>Order Placed Successfully!</h1>
                <div class="alert alert-success" role="alert">${successMessage}</div>
                <p style="color: green;">Thank you for placing your order. Here are your order details:</p>
                <div class="details">
                    <p><strong>Environment:</strong> <span id="environment">${orderMessageAtt.env}</span></p>
                    <p><strong>Store:</strong> <span id="store">${orderMessageAtt.store}</span></p>
                    <p><strong>Order ID:</strong> <span id="orderId">${orderMessageAtt.orderId}</span></p>
                    <p><strong>User ID:</strong> <span id="userId">${orderMessageAtt.userId}</span></p>
                    <p><strong>Account:</strong> <span id="account">${orderMessageAtt.account}</span></p>
                    <p><strong>Delivery Mode:</strong> <span id="deliveryMode">${orderMessageAtt.deliveryMode}</span></p>
                    <p><strong>Promo Code Applied:</strong> <span id="promoCode">${orderMessageAtt.promoCode}</span></p>
                    <p><strong>Payment Type:</strong> <span id="paymentType">${orderMessageAtt.paymentType}</span></p>
                    <p><strong>Date:</strong> <span id="date">${orderMessageAtt.date}</span></p>
                </div>
            </c:when>
            <c:otherwise>
                <h1>Order Placement Failed</h1>
                <div class="alert alert-danger" role="alert">${errorMessage}</div>
                <p>There was an issue placing your order. Please try again later.</p>
            </c:otherwise>
        </c:choose>
        <p style="margin-top: 20px;"><a href="placeOrderHome?store=${param.store}">Previous Page</a></p>
    </div>
</body>
</html>
