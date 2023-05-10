class CreateUnitTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :unit_types do |t|
      t.string :name

      t.timestamps
    end
    UnitType.create(name: "szt")
    UnitType.create(name: "kg")

  end
end
