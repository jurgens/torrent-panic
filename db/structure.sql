CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar, "last_name" varchar, "last_update_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "movies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "poster" varchar, "year" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "wishes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "users_id" integer, "movies_id" integer, "notified_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, CONSTRAINT "fk_rails_c0d9b98383"
FOREIGN KEY ("users_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_119e9656e0"
FOREIGN KEY ("movies_id")
  REFERENCES "movies" ("id")
);
CREATE INDEX "index_wishes_on_users_id" ON "wishes" ("users_id");
CREATE INDEX "index_wishes_on_movies_id" ON "wishes" ("movies_id");
CREATE TABLE IF NOT EXISTS "releases" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "movies_id" integer, "title" varchar, "status" varchar, "page_url" varchar, "magnet" varchar, CONSTRAINT "fk_rails_74218220e2"
FOREIGN KEY ("movies_id")
  REFERENCES "movies" ("id")
);
CREATE INDEX "index_releases_on_movies_id" ON "releases" ("movies_id");
INSERT INTO "schema_migrations" (version) VALUES
('20180127140911'),
('20180127141236'),
('20180127141512'),
('20180127141946');


