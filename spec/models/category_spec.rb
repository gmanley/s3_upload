require 'spec_helper'

describe Category do
  it { should reference_many(:albums) }
  it { should reference_many(:child_categories).of_type(Category).as_inverse_of(:parent_category).with_foreign_key(:parent_category_id) }
  it { should be_referenced_in(:parent_category).of_type(Category).as_inverse_of(:child_categories).with_index }

  context 'that exists' do
    let(:category) { Fabricate(:category) }

    it "should be a valid record" do
      category.should be_valid
    end

    it "should have a title" do
      category.title.should be_kind_of(String)
    end

    it "should have a valid url slug" do
      ERB::Util.url_encode(category.slug).should == category.slug
    end
  end
end
