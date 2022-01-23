defmodule Cards do
  @moduledoc """
    Provides functions for creating and handling a deck of cards.
  """

  @cards [
    "Ace",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Jack",
    "Queen",
    "King"
  ]

  @suits ["♣","♦","♥","♠"]

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    for suit <- @suits, card <- @cards do
      "#{card} of #{suit}"
    end
    |> List.flatten()
  end

  @doc """
    Returns a shuffled list of strings from the deck.
  """
  def shuffle(deck) do
    deck
    |> Enum.shuffle()
  end

  @doc """
    Divides a deck into a hand.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.deal(deck, 3)
      ["Ace of ♣", "Two of ♣", "Three of ♣"]

  """
  def deal(deck, hand_size) do
    with {splitted_deck, _} <- Enum.split(deck, hand_size) do
      splitted_deck
    end
  end


  @doc """
    Returns the binary file created with the given deck.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Returns the file content.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "That file does not exist."
    end
  end

  @doc """
    Check if a given card is in the deck. Returns a truthy or falsy value.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of ♣")
      true

  """
  def contains?(deck, card) do
    card
    |> String.contains?(deck)
  end

  @doc """
    Returns created hand.
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
