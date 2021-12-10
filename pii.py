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
	this.paymentTerms = paymentTerms;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;

		def dispatch(self, request, *args, **kwargs):
        mode = self.kwargs["mode"]
        order = self.object = self.get_object()
        payment_method = order.payment_method if order.payment_method_id else None
        if mode == "payment":
            if not order.is_paid():
                if payment_method:
		title = _("Payment Provider")
    text = _("To start accepting payments right away, please add payment methods for your shop")
    icon = "shuup_admin/img/payment.png"
    service_model = PaymentMethod
    base_name = "payment_method_base"
    provider_label = _("payment method")
    form_def_provide_key = "payment_processor_wizard_form_def"
