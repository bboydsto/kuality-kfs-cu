#overriding kuality-kfs object
class AccountObject

  attr_accessor :subfund_program_code

  def fill_out_extended_attributes(attribute_group=nil)
    #case attribute_group # Don't actually use this yet.
    #  else
        # These should map to non-required, or otherwise un-grouped attributes
        on(AccountPage) { |p| fill_out p, :subfund_program_code }
    #end
  end

end
