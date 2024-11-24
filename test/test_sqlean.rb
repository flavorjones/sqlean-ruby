# frozen_string_literal: true

require "test_helper"

class TestSQLean < Minitest::Spec
  #
  #  shared specs, one for each extension
  #
  def self.it_extends_crypto
    it "extends crypto" do
      result = db.execute("select hex(crypto_blake3('abc'));")

      assert_equal([["6437B3AC38465133FFB63B75273A8DB548C558465D79DB03FD359C6CD5BD9D85"]], result)
    end
  end

  def self.it_extends_define
    it "extends define" do
      db.execute("select define('sumn', ':n * (:n + 1) / 2');")
      result = db.execute("select sumn(5);")

      assert_equal([[15]], result)
    end
  end

  def self.it_extends_fileio
    it "extends fileio" do
      Tempfile.create do |file|
        file.write("Hello, world!")
        file.close

        result = db.execute("select fileio_read('#{file.path}');")

        assert_equal([["Hello, world!"]], result)
      end
    end
  end

  def self.it_extends_fuzzy
    it "extends fuzzy" do
      result = db.execute("select fuzzy_damlev('awesome', 'aewsme');")

      assert_equal([[2]], result)
    end
  end

  def self.it_extends_ipaddr
    it "extends ipaddr" do
      skip("not supported on windows") if Gem.win_platform?

      result = db.execute("select ipcontains('192.168.16.0/24', '192.168.16.3');")

      assert_equal([[1]], result)
    end
  end

  def self.it_extends_math
    it "extends math" do
      result = db.execute("select math_sqrt(9);")

      assert_equal([[3]], result)
    end
  end

  def self.it_extends_regexp
    it "extends regexp" do
      result = db.execute("select true where 'the year is 2021' regexp '[0-9]+';")

      assert_equal([[1]], result)
    end
  end

  def self.it_extends_stats
    it "extends stats" do
      result = db.execute("select * from stats_seq(1, 4);")

      assert_equal([[1], [2], [3], [4]], result)
    end
  end

  def self.it_extends_text
    it "extends text" do
      result = db.execute("select text_substring('hello world', 7);")

      assert_equal([["world"]], result)
    end
  end

  def self.it_extends_time
    it "extends time" do
      result = db.execute("select time_fmt_iso(time_date(2011, 11, 18));")

      assert_equal([["2011-11-18T00:00:00Z"]], result)
    end
  end

  def self.it_extends_uuid
    it "extends uuid" do
      result = db.execute("select uuid7_timestamp_ms('018ff38a-a5c9-712d-bc80-0550b3ad41a2');")

      assert_equal([[1717777901001]], result)
    end
  end

  def self.it_extends_vsv
    it "extends vsv" do
      Tempfile.create do |file|
        file.puts("color,size,amount")
        file.puts("red,large,10")
        file.puts("blue,small,20")
        file.puts("green,medium,15")
        file.close

        db.execute(<<~SQL)
          create virtual table shirts using vsv(
            filename='#{file.path}',
            schema='create table shirts(color string, size string, amount integer)',
            columns=3,
            affinity=integer
          );
        SQL
        db.results_as_hash = true

        result = db.execute("select * from shirts where (color = 'red');")

        assert_equal([{"color" => "red", "size" => "large", "amount" => 10}], result)
      end
    end
  end

  #
  #  the actual tests
  #
  let(:db) do
    SQLite3::Database.new(":memory:").tap do |db|
      db.enable_load_extension(true)
      db.load_extension(extension.sqlite_extension_path)
    end
  end

  describe SQLean do
    let(:extension) { SQLean }

    it_extends_crypto
    it_extends_define
    it_extends_fileio
    it_extends_fuzzy
    it_extends_ipaddr
    it_extends_math
    it_extends_regexp
    it_extends_stats
    it_extends_text
    it_extends_time
    it_extends_uuid
    it_extends_vsv
  end

  describe SQLean::Crypto do
    let(:extension) { SQLean::Crypto }

    it_extends_crypto
  end

  describe SQLean::Define do
    let(:extension) { SQLean::Define }

    it_extends_define
  end

  describe SQLean::FileIO do
    let(:extension) { SQLean::FileIO }

    it_extends_fileio
  end

  describe SQLean::Fuzzy do
    let(:extension) { SQLean::Fuzzy }

    it_extends_fuzzy
  end

  describe SQLean::IPAddr do
    let(:extension) { SQLean::IPAddr }

    it_extends_ipaddr
  end

  describe SQLean::Math do
    let(:extension) { SQLean::Math }

    it_extends_math
  end

  describe SQLean::Regexp do
    let(:extension) { SQLean::Regexp }

    it_extends_regexp
  end

  describe SQLean::Stats do
    let(:extension) { SQLean::Stats }

    it_extends_stats
  end

  describe SQLean::Text do
    let(:extension) { SQLean::Text }

    it_extends_text
  end

  describe SQLean::Time do
    let(:extension) { SQLean::Time }

    it_extends_time
  end

  describe SQLean::UUID do
    let(:extension) { SQLean::UUID }

    it_extends_uuid
  end

  describe SQLean::VSV do
    let(:extension) { SQLean::VSV }

    it_extends_vsv
  end
end
