class ReduceProposalsColumns < ActiveRecord::Migration
    def up
    	change_table :proposals do |t|
	  	  t.remove :preprod_start_date
	  	  t.remove :preprod_end_date
	  	  t.remove :prod_start_date
	  	  t.remove :prod_end_date
	  	  t.remove :postprod_start_date
	  	  t.remove :postprod_end_date
	  	  t.rename :topic, :topic_synopsis
	  	  t.remove :message, :text
	  	  t.rename :conflict, :conflicts
	  	  t.remove :audience_bias
	  	  t.rename :form, :form_style
	  	  t.rename :marketing, :distribution
	  	  t.remove :status
	  	  t.remove :style
	  	end
    end

    def down
    	change_table :proposals do |t|
	  	  t.datetime :preprod_start_date
	  	  t.datetime :preprod_end_date
	  	  t.datetime :prod_start_date
	  	  t.datetime :prod_end_date
	  	  t.datetime :postprod_start_date
	  	  t.datetime :postprod_end_date
	  	  t.rename :topic_synopsis, :topic
	  	  t.text :message
	  	  t.rename :conflicts, :conflict
	  	  t.text :audience_bias
	  	  t.rename :form_style, :form
	  	  t.rename :distribution, :marketing
	  	  t.text :status
	  	  t.text :style
	  	end
    end
end
