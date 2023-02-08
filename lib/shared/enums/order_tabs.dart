enum OrderTabs {
  toPay('To pay', 'TO_PAY'),
  toShip('To ship', 'TO_SHIP'),
  toReceive('To receive', 'TO_RECEIVE'),
  completed('Completed', 'COMPLETED'),
  cancelled('Cancelled', 'CANCELLED');

  final String title;
  final String value;
  const OrderTabs(this.title, this.value);
}
