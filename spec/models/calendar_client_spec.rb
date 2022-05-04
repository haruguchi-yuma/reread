# frozen_string_literal: true

require 'json'
require 'rails_helper'

RSpec.describe CalendarClient, type: :model do
  let(:user) { create(:user) }
  let(:client) { CalendarClient.new(user) }

  before do
    stub_request(:post, 'https://accounts.google.com/o/oauth2/token')
      .with(
        body: { 'client_id' => '145346336594-4r4gj5cbiuol4g80e4npdfev8jg4jsqm.apps.googleusercontent.com',
                'client_secret' => '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',
                'grant_type' => 'refresh_token', 'refresh_token' => '1/zaaHNytlC3SEBX7F2cfrHcqJEa3KoAHYeXES6nmho' },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => 'Faraday v1.9.3'
        }
      )
      .to_return(status: 200, body: '{
        "access_token" : "ya29.ZStBkRnGyZ2mUYOLgls7QVBxOg82XhBCFo8UIT5gM",
        "token_type" : "Bearer",
        "expires_in" : 3600,
        "refresh_token" : "1/zaaHNytlC3SEBX7F2cfrHcqJEa3KoAHYeXES6nmho"
        }',
                 headers: {
                   'Content-Type' => 'application/json'
                 })

    stub_request(:post, 'https://www.googleapis.com/calendar/v3/calendars/primary/events')
      .with(
        body: '{"description":"","end":{"date":"2022-05-05"},"start":{"date":"2022-05-05"},"summary":"本のタイトル"}'
      )
      .to_return(status: 200, body: '{
        "kind": "calendar#event",
        "etag": "\"3302250433818000\"",
        "id": "eg38qkdparecov29bftrshb3d4",
        "status": "confirmed",
        "htmlLink": "https://www.google.com/calendar/event?eid=ZWczOHFrZHBhcmVjb3YyOWJmdHJzaGIzZDQgaWtlb2t1LnlAbQ",
        "created": "2022-04-29T05:53:36.000Z",
        "updated": "2022-04-29T05:53:36.909Z",
        "creator": {
        "email": "ikeoku.y@gmail.com",
        "self": true
        },
        "organizer": {
        "email": "ikeoku.y@gmail.com",
        "self": true
        },
        "start": {
        "date": "2022-04-30"
        },
        "end": {
        "date": "2022-04-30"
        },
        "iCalUID": "eg38qkdparecov29bftrshb3d4@google.com",
        "sequence": 0,
        "reminders": {
        "useDefault": false
        },
        "eventType": "default"
      }',
                 headers: {
                   'Content-Type' => 'application/json',
                   'X-Goog-Upload-Status': 'final'
                 })
  end

  context 'access token を refreshするとき' do
    before do
      Rails.cache.write(user.uid, 'ya29.ZStBkRnGyZ2mUYOLgls7QVBxOg82XhBCFo8UIT5gM')
      Rails.cache.write("#{user.uid}expires_at", 1_651_638_497)
      Rails.cache.write(user.uid + user.id.to_s, '1/zaaHNytlC3SEBX7F2cfrHcqJEa3KoAHYeXES6nmho')
    end

    it '#create_event' do
      client.create_event(create(:read_history, read_back_on: Date.parse('2022-05-05')))
      expect(WebMock).to have_requested(:post, 'https://www.googleapis.com/calendar/v3/calendars/primary/events')
    end

    after do
      Rails.cache.delete(user.uid)
      Rails.cache.delete("#{user.uid}expires_at")
      Rails.cache.delete(user.uid + user.id.to_s)
    end
  end
end
