require 'spec_helper'

describe PageviewsController, type: :controller do

  it 'increment pageviews' do

    article = FactoryGirl.create(
      :post, slug: "slug#{Time.now.to_i}", published: true
    )
    item = ListItem.find_by(resource_type: 'Post', slug: article.slug)
    post :create, resource_type: 'Post', resource_id: article.id

    expect(article.get_pageviews).to eql(1)
    expect(item.get_pageviews).to eql(1)

  end

end

