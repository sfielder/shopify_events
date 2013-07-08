# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Webhook.create(:address => "app/uninstalled", :format => 'json', :topic => 'app/uninstalled')
Webhook.create(:address => "orders/cancelled", :format => 'json', :topic => 'orders/cancelled')
Webhook.create(:address => "orders/create", :format => 'json', :topic => 'orders/create')
Webhook.create(:address => "orders/delete", :format => 'json', :topic => 'orders/delete')
Webhook.create(:address => "orders/fulfilled", :format => 'json', :topic => 'orders/fulfilled')
Webhook.create(:address => "orders/paid", :format => 'json', :topic => 'orders/paid')
Webhook.create(:address => "orders/partially_fulfilled", :format => 'json', :topic => 'orders/partially_fulfilled')
Webhook.create(:address => "orders/updated", :format => 'json', :topic => 'orders/updated')
Webhook.create(:address => "products/delete", :format => 'json', :topic => 'products/delete')
Webhook.create(:address => "products/update", :format => 'json', :topic => 'products/update')
Webhook.create(:address => "shop/update", :format => 'json', :topic => 'shop/update')


User.create(:name => 'Admin User', :email => 'admin@niimb.us', :password => 'password', :password_confirmation => 'password')




    