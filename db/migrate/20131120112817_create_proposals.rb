class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :topic
      t.string :premise
      t.string :message
      t.string :outline
      t.string :conflict
      t.string :audience_bias
      t.string :characters
      t.string :interviews
      t.date :preprod_start_date
      t.string :time
      t.date :preprod_end_date
      t.string :time
      t.date :prod_start_date
      t.string :time
      t.datetime :prod_end_date
      t.datetime :postprod_start_date
      t.datetime :postprod_end_date
      t.string :form
      t.string :style
      t.string :resolution
      t.string :differentiation
      t.string :marketing
      t.string :status
      t.references :project, index: true

      t.timestamps
    end
  end
end
