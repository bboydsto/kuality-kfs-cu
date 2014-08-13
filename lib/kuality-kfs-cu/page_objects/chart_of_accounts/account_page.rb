#overriding kuality-kfs object
class AccountPage

  element(:subfund_program_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.programCode') }
  element(:major_reporting_category_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.majorReportingCategoryCode') }
  element(:appropriation_account_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.appropriationAccountNumber') }
  element(:labor_benefit_rate_category_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.laborBenefitRateCategoryCode') }

  element(:everify_indicator) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.extension.everify') }
  element(:cost_share_for_project_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.extension.costShareForProjectNumber') }

  value(:original_account_extended_data) do |b|
    {
      subfund_program_code:             b.frm.span(id: 'document.oldMaintainableObject.extension.programCode.div').text.strip,
      major_reporting_category_code:    b.frm.span(id: 'document.oldMaintainableObject.extension.majorReportingCategoryCode.div').text.strip,
      labor_benefit_rate_category_code: b.frm.span(id: 'document.oldMaintainableObject.laborBenefitRateCategoryCode.div').text.strip,
      appropriation_account_number:     b.frm.span(id: 'document.oldMaintainableObject.extension.appropriationAccountNumber.div').text.strip,
      everify_indicator:                yesno2setclear(b.frm.span(id: 'document.oldMaintainableObject.extension.everify.div').text.strip),
      cost_share_for_project_number:    b.frm.span(id: 'document.oldMaintainableObject.extension.costShareForProjectNumber.div').text.strip
    }
  end

  value(:new_account_extended_data) do |b|
    {
        subfund_program_code:             b.subfund_program_code.value,
        major_reporting_category_code:    b.major_reporting_category_code.value,
        appropriation_account_number:     b.appropriation_account_number.value,
        labor_benefit_rate_category_code: b.labor_benefit_rate_category_code.value,
        everify_indicator:                yesno2setclear(b.everify_indicator.set?),
        cost_share_for_project_number:    b.cost_share_for_project_number.value
    }
  end

end
