require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context "given first_name, last_name, email, password, and password_confirmation" do
      it "saves successfully" do
        @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
        expect(User.count).to eq(1)
        expect(@user.errors.full_messages.length).to eq(0)
      end
    end

    context "create user without giving first_name" do
      it "does not save & has error 'First name can't be blank'" do
        @user = User.create(first_name: nil, last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
        expect(User.count).to eq(0)
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end

    context "create user without giving last_name" do
      it "does not save & has error 'Last name can't be blank'" do
        @user = User.create(first_name: "Kato", last_name: nil, email: "kato@email.ca", password: "password", password_confirmation: "password")
        expect(User.count).to eq(0)
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    context "create user without giving email" do
      it "does not save and has error 'Email can't be blank'" do
        @user = User.create(first_name: "Kato", last_name: "Potato", email: nil, password: "password", password_confirmation: "password")
        expect(User.count).to eq(0)
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    context "create user without giving password" do
      it "does not save and has error 'Password can't be blank'" do
        @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: nil, password_confirmation: "password")
        expect(User.count).to eq(0)
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    context "create user without giving password_confirmation" do
      it "does not save and has error 'Password confirmation can't be blank'" do
        @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: nil)
        expect(User.count).to eq(0)
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context "given a case insensitive duplicate email" do
      it "does not save & has error 'Email has already been taken'" do
        @user1 = User.create(first_name: "Kato", last_name: "Potato", email: "KATO@email.ca", password: "password", password_confirmation: "password")
        @user2 = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
        expect(User.count).to eq(1)
        expect(@user2.errors.full_messages).to include("Email has already been taken")

  end
end

context "given password with less than 8 characters" do
  it "does not save and has error 'Password confirmation can't be blank'" do
    @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "1234567", password_confirmation: "1234567")
    # puts "Min Password Error: #{@user.errors.full_messages}"
    expect(User.count).to eq(0)
    expect(@user.errors.full_messages).to include(/Password is too short/i)
  end
end

describe '.authenticate_with_credentials' do
  context "given matching user email and password" do
    it "returns an instance of the user" do
      @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
      user = User.authenticate_with_credentials("kato@email.ca", "password")
      expect(user).to eq(@user)
    end
  end

  context "given email that does not exist" do
    it "returns nil" do
      @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
      user = User.authenticate_with_credentials("potato@email.ca", "password")
      expect(user).to be nil 
    end
  end

  context "given incorrect password for existing email" do
    it "returns nil" do
      @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
      user = User.authenticate_with_credentials("kato@email.ca", "wrongpassword")
      expect(user).to be nil 
    end
  end

  context "given email with white space around it" do
    it "returns an instance of the user" do
      @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
      user = User.authenticate_with_credentials("     kato@email.ca    ", "password")
      expect(user).to eq(@user)
    end
  end

  context "given existing email with wrong casing" do
    it "returns an instance of the user" do
      @user = User.create(first_name: "Kato", last_name: "Potato", email: "kato@email.ca", password: "password", password_confirmation: "password")
      user = User.authenticate_with_credentials("KATO@email.ca", "password")
      expect(user).to eq(@user)
    end
  end

end

end