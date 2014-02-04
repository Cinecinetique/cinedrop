class FixProposalsColumns < ActiveRecord::Migration
  def up
  	change_table :proposals do |t|
	  t.remove :time
	  t.change :preprod_start_date, :datetime
	  t.change :preprod_end_date, :datetime
	  t.change :prod_start_date, :datetime
	  t.change :topic, :text
	  t.change :premise, :text
	  t.change :message, :text
	  t.change :outline, :text
	  t.change :conflict, :text
	  t.change :audience_bias, :text
	  t.change :characters, :text
	  t.change :interviews, :text
	  t.change :form, :text
	  t.change :style, :text
	  t.change :resolution, :text
	  t.change :differentiation, :text
	  t.change :marketing, :text
	  t.change :status, :text
	end
  end

  def down
  	change_table :proposals do |t|
	  t.string :time
	  t.change :preprod_start_date, :date
	  t.change :preprod_end_date, :date
	  t.change :prod_start_date, :date
	  t.change :topic, :string
	  t.change :premise, :string
	  t.change :message, :string
	  t.change :outline, :string
	  t.change :conflict, :string
	  t.change :audience_bias, :string
	  t.change :characters, :string
	  t.change :interviews, :string
	  t.change :form, :string
	  t.change :style, :string
	  t.change :resolution, :string
	  t.change :differentiation, :string
	  t.change :marketing, :string
	  t.change :status, :string
	end
  end
end
