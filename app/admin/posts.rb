ActiveAdmin.register Post do
  permit_params :title, :content, :user_id
end
