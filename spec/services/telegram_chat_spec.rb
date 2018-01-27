require 'rails_helper'

describe TelegramChat do
  let(:start_payload) do
    {
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
    }.with_indifferent_access
  end

  let(:movie_payload) do
    {
        "webhook" => {
            "update_id" => 954044700,
            "message" => {
                "message_id" => 12,
                "from" => {"id" => 102089, "is_bot" => false, "first_name" => "Юра", "last_name" => "Омельчук", "language_code" => "ru-UA"},
                "chat" => {"id" => 102089, "first_name" => "Юра", "last_name" => "Омельчук", "type" => "private"},
                "date" => 1517063611,
                "text" => "Pulp Fiction"
            }
        }
    }.with_indifferent_access
  end

  specify 'dispatch' do
    expect_any_instance_of(BotCommand::None).to receive(:process).with('/start')
    expect{ TelegramChat.dispatch(start_payload) }.to change(User, :count).to(1)
  end

  specify 'dispatch' do
    TelegramChat.dispatch(start_payload)

    expect_any_instance_of(BotCommand::Start).to receive(:process).with('Pulp Fiction')

    TelegramChat.dispatch(movie_payload)
    # expect{
    # }.to change(Wish, :count).to(1)
  end
end
