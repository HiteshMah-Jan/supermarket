int boys = 0;
    int girls = 0;
    for (Student s : lst) {
        if (s.gender.startsWith("M")) {
            boys++;
        }
        else {

            @DisplayGroup(gridCount = 6, title = "Name", fields = { "lastName",
				"firstName", "middleInitial" }),
		@DisplayGroup(gridCount = 4, title = "Student Info", fields = {
				"birthDate", "age", "placeOfBirth", "nationality",
				"ifAlienAcrNo", "acrPlaceIssued", "acrDateIssued", "religion" }),
		@DisplayGroup(gridCount = 4, title = "Contact", fields = {
				"mobilePhone", "email", "im1", "im2", "contactNumber",
