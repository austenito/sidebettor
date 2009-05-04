Factory.define :default_user , :class => User do |u|
  u.login "default"
  u.password "default"
  u.password_confirmation "default"
  u.email "default@default.com"
  u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
end

Factory.define :admin_user , :class => User do |u|
  u.login "admin"
  u.password "admin"
  u.password_confirmation "admin"
  u.email "admin@admin.com"
  u.single_access_token "k3cFzLIQnZ4MHRmJvJzh"
end

Factory.define :invalid_user , :class => User do |u|
end