require 'rspec/autorun'

class PaymentAccount
  attr_accessor :name, :amount

  def initialize(name, amount)
    @name = name
    @amount = amount
  end

  def deposit(amount)
    # Pretend things happen here
  end
end

class PaymentSplitter
  def initialize(split_type, payment_accounts)
    @payment_accounts=payment_accounts
    @split_type=split_type
    doit
  end
  def credit(total)
    @total=total
    doit
  end

  def doit
    leftover=@total
    @payment_accounts.each do |account|
      name,amt=account.name,account.amount
      if amt.nil?
        amt=leftover
      else
        leftover -=amt  
        account.deposit(leftover)
      end
      
    end
    
  end
  # Implement me!

end

RSpec.describe PaymentSplitter do

  subject(:payment_splitter) do
    PaymentSplitter.new(split_type, payment_accounts)
  end

  context 'by amounts' do
    let(:split_type) { :amount }
    let(:payment_accounts) do
      [
        PaymentAccount.new('Bank 1', 500.0),
        PaymentAccount.new('Bank 2', 1500.0),
        PaymentAccount.new('Bank 3', nil)
      ]
    end

    it 'can split $400' do
      # the first payment account should have 400$ deposited into it
      expect(payment_accounts[0]).to receive(:deposit).with(400.00)
      #payment_accounts[0].deposit(400)
      # the second payment account should not have any deposits
      expect(payment_accounts[1]).not_to receive(:deposit)
      # the third payment account should not have any deposits
      expect(payment_accounts[2]).not_to receive(:deposit)
      payment_splitter.credit(400)
    end # verified here

    it 'can split $1000' do
      expect(payment_accounts[0]).to receive(:deposit).with(500.00)
      expect(payment_accounts[1]).to receive(:deposit).with(500.00)
      expect(payment_accounts[2]).not_to receive(:deposit).with(0.00)
      payment_splitter.credit(1000)
    end

    it 'can split $3200' do
      expect(payment_accounts[0]).to receive(:deposit).with(500.00)
      expect(payment_accounts[1]).to receive(:deposit).with(1500.00)
      expect(payment_accounts[2]).to receive(:deposit).with(1200.00)
      payment_splitter.credit(3200)
    end
  end

  context 'by percentage' do
    let(:split_type) { :percentage }
    let(:payment_accounts) do
      [
        PaymentAccount.new('Bank 1', 0.200),
        PaymentAccount.new('Bank 2', 0.405),
        PaymentAccount.new('Bank 3', 0.395)
      ]
    end

    it 'can split $100 based on percentages' do
      expect(payment_accounts[0]).to receive(:deposit).with(20.00)
      expect(payment_accounts[1]).to receive(:deposit).with(40.50)
      expect(payment_accounts[2]).to receive(:deposit).with(39.50)
      payment_splitter.credit(100)
    end

    it 'floors to the nearest cent' do
      expect(payment_accounts[0]).to receive(:deposit).with(160.20)
      expect(payment_accounts[1]).to receive(:deposit).with(324.40)
      payment_splitter.credit(801)
    end

    it 'adds leftover cents to the last account (after flooring)' do
      expect(payment_accounts[0]).to receive(:deposit).with(124.19)
      expect(payment_accounts[1]).to receive(:deposit).with(251.49)
      expect(payment_accounts[2]).to receive(:deposit).with(245.29)
      payment_splitter.credit(620.97)
    end
  end
end
