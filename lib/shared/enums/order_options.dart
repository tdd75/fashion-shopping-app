enum SortOptions {
  newest('Newest', '-created_at'),
  rating('Avarge Ratings', 'rating'),
  priceLow('Price - Low to high', 'min_price'),
  priceHigh('Price - High to low', '-max_price');

  final String title;
  final String value;
  const SortOptions(this.title, this.value);
}
