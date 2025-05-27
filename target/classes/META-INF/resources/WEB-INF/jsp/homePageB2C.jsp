<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<style>
body {
	font-family: 'Roboto', sans-serif;
	background-color: #f8f9fa;
	margin: 0;
	padding: 0;
	color: #343a40;
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
	background-color: #ffffff;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	text-align: center;
}

.navigation {
	margin-top: 20px;
}

.navigation a {
	margin: 0 15px;
	color: #007bff;
	font-weight: bold;
	transition: color 0.3s;
}

.navigation a:hover {
	color: #0056b3;
}

.b2c-links {
	margin-top: 10px;
}

.b2c-links div {
	margin-bottom: 20px; /* Added margin between divs */
	display: flex;
	justify-content: center;
}

.b2c-links a {
	margin: 0 10px;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border-radius: 5px;
	text-decoration: none;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: background-color 0.3s, box-shadow 0.3s;
}

.b2c-links a:hover {
	background-color: #0056b3;
	box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

p {
	text-align: justify;
	line-height: 1.8;
}
</style>
<script>
function openOrderTabs() {
    const urls = [
        'placeOrderB2CHome?store=B2CAU',
        'placeOrderB2CHome?store=B2CNZ',
        'placeOrderB2CHome?store=B2CEMEA',
        'placeOrderB2CHome?store=B2CUS',
        'placeOrderB2CHome?store=B2CCA',
        'subscriptionCreation?store=B2CUS'
    ];
    urls.forEach(url => {
        window.open(url, '_blank');
    });
}
</script>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
	rel="stylesheet">
</head>
<body>
	<div class="header">
		<h1>Cengage B2C Stores</h1>
	</div>
	<div class="container">
		<p style="text-align: center;">Explore our Cengage B2C Stores
			Place Order Platform and manage the orders seamlessly!</p>
		<div class="navigation">
			<div class="b2c-links">
				<div>
					<a href="placeOrderB2CHome?store=B2CAU">Place an AU Order</a> <a
						href="placeOrderB2CHome?store=B2CNZ">Place a NZ Order</a> <a
						href="placeOrderB2CHome?store=B2CEMEA">Place an EMEA Order</a>
				</div>
				<div>
					<a href="placeOrderB2CHome?store=B2CUS">Place a US Order</a> <a
						href="placeOrderB2CHome?store=B2CCA">Place a CA Order</a> <a
						href="subscriptionCreation?store=B2CUS">Place a Sub or Rental
						Order</a>
				</div>
				<div>
					<a href="b2corderHistory">View Order History</a> <a
						href="b2cSuborderHistory">View Subscription Order History</a>
				</div>	           
			</div>
		</div>
	</div>
</body>
</html>
