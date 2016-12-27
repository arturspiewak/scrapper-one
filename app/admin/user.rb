ActiveAdmin.register User do

  permit_params :email, :role

    index do
        column :email
        column :current_sign_in_at
        column :last_sign_in_at
        column :sign_in_count
        column :role
        actions
    end

    filter :email

    form do |f|
        f.inputs "User Details" do
            f.input :email
            f.input :role, as: :radio, collection: { Admin: "admin", Normal: 'normal', Premium: 'premium', Premium_Plus: 'premium_plus'}
        end
        f.actions
    end

end
