#overriding kuality-kfs object
class AccountPage

  element(:subfund_program_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.programCode') }
  element(:major_reporting_category_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.majorReportingCategoryCode') }
  element(:appropriation_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.appropriationAccountNumber') }
  element(:labor_benefit_rate_category_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.laborBenefitRateCategoryCode') }
  element(:everify_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.extension.everify') }
  element(:cost_share_for_project_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.costShareForProjectNumber') }
  element(:invoice_frequency_code) { |b| b.frm.select(name: 'document.newMaintainableObject.extension.invoiceFrequencyCode') }
  element(:invoice_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.extension.invoiceTypeCode') }

  # New
  value(:new_subfund_program_code) { |b| b.subfund_program_code.value }
  value(:new_major_reporting_category_code) { |b| b.major_reporting_category_code.value }
  value(:new_appropriation_account_number) { |b| b.appropriation_account_number.value }
  value(:new_labor_benefit_rate_category_code) { |b| b.labor_benefit_rate_category_code.value }
  value(:new_everify_indicator) { |b| yesno2setclear(b.everify_indicator.set?) }
  value(:new_cost_share_for_project_number) { |b| b.cost_share_for_project_number.value }
  value(:new_invoice_frequency_code) { |b| b.invoice_frequency_code.selected_options.first.text }
  value(:new_invoice_type_code) { |b| b.invoice_type_code.selected_options.first.text }

  # Old
  value(:old_subfund_program_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.extension.programCode.div').text.strip }
  value(:old_major_reporting_category_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.extension.majorReportingCategoryCode.div').text.strip }
  value(:old_appropriation_account_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.extension.appropriationAccountNumber.div').text.strip }
  value(:old_labor_benefit_rate_category_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.laborBenefitRateCategoryCode.div').text.strip }
  value(:old_everify_indicator) { |b| yesno2setclear(b.frm.span(id: 'document.oldMaintainableObject.extension.everify.div').text.strip) }
  value(:old_cost_share_for_project_number) { |b| b.frm.span(id: 'document.oldMaintainableObject.extension.costShareForProjectNumber.div').text.strip }
  value(:old_invoice_frequency_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.extension.invoiceFrequencyCode.div').text.strip }
  value(:old_invoice_type_code) { |b| b.frm.span(id: 'document.oldMaintainableObject.extension.invoiceTypeCode.div').text.strip }


  # Read-Only
  value(:readonly_subfund_program_code) { |b| b.frm.span(id: 'document.newMaintainableObject.extension.programCode.div').text.strip }
  value(:readonly_major_reporting_category_code) { |b| b.frm.span(id: 'document.newMaintainableObject.extension.majorReportingCategoryCode.div').text.strip }
  value(:readonly_appropriation_account_number) { |b| b.frm.span(id: 'document.newMaintainableObject.extension.appropriationAccountNumber.div').text.strip }
  value(:readonly_labor_benefit_rate_category_code) { |b| b.frm.span(id: 'document.newMaintainableObject.laborBenefitRateCategoryCode.div').text.strip }
  value(:readonly_everify_indicator) { |b| yesno2setclear(b.frm.span(id: 'document.newMaintainableObject.extension.everify.div').text.strip) }
  value(:readonly_cost_share_for_project_number) { |b| b.frm.span(id: 'document.newMaintainableObject.extension.costShareForProjectNumber.div').text.strip }
  value(:readonly_invoice_frequency_code) { |b| b.frm.span(id: 'document.newMaintainableObject.extension.invoiceFrequencyCode.div').text.strip }
  value(:readonly_invoice_type_code) { |b| b.frm.span(id: 'document.newMaintainableObject.extension.invoiceTypeCode.div').text.strip }

  value(:old_account_extended_data) do |b|
    {
      subfund_program_code:             b.old_subfund_program_code,
      major_reporting_category_code:    b.old_major_reporting_category_code,
      labor_benefit_rate_category_code: b.old_labor_benefit_rate_category_code,
      appropriation_account_number:     b.old_appropriation_account_number,
      everify_indicator:                b.old_everify_indicator,
      cost_share_for_project_number:    b.old_cost_share_for_project_number,
      invoice_frequency_code:           b.old_invoice_frequency_code,
      invoice_type_code:                b.old_invoice_type_code
    }
  end

  value(:new_account_extended_data) do |b|
    {
      subfund_program_code:             (b.subfund_program_code.exists? ? b.new_subfund_program_code : b.readonly_subfund_program_code),
      major_reporting_category_code:    (b.major_reporting_category_code.exists? ? b.new_major_reporting_category_code : b.readonly_major_reporting_category_code),
      appropriation_account_number:     (b.appropriation_account_number.exists? ? b.new_appropriation_account_number : b.readonly_appropriation_account_number),
      labor_benefit_rate_category_code: (b.labor_benefit_rate_category_code.exists? ? b.new_labor_benefit_rate_category_code : b.readonly_labor_benefit_rate_category_code),
      everify_indicator:                (b.everify_indicator.exists? ? b.new_everify_indicator : b.readonly_everify_indicator),
      cost_share_for_project_number:    (b.cost_share_for_project_number.exists? ? b.new_cost_share_for_project_number : b.readonly_cost_share_for_project_number),
      invoice_frequency_code:           (b.invoice_frequency_code.exists? ? b.new_invoice_frequency_code : b.readonly_invoice_frequency_code),
      invoice_type_code:                (b.invoice_type_code.exists? ? b.new_invoice_type_code : b.readonly_invoice_type_code)
    }
  end

  value(:readonly_account_extended_data) do |b|
    {
      subfund_program_code:             b.readonly_subfund_program_code,
      major_reporting_category_code:    b.readonly_major_reporting_category_code,
      appropriation_account_number:     b.readonly_appropriation_account_number,
      labor_benefit_rate_category_code: b.readonly_labor_benefit_rate_category_code,
      everify_indicator:                b.readonly_everify_indicator,
      cost_share_for_project_number:    b.readonly_cost_share_for_project_number,
      invoice_frequency_code:           b.readonly_invoice_frequency_code,
      invoice_type_code:                b.readonly_invoice_type_code
    }
  end

end
