class Subscription < ActiveRecord::Base
  include Koudoku::Subscription


  belongs_to :user
  belongs_to :coupon, optional: true
  belongs_to :plan, optional: true

end
