require 'spec_helper'

describe Order do
  describe '#data=' do
    let(:csv_row) { {"purchaser name"   => "Snake Plissken",
                     "item description" => "$10 off $20 of food",
                     "item price"       => 10.0,
                     "purchase count"   => 2,
                     "merchant address" => "987 Fake St",
                     "merchant name"    => "Bob's Pizza"
                  } }
    let(:order) { Order.new }

    it 'delegates to find_or_create_person' do
      order.should_receive(:find_or_create_person)
      order.data = csv_row
    end

    it 'delegates to find_or_create_item' do
      order.should_receive(:find_or_create_item)
      order.data = csv_row
    end

    it 'delegates to find_or_create_address' do
      order.should_receive(:find_or_create_address)
      order.data = csv_row
    end

    it 'delegates to find_or_create_merchant' do
      order.should_receive(:find_or_create_merchant)
      order.data = csv_row
    end

    describe 'assigns the associations correctly' do
      let(:person)   { Person.find_by name: csv_row["purchaser name"] }
      let(:item)     { Item.find_by description: csv_row["item description"],
                                    price: csv_row["item price"] }
      let(:address)  { Address.find_by line_1: csv_row["merchant address"] }
      let(:merchant) { Merchant.find_by name: csv_row["merchant name"] }
      let(:order)    { Order.new data: csv_row }

      specify { order.person.id   == person.id }
      specify { order.item.id     == item.id }
      specify { order.address.id  == address.id }
      specify { order.merchant.id == merchant.id }
    end
  end

  # testing the find_or_create_* methods individually is unnecessary
  # the methods are simply assigning the results of an ActiveRecord call to
  # an association
end
