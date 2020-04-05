require 'pry'
class Transfer
  attr_accessor :status, :balance
  attr_reader :sender, :receiver, :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver 
    @amount = amount
    @status = "pending"
  end 
  
  def valid?
    sender.valid? && receiver.valid? && sender.balance > amount ? true : false
  end 
  
  def execute_transaction 
    if valid?
      until self.status == "complete"
        sender.balance -= amount
        receiver.deposit(amount)
        self.status = "complete"
      end
    else
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end 
  end
  
  def reverse_transfer
    if status == "complete"
      receiver.balance -= amount
      sender.deposit(amount)
      self.status = "reversed"
    end 
  end 

end
