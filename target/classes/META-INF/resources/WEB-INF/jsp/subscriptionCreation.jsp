<%@ include file="common/header.jspf"%>
<%@ include file="common/backToHomeB2C.jspf"%>
<style>
.form-container h1 {
	text-align: center;
	margin-top: 20px;
	color: #007bff;
	font-size: 2em;
	font-weight: bold;
	padding: 10px;
	background-color: #f8f9fa;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-container {
	width: 50%;
	margin: 0 auto;
	font-family: Arial, sans-serif;
}

.form-container fieldset {
	border: none;
	padding: 0;
	margin-bottom: 15px;
}

.form-group {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.form-group label {
	flex: 0 0 150px;
	font-weight: bold;
}

.form-group input, .form-group select {
	flex: 1;
	padding: 8px;
	box-sizing: border-box;
}

input[type="submit"] {
	background-color: #007bff;
	color: white;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
	display: block;
	margin: 20px auto;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}

.hidden {
	display: none;
}
</style>
<body>
	<div class="form-container">
		<h1>Place Your Order</h1>
		<form:form method="post" modelAttribute="placeOrderB2CSub"
			action="subscriptionCreation?store=${param.store}" id="orderForm"
			onsubmit="showSuccessMessage()">
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="env">Environment:</form:label>
					<form:input type="text" path="env" name="env"
						placeholder="Enter Environment" required="required" />
					<form:errors path="env" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="userType">User Type:</form:label>
					<label> <form:radiobutton path="userType" name="userType"
							value="existing" checked="true" onclick="toggleUserGuid()" /> Existing User
					</label> <label> <form:radiobutton path="userType" name="userType"
							value="create" onclick="toggleUserGuid()" /> New User
					</label>
				</div>
			</fieldset>

			<!-- User GUID Field -->
			<fieldset class="mb-3 hidden" id="userGuidField">
				<div class="form-group">
					<form:label path="userguid">User GUID:</form:label>
					<form:input type="text" path="userguid" name="userguid"
						placeholder="Enter your user GUID" />
					<form:errors path="userguid" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="deliveryMode">Delivery Mode:</form:label>
					<form:input type="text" path="deliveryMode" name="deliveryMode"
						placeholder="Enter Delivery Mode" required="required" />
					<form:errors path="deliveryMode" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="subscription">Subscription:</form:label>
					<label> <form:radiobutton path="subscription"
							name="subscription" value="yes" checked="true"
							onclick="toggleSubscriptionOptions()" />Yes
					</label> <label> <form:radiobutton path="subscription"
							name="subscription" value="no"
							onclick="toggleSubscriptionOptions()" />  No
					</label>
					<form:errors path="subscription" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="subscriptionOptions">
				<div class="form-group">
					<form:label path="subscriptionDuration">Subscription Duration:</form:label>
					<form:select path="subscriptionDuration"
						name="subscriptionDuration">
						<form:option value="4">FourMonths</form:option>
						<form:option value="12">TwelveMonths</form:option>
					</form:select>
					<form:errors path="subscriptionDuration" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="paymentType">Payment Type:</form:label>
					<form:select path="paymentType" name="paymentType" id="paymentType"
						required="required" onchange="toggleCreditCardOptions()">
						<form:option value="cc" label="Credit Card" />
						<form:option value="paypal" label="PayPal" />
					</form:select>
					<form:errors path="paymentType" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="creditCardOptions">
				<div class="form-group">
					<form:label path="creditCardTypeb2c">Credit Card Type:</form:label>
					<form:select path="creditCardTypeb2c" name="creditCardTypeb2c">
						<form:option value="Visa" label="Visa" />
            <form:option value="MasterCard" label="MasterCard" />
            <form:option value="Amex" label="Amex" />
            <form:option value="Discover" label="Discover" />
           </form:select>
					       
					<form:errors path="creditCardTypeb2c" cssClass="error" />
					   
				</div>
			</fieldset>
			  <!-- Initial Order Prompt -->
            <fieldset class="mb-3">
                <div class="form-group">
                    <label>Do you want to proceed with rental initial order?</label>
                    <label><input type="radio" path="initialOrder" name="initialOrder" value="yes" onclick="showRentalIsbn()"/> Yes</label>
                    <label><input type="radio" path="initialOrder" name="initialOrder" value="no" onclick="hideRentalIsbn()" /> No</label>
                </div>
            </fieldset>
            
            <!-- Display rentalIsbn -->
            <fieldset class="mb-3 hidden" id="rentalIsbnField">
                <div class="form-group">
                    <form:label path="rentalIsbn">Rental ISBN:</form:label>
                    <form:input type="text" path="rentalIsbn" name="rentalIsbn" placeholder="Enter Rental ISBN" />
                    <form:errors path="rentalIsbn" cssClass="error" />
                </div>
            </fieldset>
            
            <!-- Final Order Prompt -->
            <fieldset class="mb-3 hidden" id="finalOrderPrompt">
                <div class="form-group">
                    <label>Do you want to proceed with rental final order?</label>
                    <label><input type="radio" path="finalOrder" name="finalOrder" value="yes" onclick="showRentalType()"/> Yes</label>
                    <label><input type="radio" path="finalOrder" name="finalOrder" value="no" checked="true" onclick="hideRentalType()" /> No</label>
                </div>
            </fieldset>
            
            <!-- Display rental type dropdowns -->
            <fieldset class="mb-3 hidden" id="rentalTypeField">
                <div class="form-group">
                    <form:label path="rentalType">Rental Type:</form:label>
                    <form:select path="rentalType" name="rentalType">
                        <form:option value="extension15">Extension 15</form:option>
                        <form:option value="extension30">Extension 30</form:option>
                        <form:option value="goodState">Good State</form:option>
                        <form:option value="badState">Bad State</form:option>
                        <form:option value="buyout">Buyout</form:option>
                        <form:option value="noRentalTypeSelected">No Rental Type Selected</form:option>
                    </form:select>
                    <form:errors path="rentalType" cssClass="error" />
                </div>
            </fieldset>

			<input type="submit" value="Place Order" />
		</form:form>
	</div>
	<div class="container">
		<div id="successMessage" class="alert alert-success"
			style="display: none;">Order details submitted successfully!</div>
	</div>
	<script type="text/javascript">
		var orderInProgress = false;
		document.addEventListener('DOMContentLoaded', function() {
			toggleCreditCardOptions();
			toggleSubscriptionOptions();
			toggleUserGuid();
			showRentalIsbn();
			hideRentalIsbn();
			showRentalType();
			hideRentalType();
			
		});
		function showSuccessMessage() {
			document.getElementById('successMessage').style.display = 'block';
			orderInProgress = true;
		}
		function toggleSubscriptionOptions() {
			var subscription = document
					.querySelector('input[name="subscription"]:checked').value;
			var subscriptionOptions = document
					.getElementById('subscriptionOptions');
			if (subscription === 'yes') {
				subscriptionOptions.classList.remove('hidden');
			} else {
				subscriptionOptions.classList.add('hidden');
			}
		}
		function toggleUserGuid() {
			var userType = document
					.querySelector('input[name="userType"]:checked').value;
			var userGuidField = document.getElementById('userGuidField');
			if (userType === 'existing') {
				userGuidField.classList.remove('hidden');
			} else {
				userGuidField.classList.add('hidden');
			}
		}
		function toggleCreditCardOptions() {
			var paymentType = document.getElementById('paymentType').value;
			var creditCardOptions = document.getElementById('creditCardOptions');
			if (paymentType === 'cc') {
				creditCardOptions.classList.remove('hidden');
			} else {
				creditCardOptions.classList.add('hidden');
			}
		}
		
		 function showRentalIsbn() {
	            document.getElementById('rentalIsbnField').classList.remove('hidden');
	            document.getElementById('finalOrderPrompt').classList.remove('hidden');
	        }
	        
		  function hideRentalIsbn() {
	            document.getElementById('rentalIsbnField').classList.add('hidden');
	            document.getElementById('finalOrderPrompt').classList.add('hidden');
	            hideRentalType();
	        }
	        
	        function showRentalType() {
	            document.getElementById('rentalTypeField').classList.remove('hidden');
	        }
	        
	        function hideRentalType() {
	            document.getElementById('rentalTypeField').classList.add('hidden');
	        }
	        
		document.getElementById('orderForm').onsubmit = function(event) {
			if (orderInProgress) {
				alert('Order placement is in process.');
				event.preventDefault();
				return false;
			}
			showSuccessMessage();
		};
	</script>
	<%@ include file="common/footer.jspf"%>
</body>
