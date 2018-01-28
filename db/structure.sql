CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar, "last_name" varchar, "last_update_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "telegram_id" integer, "status" varchar);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "movies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "poster" varchar, "year" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "crawled_at" datetime, "tmdb_id" integer);
CREATE TABLE IF NOT EXISTS "wishes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "movie_id" integer, "notified_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, CONSTRAINT "fk_rails_80dc2ed976"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_a62895ac13"
FOREIGN KEY ("movie_id")
  REFERENCES "movies" ("id")
);
CREATE INDEX "index_wishes_on_user_id" ON "wishes" ("user_id");
CREATE INDEX "index_wishes_on_movie_id" ON "wishes" ("movie_id");
CREATE TABLE IF NOT EXISTS "releases" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "movie_id" integer DEFAULT NULL, "title" varchar DEFAULT NULL, "status" varchar DEFAULT NULL, "link" varchar DEFAULT NULL, "magnet" varchar DEFAULT NULL, "seeds" integer);
CREATE INDEX "index_releases_on_movie_id" ON "releases" ("movie_id");
INSERT INTO "schema_migrations" (version) VALUES
('20180127140911'),
('20180127141236'),
('20180127141512'),
('20180127141946'),
('20180127160402'),
('20180127161642'),
('20180127213540'),
('20180127213918'),
('20180127214053'),
('20180128001443');


