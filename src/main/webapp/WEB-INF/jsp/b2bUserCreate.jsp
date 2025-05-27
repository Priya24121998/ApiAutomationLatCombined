<%@ include file="common/header.jspf"%>
<%@ include file="common/backToHome.jspf"%>
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
</style>
<script type="text/javascript">
	function showSuccessMessage() {
		alert("User details submitted successfully");
	}

	document.addEventListener('DOMContentLoaded', function() {
		toggleFields();
	});

	function toggleFields() {
		var noOfUsersType = document.getElementById("noOfUsersType").value;
		var userAccountDiv = document.getElementById("userAccount");
		var multipleFields = document.getElementById("multipleFields");

		if (noOfUsersType === "Single") {
			userAccountDiv.style.display = "block";
			multipleFields.style.display = "none";
		} else if (noOfUsersType === "Multiple") {
			userAccountDiv.style.display = "block";
			multipleFields.style.display = "block";
		} else {
			userAccountDiv.style.display = "none";
			multipleFields.style.display = "none";
		}
	}
</script>
</head>
<body>
	<div class="form-container">
		<h1>Create User</h1>
		<form:form method="post" modelAttribute="userCreationAtt"
			action="create-b2b-user?store=${param.store}" id="userForm"
			onsubmit="showSuccessMessage()">
			<input type="hidden" name="id" value="${userCreationAtt.id}">
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
					<form:label path="noOfUsersType">Number of Users Type:</form:label>
					<form:select path="noOfUsersType" id="noOfUsersType"
						name="noOfUsersType" onchange="toggleFields()">
						<form:option value="" label="Select Type" />
						<form:option value="Single" label="Single" />
						<form:option value="Multiple" label="Multiple" />
					</form:select>
					<form:errors path="noOfUsersType" cssClass="error" />
				</div>
				<div class="form-group">
					<form:label path="userAccount">User Account:</form:label>
					<form:select path="userAccount" id="userAccount" name="userAccount"
						required="required">
						<form:option value="" label="Select Account" />
						<c:forEach var="userAccount" items="${staticUserAccounts}">
							<form:option value="${userAccount}" label="${userAccount}" />
						</c:forEach>
					</form:select>
					<form:errors path="userAccount" cssClass="error" />
				</div>
				<div id="singleFields" style="display: none;"></div>
				<div id="multipleFields" style="display: none;">
					<fieldset class="mb-3">
						<div class="form-group">
							<form:label path="numberOfUsers">Number of Users:</form:label>
							<input type="number" id="numberOfUsers" name="numberOfUsers"
								min="1" />
						</div>
					</fieldset>
				</div>
			</fieldset>
			<input type="submit" value="Submit" />
		</form:form>
	</div>
	<%@ include file="common/footer.jspf"%>
</body>
</html>