# Тут тоже не стал сильно разрастаться в рамказ ТЗ.

class UsersController < ApplicationController
  def create
    user = Users::Create.run(user_params)

    if user.valid?
      render json: { message: 'Ok' }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :patronymic, :surname, :email, :nationality, :country, :gender, :age, :interests, :skills)
  end
end
