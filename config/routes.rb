Spree::Core::Engine.add_routes do
  post '/spree_privacygate/notify', to: "privacygate#notify"
end
