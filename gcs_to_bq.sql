
CREATE SCHEMA greenery;

LOAD DATA OVERWRITE greenery.addresses
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/addressese.csv']
);

LOAD DATA OVERWRITE greenery.events
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/events.csv']
);

LOAD DATA OVERWRITE greenery.order_items
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/order_items.csv']
);

LOAD DATA OVERWRITE greenery.orders
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/orders.csv']
);

LOAD DATA OVERWRITE greenery.products
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/products.csv']
);

LOAD DATA OVERWRITE greenery.promos
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/promos5.csv']
);

LOAD DATA OVERWRITE greenery.users
FROM FILES (
  format = 'CSV',
  uris = ['gs://analytics_jproj/greenery_datasets/users.csv']
);