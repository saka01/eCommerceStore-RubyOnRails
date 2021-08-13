RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "given name, price, quantity, and category" do
      it "saves successfully" do
        @category = Category.new
        @product = Product.create(name: "chicken harness", price: 35, quantity: 30, category: @category)
        expect(Product.count).to eq(1)
        expect(@product.errors.full_messages.length).to eq(0)
      end
    end

    context "create product without giving category" do
      it "does not save & has error 'Category can't be blank'" do
        @category = Category.new
        @product = Product.create(name: "chicken harness", price: 35, quantity: 30, category: nil)
        expect(Product.count).to eq(0)
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

    context "create product without giving quantity" do
      it "does not save & has error 'Quantity can't be blank'" do
        @category = Category.new
        @product = Product.create(name: "chicken harness", price: 35, quantity: nil, category: @category)
        expect(Product.count).to eq(0)
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context "create product without giving price" do
      it "does not save & has error 'Price can't be blank'" do
        @category = Category.new
        @product = Product.create(name: "chicken harness", price: nil, quantity: 30, category: @category)
        expect(Product.count).to eq(0)
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context "create product without giving name" do
      it "does not save & has error 'Name can't be blank'" do
        @category = Category.new
        @product = Product.create(name: nil, price: 35, quantity: 30, category: @category)
        expect(Product.count).to eq(0)
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

  end
  end
end