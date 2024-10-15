module Users
  class Create < ActiveInteraction::Base
    string :name, :patronymic, :email, :nationality, :country, :gender, :surname, :interests, :skills
    integer :age

    validates :name, :patronymic, :email, :nationality, :country, :gender, :age, presence: true
    validates :age, inclusion: { in: 0..89 }
    validates :gender, inclusion: { in: %w[male female] }

    def execute
      return errors.messages.merge!(email: ['already exist']) if User.find_by(email: email)

      # C full_name не понятно как поле называется в бд. В моей будет так.
      user = User.create(user_params.merge(full_name: "#{surname} #{name} #{patronymic}"))
      # Странно, что интересы не сплитятся, как будто тут должно было быть более одного на входе
      user.interests = Interest.where(name: interests)
      user.skills = Skill.where(name: skills.split(','))
    end

    # Люблю в контроллерах создавать функции model_params, считаю это good, даже если речь идет только об одном месте
    # применения. Это не контроллер, но тут тоже вынесу из execute его.
    def user_params
      inputs.except(:interests, :skills) # Скиллы не скипались, но это странно, как будто тоже должны были, добавил.
    end
  end
end
