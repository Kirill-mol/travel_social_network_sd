// Replication:
// - master-slave (one sync + async)
// - replication factor 3
//
// Sharding:
// - key based by id

Table users {
  id uuid [primary key]
  firstname string [not null]
  lastname string [not null]
  nickname string [not null, unique]
  photo_link string
  email string [not null, unique]
}

Table subscriptions {
  subscriber_id uuid [primary key]
  followed_id uuid [primary key]
  subscribed_at timestamp [not null]
}

Table posts {
  id uuid [primary key]
  title string [not null]
  location_id uuid
  text string
}

Table posts_media {
  media_id uuid [primary key]
  post_id uuid [primary key]
}

Table media {
  id uuid [primary key]
  cdn_link string [not null]
}

Table locations {
  id uuid [primary key]
  lat double
  lon double
  name text [not null]
}

Table comments {
  id uuid [primary key]
  post_id uuid [not null]
  user_id uuid [not null]
  text string [not null]
}

Table marks {
  id uuid [primary key]
  post_id uuid [not null]
  user_id uuid [not null]
  mark int [not null]
}



Ref: users.id < subscriptions.subscriber_id

Ref: users.id < subscriptions.followed_id

Ref: users.photo_id - media.id

Ref: posts.id - posts_media.post_id

Ref: media.id - posts_media.media_id

Ref: locations.id < posts.location_id

Ref: comments.post_id > posts.id

Ref: comments.user_id > users.id

Ref: marks.post_id > posts.id

Ref: marks.user_id > users.id