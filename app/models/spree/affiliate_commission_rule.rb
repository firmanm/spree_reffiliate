module Spree
  class AffiliateCommissionRule < Spree::Base
    belongs_to :affiliate, class_name: 'Spree::Affiliate'
    belongs_to :commission_rule, class_name: 'Spree::CommissionRule'

    validates :affiliate, :commission_rule, presence: true
    validates :affiliate_id, uniqueness: { scope: :commission_rule_id, allow_blank: true }

    before_create :assign_type_of_commission, on: :create

    scope :active, -> { where(active: true) }
    scope :user_registration, -> { includes(:commission_rule).where(spree_commission_rules: { name: Spree::CommissionRule::USER_REGISTRATION }) }
    scope :order_placement, ->   { includes(:commission_rule).where(spree_commission_rules: { name: Spree::CommissionRule::ORDER_PLACEMENT }) }

    def assign_type_of_commission
        self.fixed_commission = commission_rule.fixed_commission
    end
  end
end