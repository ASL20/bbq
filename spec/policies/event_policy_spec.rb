require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:current_user) { User.new }
  let(:another_user) { User.new(id: 1) }
  let(:event) { Event.new(user: current_user) }

  subject { described_class }

  context 'when user is not owner' do
    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(another_user, event) }
    end
  end

  context 'when user is not logged' do
    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(nil, Event) }
    end
  end

  context 'when user is the owner' do
    permissions :edit?, :destroy?, :update? do
      it { is_expected.to permit(current_user, event) }
    end
  end

  context 'registered user create event' do
    permissions :create? do
      it { is_expected.to permit(another_user, :event) }
      it { is_expected.to permit(current_user, :event) }
      it { is_expected.not_to permit(nil, Event) }
    end
  end
end
