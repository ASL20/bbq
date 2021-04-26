require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  subject { described_class }

  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }

  let(:event) { FactoryBot.create(:event, user: user) }
  let(:event_with_pin) { FactoryBot.create(:event, user: user, pincode: '1234') }

  let(:cookie) { { "events_#{event_with_pin.id}_pincode" => '1234' } }

  let(:owner) { UserContext.new(user, {}) }
  let(:not_owner) { UserContext.new(another_user, {}) }
  let(:not_owner_with_pin) { UserContext.new(another_user, cookie) }
  let(:anonimous_user) { UserContext.new(nil, {}) }

  context 'user edit, update or destroy event' do
    context 'and user is owner' do
      permissions :edit?, :update?, :destroy? do
        it { is_expected.to permit(owner, event) }
      end
    end

    context 'and user is not owner' do
      permissions :edit?, :update?, :destroy? do
        it { is_expected.not_to permit(not_owner, event) }
      end
    end

    context 'and user is anonimous' do
      permissions :edit?, :update?, :destroy? do
        it { is_expected.not_to permit(anonimous_user, event) }
      end
    end
  end

  context 'user viewing event' do
    context 'and user is owner' do
      permissions :show? do
        it { is_expected.to permit(owner, event_with_pin) }
        it { is_expected.to permit(owner, event) }
      end
    end

    context 'and user is not owner' do
      permissions :show? do
        it { is_expected.to permit(not_owner_with_pin, event_with_pin) }
        it { is_expected.not_to permit(not_owner, event_with_pin) }
        it { is_expected.to permit(not_owner, event) }
      end
    end

    context 'and user is anonimous' do
      permissions :show? do
        it { is_expected.to permit(anonimous_user, event) }
        it { is_expected.not_to permit(anonimous_user, event_with_pin) }
      end
    end
  end

  context 'registered user create event' do
    permissions :create? do
      it { is_expected.to permit(not_owner, Event) }
      it { is_expected.to permit(owner, Event) }
      it { is_expected.not_to permit(anonimous_user, Event) }
    end
  end
end
