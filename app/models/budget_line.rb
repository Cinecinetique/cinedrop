class BudgetLine < ActiveRecord::Base
  belongs_to :budget
  belongs_to :resource
end
