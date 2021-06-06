# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  it 'is valid with a user, project, and message' do
    note = described_class.new(user: user, project: project, message: 'test message')
    expect(note).to be_valid
  end

  it 'is invalied without message' do
    note = described_class.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe 'search message for a term' do
    let!(:note1) do
      FactoryBot.create(:note,
                        project: project,
                        user: user,
                        message: 'This is the first note.')
    end

    let!(:note2) do
      FactoryBot.create(:note,
                        project: project,
                        user: user,
                        message: 'This is the second note.')
    end

    let!(:note3) do
      FactoryBot.create(:note,
                        project: project,
                        user: user,
                        message: 'First, preheat the oven.')
    end

    context 'when a match is found' do
      # 検索文字列に一致するメモを返すこと
      it 'returns notes that match the search term' do
        expect(described_class.search('first')).to include(note1, note3)
        expect(described_class.search('first')).not_to include(note2)
      end
    end

    context 'when no match is found' do
      it 'returns an empty collection when no results are found' do
        expect(described_class.search('message')).to be_empty
        expect(described_class.count). to eq 3
      end
    end
  end
end
