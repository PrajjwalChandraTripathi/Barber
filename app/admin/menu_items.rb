ActiveAdmin.register MenuItem do 
    permit_params :service, :shop_id, :gender

    form do |f|
        f.inputs "Menu Items Service" do
            f.input :gender
            f.input :service
        end
        f.actions
    end

    index do 
        selectable_column
        id_column
        column :gender
        column :service
        actions
    end
end