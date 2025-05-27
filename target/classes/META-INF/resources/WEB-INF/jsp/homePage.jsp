<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 20px 0;
        }
        .header h1 {
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }
        .navigation {
            margin-top: 20px;
        }
        .navigation a {
            margin: 0 15px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .navigation a:hover {
            text-decoration: underline;
        }
        .b2b-links {
            margin-top: 10px;
        }
        /* New section for B2B user creation */
        #b2b-user-creation {
            margin-top: 30px;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
        }
        #b2b-user-creation a {
            margin: 0 15px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        #b2b-user-creation a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Cengage B2B Stores</h1>
    </div>
    <div class="container">
        <p>Explore our Cengage B2B Stores Place Order Platform and manage the orders seamlessly!</p>
        <div class="navigation">
            <div class="b2b-links">
                <a href="placeOrderHome?store=B2BCA">Place a Canada Order</a>
                <a href="placeOrderHome?store=B2BUS">Place a US Order</a>
                <a href="placeOrderHome?store=B2BGT">Place a Gale Order</a>
                <a href="/orderHistory">View Order History</a>
            </div>
        </div>
        <!-- New section for B2B user creation -->
        <div id="b2b-user-creation">
            <a href="/create-b2b-user?store=B2BCA">Create B2B User</a>
            <a href="/userCreationHistory">View User Creation History</a>
        </div>
    </div>
</body>
</html>