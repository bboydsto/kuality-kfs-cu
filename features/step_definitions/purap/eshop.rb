And /^I search for an e\-SHOP item with a Non\-Sensitive Commodity Code$/ do
  on ShopCatalogPage do |page|
    page.choose_hosted_supplier                         'Staples'
    page.hosted_supplier_item_search_box('Staples').fit 'Paper, PASTELS 8.5X11 BLUE PAPER RM'
    page.hosted_supplier_item_search                    'Staples'
  end
end

And /^I add e\-SHOP items to my cart until the cart total reaches the Business to Business Total Amount For Automatic Purchase Order limit$/ do
  on ShopResultsPage do |page|
    target_quantity = ((get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_AUTO_PO', 'Requisition').first.to_f -
                        page.cart_total_value.to_f) /
                        21.26).ceil
    target_quantity.should be > 0, 'There are already one or more items in your shopping cart such that we cannot add an additional item!'
    page.item_quantity(0).fit target_quantity
    page.add_item(0)
    page.cart_total_value.to_f.should be >= get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_AUTO_PO', 'Requisition').first.to_f
    page.cart_total_value.to_f.should be < get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_SUPER_USER_AUTO_PO', 'Requisition').first.to_f
  end
end

And /^I add a note to my e\-SHOP cart$/ do
  # You must already be in the e-SHOP section of KFS
  on(EShopPage).goto_cart
  on(ShopCartPage).add_note_to_cart 'Wow! That is a sweet note, you might say!'
  on(ShopCartPage).cart_status_message.should == 'Cart was saved successfully'
end

And /^I submit my e\-SHOP cart$/ do
  on ShopCartPage do |scp|
    @eshop_cart = make EShopCartObject
    @eshop_cart.absorb
    scp.submit_shopping_cart
  end

  # Surprise! This should kick you out to a Requisition document.
  on(RequisitionPage).doc_title.should be 'Requistion'
  @requisition = make RequisitionObject
  # @requisition.absorb :new # Hopefully, we can #absorb this mutha
end

Then /^Payment Request Positive Approval Required is checked$/ do
  on(RequisitionPage).payment_request_positive_approval_required.checked?.should
end

And /^the e\-SHOP cart has an associated Requisition document$/ do
  # We're actually expecting to be on said Requisition document during this check
  on(RequisitionPage).description.should == @eshop_cart.cart_name
end

When /^I go to the e\-SHOP main page$/ do
  visit(MainPage).e_shop
end

When /^I view my e\-SHOP cart$/ do
  on(EShopPage).goto_cart
  on(ShopCartPage) do |scp|
    s = 'PerkinElmer Life and Analytical Sciences'
    scp.supplier_lines.each{|sl| puts sl.text; }
    puts '======'
    puts scp.line_items_table_for(s).header_keys.keep_if{ |k| k != :'' }
    puts '======'

    puts scp.line_items_for(s)[0].tds.to_a.keep_if{ |r| !r.text.empty? }.collect{|td| td.text}

    puts '======'
    puts scp.line_item_values('PerkinElmer Life and Analytical Sciences', 0)
    puts '======'
    #puts scp.line_item_values('Staples', 0)

    scp.delete_product('PerkinElmer Life and Analytical Sciences', 0)
    # puts scp.line_item_values('PerkinElmer Life and Analytical Sciences', 1).inspect

    #scp.update_product_quantity('PerkinElmer Life and Analytical Sciences', 'N9316232').fit '2'
  end
  pending
end