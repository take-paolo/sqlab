# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake task import:sample_csv_data', type: :task do
  let(:task) { Rake::Task['import:sample_csv_data'] }

  describe 'successful execution' do
    it 'completes successfully' do
      expect { task.invoke }.not_to raise_error
    end
  end
end
