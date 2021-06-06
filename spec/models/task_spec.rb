# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { FactoryBot.create(:project) }

  it 'is valid with a project and name' do
    taks = project.tasks.new(
      project: project,
      name: 'Test task'
    )
    expect(taks).to be_valid
  end

  it 'is invalid without a project' do
    task = described_class.new(project: nil)
    task.valid?
    expect(task.errors[:project]).to include('must exist')
  end

  it 'is invalid without a name' do
    task = described_class.new(name: nil)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end
end
