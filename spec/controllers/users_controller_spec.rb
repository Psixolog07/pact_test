require 'rails_helper'

# Побольше тестов напишу

describe UsersController, type: :controller do
  describe '#create' do
    shared_examples 'invalid inputs' do
      it 'NOT create user' do
        expect { subject }.to_not change(User, :count)
      end

      it 'returns 422 status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    subject { post :create, params: params }

    let(:params) do
      {
        name: name,
        patronymic: patronymic,
        surname: 'Durov',
        email: email,
        nationality: nationality,
        country: country,
        gender: gender,
        age: age,
        interests: 'coding',
        skills: 'coding,telegraming'
      }
    end

    let(:name) { 'Pavel' }
    let(:patronymic) { 'Ivanovich' }
    let(:email) { 'durov@mail.ru' }
    let(:nationality) { 'russian' }
    let(:country) { 'France' }
    let(:gender) { 'male' }
    let(:age) { 30 }

    let!(:interest) { Interest.create(name: 'coding') }
    let!(:skills) { %w[coding telegraming].map { Skill.create(name: _1) } }

    it 'create user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'assign interest correctly' do
      subject
      expect(User.last.interests).to contain_exactly(interest)
    end

    it 'assign skills correctly' do
      subject
      expect(User.last.skills).to match_array(skills)
    end

    %w[name patronymic email nationality country gender].each do |input|
      context "when #{input} is nil" do
        let(input.to_sym) { nil }

        it 'return error' do
          subject
          expect(JSON.parse(response.body)['errors']).to include("#{input.capitalize} can't be blank")
        end

        it_behaves_like 'invalid inputs'
      end
    end

    context 'when age is nil' do
      let(:age) { nil }

      it 'return error' do
        subject
        expect(JSON.parse(response.body)['errors']).to include('Age is required')
      end

      it_behaves_like 'invalid inputs'
    end

    context 'when age is out of range' do
      [0, 100].each do |age|
        let(:age) { age }

        it 'return error' do
          subject
          expect(JSON.parse(response.body)['errors']).to include('Age is not included in the list')
        end

        it_behaves_like 'invalid inputs'
      end
    end

    context 'when gender is out if range' do
      let(:gender) { 'vertolet' }

      it 'return error' do
        subject
        expect(JSON.parse(response.body)['errors']).to include('Gender is not included in the list')
      end

      it_behaves_like 'invalid inputs'
    end

    context 'when user with this email already exist' do
      before { User.create(params.except(:interests, :skills)) }

      it 'return error' do
        subject
        expect(JSON.parse(response.body)['errors']).to include('Email already exist')
      end

      it_behaves_like 'invalid inputs'
    end
  end
end
