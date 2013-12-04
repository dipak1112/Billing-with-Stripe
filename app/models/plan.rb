class Plan < ActiveRecord::Base

  has_many :subscriptions
  
	validates :name, :plan_code, :presence => true, :uniqueness => true
	validates :price, :presence => true, :numericality => true

	after_create :plan_create_in_stripe
  before_destroy :delete_plan_from_stripe
	after_save     :update_plan_from_stripe

	def plan_create_in_stripe
    Stripe::Plan.create(
	    :amount => self.price,
	    :interval => 'month',
	    :name => self.name,
	    :currency => 'usd',
	    :id => self.plan_code
	  )
  end

  def delete_plan_from_stripe
  	begin
    	plan = Stripe::Plan.retrieve(self.plan_code)
    	plan.delete if plan.present?
    rescue
    end
  end

	def update_plan_from_stripe
    plan = Stripe::Plan.retrieve(self.plan_code)
    if plan.present?
      plan.name = self.name
      plan.save
    end
  end

end
