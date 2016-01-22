require "rails_helper"

describe MenuHelper, type: :helper do
  let(:menu) do
    FactoryGirl.create(:menu, :with_items)
  end

  before(:each) do
    FactoryGirl.create_list(:menu_item, 10,
                            menu_group: "Beverages",
                            menu: menu)
    FactoryGirl.create_list(:menu_item, 10,
                            menu_group: "Appetizers",
                            menu: menu)
    FactoryGirl.create_list(:menu_item, 10,
                            menu_group: "Wraps",
                            menu: menu)
    FactoryGirl.create_list(:menu_item, 10,
                            menu_group: "Platters",
                            menu: menu)
  end

  describe "#each_column" do
    let(:output) { spy("output") }

    it "divides the menu items into two columns and executes the block for both" do
      helper.each_column(menu) do |column|
        output.write(column)
      end

      expect(output).to have_received(:write).twice
    end
  end

  describe "#menu_heading_id" do
    subject(:heading_id) { helper.menu_heading_id(menu) }

    it "includes the menu ID" do
      expect(heading_id).to include(menu.id.to_s)
    end

    it "includes the camelized menu name" do
      expect(heading_id).to include(menu.name.camelize)
    end
  end

  describe "#menu_collapse_id" do
    subject(:collapse_id) { helper.menu_collapse_id(menu) }

    it "includes the menu ID" do
      expect(collapse_id).to include(menu.id.to_s)
    end

    it "includes the camelized menu name" do
      expect(collapse_id).to include(menu.name.camelize)
    end
  end
end
