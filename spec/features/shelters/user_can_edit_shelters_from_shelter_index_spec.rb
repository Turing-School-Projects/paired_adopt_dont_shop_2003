require 'rails_helper'

RSpec.describe "Shelter Index Page", type: :feature do
  it "Can edit shelters from the shelter index page" do
    shelter = Shelter.create(name: "Fido Shelter",
                             address: "12888 Grover Drive",
                             city: "Dody Vale",
                             state: "Dog Twon",
                             zip: 74599)

    visit "/shelters"
    click_link("Update Shelter")
    expect(current_path).to have_content("/shelters/#{shelter.id}/edit")
    fill_in 'name', with: "Kanine Land"
    fill_in 'address', with: "3423 Kaine Street"
    fill_in 'city', with: "Kanine Vale"
    fill_in 'state', with: "Kainine"
    fill_in 'zip', with: 32422
    click_on 'submit'
    expect(current_path).to have_content("/shelters/#{shelter.id}")
    expect(page).to have_content("Kanine Land")
    expect(page).to have_content("3423 Kaine Street")
    expect(page).to have_content("Kanine Vale")
    expect(page).to have_content("Kainine")
    expect(page).to have_content(32422)
  end

  it "displays a flash message indicating missing fields on incomplete edit forms" do
    shelter = Shelter.create(name: "Fido Shelter",
                             address: "12888 Grover Drive",
                             city: "Dody Vale",
                             state: "Dog Twon",
                             zip: 74599)
    visit "/shelters/#{shelter.id}/edit"

    fill_in :name, with: ""
    click_on 'submit'
    expect(page).to have_content("Please fill in name")

    fill_in :address, with: ""
    click_on 'submit'
    expect(page).to have_content("Please fill in address")

    fill_in :city, with: ""
    fill_in :name, with: ""
    fill_in :address, with: ""
    click_on 'submit'
    expect(page).to have_content("Please fill in name, address, city")

    fill_in :city, with: "Denver"
    fill_in :name, with: "Sunny's Shelter"
    fill_in :address, with: "123 Sunset Blvd"
    click_on 'submit'
    
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("Denver")
    expect(page).to have_content("Sunny's Shelter")
    expect(page).to have_content("123 Sunset Blvd")
  end
end
