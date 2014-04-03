class Order < ActiveRecord::Base
  belongs_to :item
  belongs_to :person
  belongs_to :address
  belongs_to :merchant

  # csv_row
  # ["purchaser name", "item description", "item price", "purchase count",
  #  "merchant address", "merchant name"]
  def data= csv_row
    find_or_create_person   csv_row
    find_or_create_item     csv_row
    find_or_create_address  csv_row
    find_or_create_merchant csv_row
    self.quantity = csv_row["purchase count"]
  end

  def find_or_create_item csv_row
    self.item = Item.find_or_create_by description: csv_row["item description"],
                                       price: csv_row["item price"]
  end

  def find_or_create_address csv_row
    self.address = Address.find_or_create_by line_1: csv_row["merchant address"]
  end

  def find_or_create_merchant csv_row
    self.merchant = Merchant.find_or_create_by name: csv_row["merchant name"]
  end

  def find_or_create_person csv_row
    self.person = Person.find_or_create_by name: csv_row["purchaser name"]
  end
end
