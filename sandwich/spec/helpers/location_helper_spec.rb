require "rails_helper"

describe LocationHelper, type: :helper do
  describe "#format_address" do
    let(:source_address) do
      "175 W Jackson Blvd\nChicago, IL 60604"
    end

    let(:expected_address) do
      "<address><span>175 W Jackson Blvd</span><br /><span>Chicago, IL 60604</span></address>"
    end

    it "returns an HTML-formatted address" do
      expect(helper.format_address(source_address)).to eq(expected_address)
    end
  end

  describe "#format_user_location" do
    subject(:formatted_location) { helper.format_user_location(location) }

    context "if location is nil" do
      let(:location) { nil }

      it { is_expected.to be_nil }
    end

    context "if location is not nil" do
      let(:location) { FactoryGirl.build(:location) }

      it "is an address block with just the city information" do
        expect(formatted_location).to eq(
          "<address><span>#{location.city}, #{location.state}  #{location.zip}</span></address>"
        )
      end
    end
  end
end
