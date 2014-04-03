require 'csv'

class ImportsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    #binding.pry
    csv_data = CSV.read params['uploaded_file'].tempfile, col_sep: "\t",
                                       headers: true,
                                       converters: [:numeric]
    csv_data.each {|row| Order.create data: row }
    @gross = csv_data.inject(0) do |sum, row|
               sum + row["item price"] * row["purchase count"]
             end
  end
end
