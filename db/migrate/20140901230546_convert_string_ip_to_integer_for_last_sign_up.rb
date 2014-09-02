class ConvertStringIpToIntegerForLastSignUp < ActiveRecord::Migration
    def up
      User.all.each do |u|
        if u.last_sign_in_ip.blank?
          as_int = nil
        else
          quads = u.last_sign_in_ip.split('.')
          if quads.length == 4
          as_int = (quads[0].to_i * (2**24)) + (quads[1].to_i * (2**16)) + (quads[2].to_i * (2**8)) + quads[3].to_i
          as_int -= 4_294_967_296 if as_int > 2147483647 # Convert to 2's complement
          else
           as_int = nil
          end
        end
        u.last_sign_in_ip = as_int
        u.save
      end
     
      change_column :users, :last_sign_in_ip, :integer
    end

    def down
      change_column :users, :last_sign_in_ip, :string
    end
end
