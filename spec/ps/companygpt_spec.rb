# frozen_string_literal: true

RSpec.describe Ps::Companygpt do
  it 'has a version number' do
    expect(Ps::Companygpt::VERSION).not_to be_nil
  end

  it 'has a standard error' do
    expect { raise Ps::Companygpt::Error, 'some message' }
      .to raise_error('some message')
  end
end
