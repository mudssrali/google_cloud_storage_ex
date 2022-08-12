defmodule GoogleCloudTest do
  use ExUnit.Case
  doctest GoogleCloud

  test "greets the world" do
    assert GoogleCloud.hello() == :world
  end
end
