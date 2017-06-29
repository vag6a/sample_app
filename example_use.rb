class User
    attr_accessor :name, :email

    def initialize(attr = {})
        @name = attr[:name]
        @email = attr[:email]
    end

    def formatted_email
        "#{@name} <#{@email}>"
    end
end
