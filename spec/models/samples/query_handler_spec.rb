require 'rails_helper'

RSpec.describe Samples::QueryHandler, type: :model do
  let!(:target_database) { SampleDatabaseDefinition.find_by(name: 'book_stores') }

  describe '#execute' do
    subject(:exec_result) do
      described_class.new(target_database).execute(query)
    end

    let!(:status) { { success: 0, error: 1 } }

    describe 'normal' do
      context 'when single query' do
        let(:query) { 'select * from books;' }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when multiple queries' do
        let(:query) { 'select * from books; select * from authors;' }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query contains mixed case' do
        let(:query) { 'sEleCT * FroM boOKs;' }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query contains extra white spaces' do
        let(:query) { '   select   *   from    books   ;' }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query contains extra semicolons' do
        let(:query) { ';;; select * from books ;;;' }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query contains one line comment' do
        let(:query) { "-- comment   \n select * from books;" }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query contains multiple line comments' do
        let(:query) { "  /* multi \n line \n comment */ select * from books;" }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query contains newline' do
        let(:query) { "select\n*   from  \n  books;" }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query is insert statement to a read-write table' do
        let(:query) { "insert into events (id, name, max_num) values (3, 'test', 100)" }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query is update statement to a read-write table' do
        let(:query) { "update events set name = 'test' where id = 1;" }

        it { expect(exec_result[:status]).to eq status[:success] }
      end

      context 'when query is delete statement to a read-write table' do
        let(:query) { 'delete from events where id = 1;' }

        it { expect(exec_result[:status]).to eq status[:success] }
      end
    end

    describe 'exception' do
      describe 'syntax error' do
        context 'when query is string' do
          let(:query) { "'select * from books'" }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'syntax error' }
        end

        context 'when queries are without semicolon between them' do
          let(:query) { 'select * from authors select * from books' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'syntax error' }
        end

        context 'when query contains invalid statement' do
          let(:query) { 'selec * from books;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'syntax error' }
        end

        context 'when query contains invalid clause' do
          let(:query) { 'select * fro books' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'syntax error' }
        end

        context 'when query contains invalid table name' do
          let(:query) { 'select * from book' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to match(/relation .* does not exist/) }
        end

        context 'when query contains invalid column name' do
          let(:query) { 'select names from books' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to match(/column .* does not exist/) }
        end
      end

      describe 'permission error' do
        context 'when query is insert statement to a read only table' do
          let(:query) { "insert into stores(id, name) values (3, 'test')" }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'permission denied' }
        end

        context 'when query is update statement to a read only table' do
          let(:query) { "update stores set name = 'test' where id = 1;" }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'permission denied' }
        end

        context 'when query is delete statement to a read only table' do
          let(:query) { 'delete from stores where id = 1;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'permission denied' }
        end
      end

      describe 'when invalid query' do
        context 'when query contains an invalid keyword like create table' do
          let(:query) { 'create table mybook (id integer, name varchar(10));' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query tries to create a table using select' do
          let(:query) { 'create table another_books as select * from books;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query uses select into to create a table' do
          let(:query) { 'select * into new_table from books;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains system a system keyword like pg_' do
          let(:query) { 'select pg_users;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains a system keyword like inet_' do
          let(:query) { 'select inet_client_addr();' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains a system keyword like current_' do
          let(:query) { 'select current_user;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains a system keyword like has_' do
          let(:query) { 'select has_table_privilege(\'public.books\', \'select\');' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains a system keyword like txid_' do
          let(:query) { 'select txid_current();' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains a system keyword like information_schema.' do
          let(:query) { 'select table_name from information_schema.tables;' }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end

        context 'when query contains a system function like set_config(' do
          let(:query) { "select set_config('search_path', 'public', false);" }

          it { expect(exec_result[:status]).to eq status[:error] }
          it { expect(exec_result[:values]).to include 'invalid keywords or syntax error' }
        end
      end
    end
  end
end
