require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'class methods' do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant)
      @merch3 = create(:merchant)
      @merch4 = create(:merchant)
      @merch5 = create(:merchant)
      @merch6 = create(:merchant)
      @item1 = @merch1.items.create!(name: 'item1', description: 'first item', unit_price: 5)
      @item2 = @merch2.items.create!(name: 'item2', description: 'first item', unit_price: 10)
      @item3 = @merch3.items.create!(name: 'item3', description: 'first item', unit_price: 15)
      @item4 = @merch4.items.create!(name: 'item4', description: 'first item', unit_price: 20)
      @item5 = @merch5.items.create!(name: 'item5', description: 'first item', unit_price: 25)
      @item6 = @merch6.items.create!(name: 'item6', description: 'first item', unit_price: 30)
      @customer = create(:customer)
      @invoice1 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-07 12:54:24 -0500', updated_at: '2019-02-07 12:54:24 -0500')
      @invoice2 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch2.id, created_at: '2019-02-07 12:54:24 -0500', updated_at: '2019-02-07 12:54:24 -0500')
      @invoice3 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch3.id, created_at: '2019-02-08 12:54:24 -0500', updated_at: '2019-02-08 12:54:24 -0500')
      @invoice4 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch4.id, created_at: '2019-02-08 12:54:24 -0500', updated_at: '2019-02-08 12:54:24 -0500')
      @invoice5 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch5.id, created_at: '2019-02-09 12:54:24 -0500', updated_at: '2019-02-09 12:54:24 -0500')
      @invoice6 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch6.id, created_at: '2019-02-09 12:54:24 -0500', updated_at: '2019-02-09 12:54:24 -0500')
      @i_i1 = InvoiceItem.create!(quantity: 2, unit_price: 6, item_id: @item1.id, invoice_id: @invoice1.id)
      @i_i2 = InvoiceItem.create!(quantity: 4, unit_price: 8, item_id: @item2.id, invoice_id: @invoice2.id)
      @i_i3 = InvoiceItem.create!(quantity: 6, unit_price: 10, item_id: @item3.id, invoice_id: @invoice3.id)
      @i_i4 = InvoiceItem.create!(quantity: 8, unit_price: 12, item_id: @item4.id, invoice_id: @invoice4.id)
      @i_i5 = InvoiceItem.create!(quantity: 10, unit_price: 14, item_id: @item5.id, invoice_id: @invoice5.id)
      @i_i6 = InvoiceItem.create!(quantity: 12, unit_price: 16, item_id: @item6.id, invoice_id: @invoice6.id)
      @transaction1 = @invoice1.transactions.create!(credit_card_number: 1234, credit_card_expiration_date: Time.now, result: 'success')
      @transaction2 = @invoice2.transactions.create!(credit_card_number: 2345, credit_card_expiration_date: Time.now, result: 'success')
      @transaction3 = @invoice3.transactions.create!(credit_card_number: 3456, credit_card_expiration_date: Time.now, result: 'success')
      @transaction4 = @invoice4.transactions.create!(credit_card_number: 4567, credit_card_expiration_date: Time.now, result: 'success')
      @transaction5 = @invoice5.transactions.create!(credit_card_number: 5678, credit_card_expiration_date: Time.now, result: 'success')
      @transaction6 = @invoice6.transactions.create!(credit_card_number: 6789, credit_card_expiration_date: Time.now, result: 'success')
    end

    it '.top_merch_by_revenue' do
      limit = 4

      expect(Merchant.top_merch_by_revenue(limit)).to eq([@merch6, @merch5, @merch4, @merch3])
    end

    it '.top_merch_by_num_sold' do
      limit = 3

      expect(Merchant.top_merch_by_num_sold(limit)).to eq([@merch6, @merch5, @merch4])
    end

    it '.revenue_by_date' do
      date = '2019-02-07'

      expect(Merchant.revenue_by_date(date)).to eq(44.00)
    end
  end
end
