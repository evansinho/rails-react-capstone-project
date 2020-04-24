require 'rails_helper'

RSpec.describe 'Meets API', type: :request do
  # initialize test data 
  let!(:meets) { create_list(:meet, 10) }
  let(:meet_id) { meets.first.id }

  # Test suite for GET /meets
  describe 'GET /meets' do
    # make HTTP get request before each example
    before { get '/meets' }

    it 'returns meets' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /meets/:id
  describe 'GET /meets/:id' do
    before { get "/meets/#{meet_id}" }

    context 'when the record exists' do
      it 'returns the meet' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(meet_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:meet_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Meet/)
      end
    end
  end

  # Test suite for POST /meets
  describe 'POST /meets' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', description: 'This is a meeting for people learning Elm' } }

    context 'when the request is valid' do
      before { post '/meets', params: valid_attributes }

      it 'creates a meet' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/meets', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /meets/:id
  describe 'PUT /meets/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/meets/#{meet_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /meets/:id
  describe 'DELETE /meets/:id' do
    before { delete "/meets/#{meet_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end