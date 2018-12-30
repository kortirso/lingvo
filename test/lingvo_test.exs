defmodule LingvoTest do
  use ExUnit.Case

  setup_all do
    {:ok, access_token} = Lingvo.authenticate()
    {:ok, access_token: access_token}
  end

  describe "translate" do
    test "request, without text", state do
      {:error, error_message} = Lingvo.translate([from: "es", to: "ru"], state[:access_token])

      assert error_message == "Text is required field"
    end

    test "request, without from", state do
      {:error, error_message} = Lingvo.translate([text: "Hola", to: "ru"], state[:access_token])

      assert error_message == "From is required field"
    end

    test "request, without to", state do
      {:error, error_message} = Lingvo.translate([text: "Hola", from: "es"], state[:access_token])

      assert error_message == "To is required field"
    end

    test "request, invalid source", state do
      {:error, error_message} = Lingvo.translate([text: "Hola", from: "aa", to: "ru"], state[:access_token])

      assert error_message == "Source language is not available"
    end

    test "request, invalid destination", state do
      {:error, error_message} = Lingvo.translate([text: "Hola", from: "es", to: "aa"], state[:access_token])

      assert error_message == "Destination language is not available"
    end

    test "request, invalid translation", state do
      {:error, error_message} = Lingvo.translate([text: "Hola", from: "es", to: "en"], state[:access_token])

      assert error_message == "Translation is not available"
    end

    test "valid request", state do
      {:ok, result} = Lingvo.translate([text: "Hola", from: "es", to: "ru"], state[:access_token])

      assert is_list(result) == true
    end
  end
end
