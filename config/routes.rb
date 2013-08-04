# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get "/share/:digest", :to => "share_files#download", :as => :share_download

get "/projects/:project_id/share_files/edit/:attachment_id", :to => "share_files#edit", :as => :share_file
post "/projects/:project_id/share_files/edit/:attachment_id", :to => "share_files#update", :as => :share_update
