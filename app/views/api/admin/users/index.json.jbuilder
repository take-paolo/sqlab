json.array! @users do |user|
  json.extract! user, :id, :name, :email, :role, :created_at, :updated_at
  json.role I18n.t("enums.user.role.#{user.role}")
end
