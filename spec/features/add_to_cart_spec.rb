require 'rails_helper'

RSpec.feature "Visitor clicks Add product on home page and sees 1 item added to their cart in nav", type: :feature, js: true do
   # SETUP
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path
    first('.product').find_button('Add').click
    sleep 5

    # DEBUG 
    # save_screenshot

    # VERIFY
    expect(page).to have_content('My Cart (1)')

  end
end