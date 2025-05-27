<%@ include file="common/header.jspf"%>
<%@ include file="common/backToHome.jspf"%>
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
</style>

<body>
	<div class="form-container">
		<h1>Place Your Order</h1>
		<form:form method="post" modelAttribute="placeOrderAtt"
			action="placeOrderHome?store=${param.store}" id="orderForm"
			onsubmit="showSuccessMessage()">
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="env">Environment:</form:label>
					<form:select path="env" name="env" required="required">
						<form:option value="QA" label="QA" />
						<form:option value="INT" label="INT" />
						<form:option value="PERF" label="PERF" />
					</form:select>
					<form:errors path="env" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="userid">User ID:</form:label>
					<form:input type="text" path="userid" name="userid"
						placeholder="Enter your user ID" required="required" />
					<form:errors path="userid" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3" id="accountDropdown">
				<div class="form-group">
					<form:label path="account">Account:</form:label>
					<form:select path="account" id="account" name="account"
						required="required" onchange="toggleOtherAccountField()">
						<form:option value="" label="Select Account" />
						<c:forEach var="account" items="${staticAccounts}">
							<form:option value="${account}" label="${account}" />
						</c:forEach>
						<form:option value="Other" label="Other" />
					</form:select>
					<form:errors path="account" cssClass="error" />
				</div>
				<div class="form-group hidden" id="otherAccountField">
					<form:label path="otherAccount">Other Account:</form:label>
					<form:input type="text" path="otherAccount" name="otherAccount"
						placeholder="Enter other account" />
					<form:errors path="otherAccount" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="orderType">Order Type:</form:label>
					<form:select path="orderType" name="orderType" id="orderType"
						required="required" onchange="toggleOrderTypeOptions()">
						<form:option value="singleOrder" label="Single Order" />
						<form:option value="fastPacedOrder" label="Fast Paced Order" />
					</form:select>
					<form:errors path="orderType" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="isbnTypeField">
				<div class="form-group">
					<form:label path="isbnType">ISBN Type:</form:label>
					<form:select path="isbnType" name="isbnType" id="isbnType"
						required="required" onchange="toggleIsbnOptions()">
						<form:option value="physical" label="Physical" />
						<form:option value="digital" label="Digital" />
						<form:option value="bundle" label="Bundle" />
					</form:select>
					<form:errors path="isbnType" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="isbnOptionsPhysical">
				<div class="form-group">
					<form:label path="isbnPhysical">ISBN Physical:</form:label>
					<form:select path="isbnPhysical" name="isbnPhysical"
						id="isbnPhysical">
						<!-- Options will be populated dynamically -->
					</form:select>
					<form:errors path="isbnPhysical" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="isbnOptionsDigital">
				<div class="form-group">
					<form:label path="isbnDigital">ISBN Digital:</form:label>
					<form:select path="isbnDigital" name="isbnDigital" id="isbnDigital">
						<!-- Options will be populated dynamically -->
					</form:select>
					<form:errors path="isbnDigital" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="isbnOptionsBundle">
				<div class="form-group">
					<form:label path="isbnBundle">ISBN Bundle:</form:label>
					<form:select path="isbnBundle" name="isbnBundle" id="isbnBundle">
						<!-- Options will be populated dynamically -->
					</form:select>
					<form:errors path="isbnBundle" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3 hidden" id="addIsbnWithQuantityFieldset">
				<div class="form-group">
					<form:label path="addIsbnWithQuantity">Add ISBN with Quantity:</form:label>
					<textarea name="addIsbnWithQuantity" id="addIsbnWithQuantity"
						placeholder="Enter ISBN with quantity" cols="100" rows="3"></textarea>
					<form:errors path="addIsbnWithQuantity" cssClass="error" />
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
					<form:label path="deliveryMode">Delivery Mode:</form:label>
					<form:input type="text" path="deliveryMode" name="deliveryMode"
						placeholder="Enter delivery mode" required="required" />
					<form:errors path="deliveryMode" cssClass="error" />
				</div>
			</fieldset>
			<fieldset class="mb-3">
				<div class="form-group">
					<form:label path="paymentType">Payment Type:</form:label>
					<form:select path="paymentType" name="paymentType" id="paymentType"
						required="required" onchange="toggleCreditCardOptions()">
						<form:option value="poOnly" label="poOnly" />
						<form:option value="poWithCC" label="poWithCC" />
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
			<fieldset class="mb-3">
				<div class="form-group" id="dropshipRadioOptions">
					<form:label path="dropshipRadio">Dropdown Radio Option:</form:label>
					<label> <form:radiobutton path="dropshipRadio"
							name="dropshipRadio" value="yes"/>Yes
					</label> <label> <form:radiobutton path="dropshipRadio"
							name="dropshipRadio" value="no" checked="true"/>  No
					</label>
					<form:errors path="dropshipRadio" cssClass="error" />
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
			populateIsbnOptions();
			toggleIsbnOptions();
			toggleOrderTypeOptions();
			togglePromoCodeField();
			toggleOtherAccountField();
		});

		function toggleOtherAccountField() {
			var accountDropdown = document.getElementById('account').value;
			var otherAccountField = document
					.getElementById('otherAccountField');
			if (accountDropdown === 'Other') {
				otherAccountField.classList.remove('hidden');
			} else {
				otherAccountField.classList.add('hidden');
			}
		}
		function showSuccessMessage() {
			document.getElementById('successMessage').style.display = 'block';
			orderInProgress = true;

		}

		function toggleCreditCardOptions() {
			var paymentType = document.getElementById('paymentType').value;
			var creditCardOptions = document
					.getElementById('creditCardOptions');
			if (paymentType === 'poWithCC') {
				creditCardOptions.classList.remove('hidden');
			} else {
				creditCardOptions.classList.add('hidden');
			}
		}

		function toggleIsbnOptions() {
			var isbnType = document.getElementById('isbnType').value;
			var isbnOptionsPhysical = document
					.getElementById('isbnOptionsPhysical');
			var isbnOptionsDigital = document
					.getElementById('isbnOptionsDigital');
			var isbnOptionsBundle = document
					.getElementById('isbnOptionsBundle');
			isbnOptionsPhysical.classList.add('hidden');
			isbnOptionsDigital.classList.add('hidden');
			isbnOptionsBundle.classList.add('hidden');
			if (isbnType === 'physical') {
				isbnOptionsPhysical.classList.remove('hidden');
			} else if (isbnType === 'digital') {
				isbnOptionsDigital.classList.remove('hidden');
			} else if (isbnType === 'bundle') {
				isbnOptionsBundle.classList.remove('hidden');
			}
		}

		function toggleOrderTypeOptions() {
			var orderType = document.getElementById('orderType').value;
			var addIsbnWithQuantityFieldset = document
					.getElementById('addIsbnWithQuantityFieldset');
			var isbnType = document.getElementById('isbnType');
			var isbnOptionsPhysical = document
					.getElementById('isbnOptionsPhysical');
			var isbnOptionsDigital = document
					.getElementById('isbnOptionsDigital');
			var isbnOptionsBundle = document
					.getElementById('isbnOptionsBundle');
			var isbnTypeField = document.getElementById('isbnTypeField');
			if (orderType === 'fastPacedOrder') {
				addIsbnWithQuantityFieldset.classList.remove('hidden');
				isbnType.classList.add('hidden');
				isbnTypeField.classList.add('hidden');
				isbnOptionsPhysical.classList.add('hidden');
				isbnOptionsDigital.classList.add('hidden');
				isbnOptionsBundle.classList.add('hidden');
			} else {
				addIsbnWithQuantityFieldset.classList.add('hidden');
				isbnTypeField.classList.remove('hidden');
				isbnType.classList.remove('hidden');
				toggleIsbnOptions();
			}
		}

		function populateIsbnOptions() {
			var isbnPhysical = document.getElementById('isbnPhysical');
			var isbnDigital = document.getElementById('isbnDigital');
			var isbnBundle = document.getElementById('isbnBundle');
			var physicalIsbns, digitalIsbns, bundleIsbns;
			if ('${param.store}' === 'B2BCA') {
				physicalIsbns = [ '9780176911140@@NA', '9780176912260@@NA' ];
				digitalIsbns = [ 'NotApplicable' ];
				bundleIsbns = [ '9781778410321@@NA', '9781778410260@@NA' ];
			} else if ('${param.store}' === 'B2BUS') {
				physicalIsbns = [ '9780064431910@@NA', '9780064431620@@NA' ];
				digitalIsbns = [ '9780357103869@@NA', '9780357104026@@NA' ];
				bundleIsbns = [ '9798888039854@@NA', '9798888039861@@NA' ];
			} else if ('${param.store}' === 'B2BGT') {
				physicalIsbns = [ '9780028646855@@NA', '9780028655314@@NA' ];
				digitalIsbns = [ '9781440842511@@NA', '9781440842573@@NA' ];
				bundleIsbns = [ 'notpassed', 'notpassed' ];
			}
			physicalIsbns.forEach(function(isbn) {
				var option = document.createElement('option');
				option.value = isbn;
				option.text = isbn;
				isbnPhysical.appendChild(option);
			});
			digitalIsbns.forEach(function(isbn) {
				var option = document.createElement('option');
				option.value = isbn;
				option.text = isbn;
				isbnDigital.appendChild(option);
			});
			bundleIsbns.forEach(function(isbn) {
				var option = document.createElement('option');
				option.value = isbn;
				option.text = isbn;
				isbnBundle.appendChild(option);
			});
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