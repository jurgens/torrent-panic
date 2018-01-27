require 'rails_helper'

describe WebhooksController do
  before do
    @payload = {
        "update_id" => 954044699,
        "message" => {
            "message_id" => 11,
            "from" => {
                "id" => 102089, "is_bot" => false, "first_name" => "Юра", "last_name" => "Омельчук", "language_code" => "ru-UA"
            },
            "chat" => {
                "id" => 102089, "first_name" => "Юра", "last_name" => "Омельчук", "type" => "private"
            },
            "date" => 1517063611,
            "text" => "/start",
            "entities" => [
                {"offset" => 0, "length" => 6, "type" => "bot_command"}
            ]
        },
        "webhook" => {
            "update_id" => 954044699,
            "message" => {
                "message_id" => 11,
                "from" => {"id" => 102089, "is_bot" => false, "first_name" => "Юра", "last_name" => "Омельчук", "language_code" => "ru-UA"},
                "chat" => {"id" => 102089, "first_name" => "Юра", "last_name" => "Омельчук", "type" => "private"},
                "date" => 1517063611,
                "text" => "/start",
                "entities" => [{"offset" => 0, "length" => 6, "type" => "bot_command"}]
            }
        }
    }
  end

  specify '/telegram' do
    post :telegram
    expect(response).to have_http_status :ok
  end

  specify '/telegram with payload' do
    expect(TelegramChat).to receive(:dispatch) #.with(@payload.slice('webhook')['webhook'])
    post 'telegram', params: @payload
  end
end