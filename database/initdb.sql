CREATE TABLE "adressen" (
  "aid" SERIAL PRIMARY KEY,
  "ort" varchar,
  "plz" int,
  "adresse_1" varchar,
  "adresse_2" varchar,
  "tel_G" varchar,
  "tel_M" varchar,
  "email_1" varchar,
  "email_2" varchar
);

CREATE TABLE "personen" (
  "pid" SERIAL PRIMARY KEY,
  "anrede" varchar,
  "name" varchar,
  "vorname" varchar,
  "fk_aid" int
);

CREATE TABLE "schulen" (
  "suid" SERIAL PRIMARY KEY,
  "name" varchar,
  "fk_aid" int
);

CREATE TABLE "firma" (
  "fid" SERIAL PRIMARY KEY,
  "name" varchar,
  "fk_aid" int
);

CREATE TABLE "lehrkraft" (
  "lkid" SERIAL PRIMARY KEY,
  "fk_pid" int
);

CREATE TABLE "kalssen" (
  "kid" SERIAL PRIMARY KEY,
  "fk_suid" int,
  "name" varchar,
  "fk_lkid" int
);

CREATE TABLE "abv" (
  "abvid" SERIAL PRIMARY KEY,
  "fk_pid" int,
  "fk_fid" int
);

CREATE TABLE "schueler" (
  "sid" SERIAL PRIMARY KEY,
  "fk_pid" int,
  "fk_fid" int,
  "fk_kid" int
);

CREATE TABLE "beurteilung" (
  "bid" SERIAL PRIMARY KEY,
  "fk_sid" int,
  "note" int2 NOT NULL,
  "gewichtung" float4 NOT NULL DEFAULT 1,
  "bemerkung" text
);

ALTER TABLE "personen" ADD FOREIGN KEY ("fk_aid") REFERENCES "adressen" ("aid");

ALTER TABLE "schulen" ADD FOREIGN KEY ("fk_aid") REFERENCES "adressen" ("aid");

ALTER TABLE "firma" ADD FOREIGN KEY ("fk_aid") REFERENCES "adressen" ("aid");

ALTER TABLE "lehrkraft" ADD FOREIGN KEY ("fk_pid") REFERENCES "personen" ("pid");

ALTER TABLE "kalssen" ADD FOREIGN KEY ("fk_suid") REFERENCES "schulen" ("suid");

ALTER TABLE "kalssen" ADD FOREIGN KEY ("fk_lkid") REFERENCES "lehrkraft" ("lkid");

ALTER TABLE "abv" ADD FOREIGN KEY ("fk_pid") REFERENCES "personen" ("pid");

ALTER TABLE "abv" ADD FOREIGN KEY ("fk_fid") REFERENCES "firma" ("fid");

ALTER TABLE "schueler" ADD FOREIGN KEY ("fk_pid") REFERENCES "personen" ("pid");

ALTER TABLE "schueler" ADD FOREIGN KEY ("fk_fid") REFERENCES "firma" ("fid");

ALTER TABLE "schueler" ADD FOREIGN KEY ("fk_kid") REFERENCES "kalssen" ("kid");

ALTER TABLE "beurteilung" ADD FOREIGN KEY ("fk_sid") REFERENCES "schueler" ("sid");

COMMENT ON COLUMN "beurteilung"."note" IS 'Note von 1 bis 6';

COMMENT ON COLUMN "beurteilung"."gewichtung" IS 'Gewichtung von 0 bis 1';
