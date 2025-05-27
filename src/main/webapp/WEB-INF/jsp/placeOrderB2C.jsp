<%@ include file="common/header.jspf"%>
<%@ include file="common/backToHomeB2C.jspf"%>
<style>
.form-container h1 {
	text-align: center;
	margin-top: 20px;
	color: #007bff; /* Change this to your desired color */
	font-size: 2em; /* Adjust the font size as needed */
	font-weight: bold; /* Make the text bold */
	padding: 10px; /* Add some padding */
	background-color: #f8f9fa; /* Add a background color */
	border-radius: 5px; /* Add rounded corners */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add a subtle shadow */
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

.alert-success {
	color: #155724;
	background-color: #d4edda;
	border-color: #c3e6cb;
}

.hidden {
	display: none;
}

.form-group textarea {
	width: 100%;
	box-sizing: border-box;
}
</style>
<body>
	<div class="form-container">
		<h1>Place Your Order</h1>
		<form:form method="post" modelAttribute="placeOrderB2C"
			action="placeOrderB2CHome?store=${param.store}" id="orderForm"
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
							value="existing" checked="true" onclick="toggleUserGuid()" />
						Existing User
					</label> <label> <form:radiobutton path="userType" name="userType"
							value="create" onclick="toggleUserGuid()" /> New User
					</label>
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="userGuidField">
				<div class="form-group">
					<form:label path="userid">User ID:</form:label>
					<form:input type="text" path="userid" name="userid"
						placeholder="Enter your user ID" required="required" />
					<form:errors path="userid" cssClass="error" />
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
					<form:label path="isbnType">ISBN Type:</form:label>
					<form:select path="isbnType" name="isbnType" id="isbnType"
						required="required" onchange="toggleISBNOptions()">
						<form:option value="physical" label="Physical" />
						<form:option value="digital" label="Digital" />
						<form:option value="bundle" label="Bundle" />
						<form:option value="other" label="Other" />
						<form:option value="combined" label="Combined" />
					</form:select>
					<form:errors path="isbnType" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="physicalISBNOptions">
				<div class="form-group">
					<form:label path="physicalISBN">Physical ISBN:</form:label>
					<form:select path="physicalISBN" name="physicalISBN">
                        <c:forEach var="isbn" items="${physicalISBNs}">
                            <form:option value="${isbn}" label="${isbn}" />
                        </c:forEach>
					</form:select>
					<form:errors path="physicalISBN" cssClass="error" />
				</div>
			</fieldset>

			<!-- Digital ISBNs Dropdown -->
			<fieldset class="mb-3 hidden" id="digitalISBNOptions">
				<div class="form-group">
					<form:label path="digitalISBN">Digital ISBN:</form:label>
					<form:select path="digitalISBN" name="digitalISBN">
                        <c:forEach var="isbn" items="${digitalISBNs}">
                            <form:option value="${isbn}" label="${isbn}" />
                        </c:forEach>
					</form:select>
					<form:errors path="digitalISBN" cssClass="error" />
				</div>
			</fieldset>

			<!-- Bundle ISBNs Dropdown -->
			<fieldset class="mb-3 hidden" id="bundleISBNOptions">
				<div class="form-group">
					<form:label path="bundleISBN">Bundle ISBN:</form:label>
					<form:select path="bundleISBN" name="bundleISBN">
						<c:forEach var="isbn" items="${bundleISBNs}">
                            <form:option value="${isbn}" label="${isbn}" />
                        </c:forEach>
					</form:select>
					<form:errors path="bundleISBN" cssClass="error" />
				</div>
			</fieldset>

			<!-- Other ISBN Text Box -->
			<fieldset class="mb-3 hidden" id="otherISBNOptions">
				<div class="form-group">
					<form:label path="otherISBN">Other ISBN:</form:label>
					<form:input type="text" path="otherISBN" name="otherISBN"
						placeholder="Enter ISBN" />
					<form:errors path="otherISBN" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="combinedISBNOptions">
				<div class="form-group">
					<form:label path="multipleProd">Multiple Products:</form:label>
					<form:textarea path="multipleProd" name="multipleProd"
						placeholder="Enter multiple product details"></form:textarea>
					<form:errors path="multipleProd" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="promoCodeApplied">Promo Code Applied:</form:label>
					<form:select path="promoCodeApplied" name="promoCodeApplied"
						id="promoCodeApplied" onchange="togglePromoCodeField()">
						<form:option value="no" label="No" selected="selected" />
						<form:option value="yes" label="Yes" />
					</form:select>
					<form:errors path="promoCodeApplied" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="promoCodeFieldset">
				<div class="form-group">
					<form:label path="promoCode">Promo Code:</form:label>
					<form:input type="text" path="promoCode" name="promoCode"
						placeholder="Enter promo code" />
					<form:errors path="promoCode" cssClass="error" />
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
					<form:label path="creditCardType">Credit Card Type:</form:label>
					<form:select path="creditCardType" name="creditCardType">
						<form:option value="Visa" label="Visa" />
						<form:option value="MasterCard" label="MasterCard" />
						<form:option value="Amex" label="Amex" />
						<form:option value="Discover" label="Discover" />
					</form:select>
					<form:errors path="creditCardType" cssClass="error" />
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
			toggleISBNOptions();
			togglePromoCodeField();
			toggleUserGuid();
		});
		function showSuccessMessage() {
			document.getElementById('successMessage').style.display = 'block';
			orderInProgress = true;
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
			var creditCardOptions = document
					.getElementById('creditCardOptions');
			if (paymentType === 'cc') {
				creditCardOptions.classList.remove('hidden');
			} else {
				creditCardOptions.classList.add('hidden');
			}
		}
		function validatePromoCode() {
			var promoCodeApplied = document.getElementById('promoCodeApplied').value;
			if (promoCodeApplied === 'yes') {
				var promoCode = document.getElementById('promoCode').value;
				if (promoCode.length < 5) {
					alert('Promo code must be at least 5 characters long.');
					return false;
				}
			}
			return true;
		}

		function togglePromoCodeField() {
			var promoCodeApplied = document.getElementById('promoCodeApplied').value;
			var promoCodeFieldset = document
					.getElementById('promoCodeFieldset');
			if (promoCodeApplied === 'yes') {
				promoCodeFieldset.classList.remove('hidden');
			} else {
				promoCodeFieldset.classList.add('hidden');
			}
		}

		function toggleISBNOptions() {
			var isbnType = document.getElementById('isbnType').value;
			var physicalISBNOptions = document
					.getElementById('physicalISBNOptions');
			var digitalISBNOptions = document
					.getElementById('digitalISBNOptions');
			var bundleISBNOptions = document
					.getElementById('bundleISBNOptions');
			var otherISBNOptions = document.getElementById('otherISBNOptions');
			var combinedISBNOptions = document
					.getElementById('combinedISBNOptions');

			physicalISBNOptions.classList.add('hidden');
			digitalISBNOptions.classList.add('hidden');
			bundleISBNOptions.classList.add('hidden');
			otherISBNOptions.classList.add('hidden');
			combinedISBNOptions.classList.add('hidden');

			if (isbnType === 'physical') {
				physicalISBNOptions.classList.remove('hidden');
			} else if (isbnType === 'digital') {
				digitalISBNOptions.classList.remove('hidden');
			} else if (isbnType === 'bundle') {
				bundleISBNOptions.classList.remove('hidden');
			} else if (isbnType === 'other') {
				otherISBNOptions.classList.remove('hidden');
			} else if (isbnType === 'combined') {
				combinedISBNOptions.classList.remove('hidden');
			}
		}
		document.getElementById('orderForm').onsubmit = function(event) {
			if (orderInProgress) {
				alert('Order placement is in process.');
				event.preventDefault();
				return false;
			}
			return validatePromoCode() && showSuccessMessage();
		};
	</script>
	<%@ include file="common/footer.jspf"%>
</body>
