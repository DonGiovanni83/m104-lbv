CREATE TABLE "adressen" (
  "aid" SERIAL PRIMARY KEY,
  "ort" varchar,
  "plz" int,
  "adresse_1" varchar,
  "adresse_2" varchar,
  "tel_g" varchar,
  "tel_m" varchar,
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

CREATE TABLE "firmen" (
  "fid" SERIAL PRIMARY KEY,
  "name" varchar,
  "fk_aid" int
);

CREATE TABLE "lehrkraefte" (
  "lkid" SERIAL PRIMARY KEY,
  "fk_pid" int
);

CREATE TABLE "kalssen" (
  "kid" SERIAL PRIMARY KEY,
  "fk_suid" int,
  "name" varchar,
  "fk_lkid" int
);

CREATE TABLE "abvs" (
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

CREATE TABLE "beurteilungen" (
  "bid" SERIAL PRIMARY KEY,
  "fk_sid" int,
  "fk_mid" int,
  "note" int2 NOT NULL,
  "gewichtung" float4 NOT NULL DEFAULT 1,
  "bemerkung" text
);

CREATE TABLE "module" (
  "mid" SERIAL PRIMARY KEY,
  "name" varchar,
  "fk_suid" int,
  "fk_lkid" int
);

ALTER TABLE "personen" ADD FOREIGN KEY ("fk_aid") REFERENCES "adressen" ("aid");

ALTER TABLE "schulen" ADD FOREIGN KEY ("fk_aid") REFERENCES "adressen" ("aid");

ALTER TABLE "firmen" ADD FOREIGN KEY ("fk_aid") REFERENCES "adressen" ("aid");

ALTER TABLE "lehrkraefte" ADD FOREIGN KEY ("fk_pid") REFERENCES "personen" ("pid");

ALTER TABLE "kalssen" ADD FOREIGN KEY ("fk_suid") REFERENCES "schulen" ("suid");

ALTER TABLE "kalssen" ADD FOREIGN KEY ("fk_lkid") REFERENCES "lehrkraefte" ("lkid");

ALTER TABLE "abvs" ADD FOREIGN KEY ("fk_pid") REFERENCES "personen" ("pid");

ALTER TABLE "abvs" ADD FOREIGN KEY ("fk_fid") REFERENCES "firmen" ("fid");

ALTER TABLE "schueler" ADD FOREIGN KEY ("fk_pid") REFERENCES "personen" ("pid");

ALTER TABLE "schueler" ADD FOREIGN KEY ("fk_fid") REFERENCES "firmen" ("fid");

ALTER TABLE "schueler" ADD FOREIGN KEY ("fk_kid") REFERENCES "kalssen" ("kid");

ALTER TABLE "beurteilungen" ADD FOREIGN KEY ("fk_sid") REFERENCES "schueler" ("sid");

ALTER TABLE "beurteilungen" ADD FOREIGN KEY ("fk_mid") REFERENCES "module" ("mid");

ALTER TABLE "module" ADD FOREIGN KEY ("fk_suid") REFERENCES "schulen" ("suid");

ALTER TABLE "module" ADD FOREIGN KEY ("fk_lkid") REFERENCES "lehrkraefte" ("lkid");

COMMENT ON COLUMN "beurteilungen"."note" IS 'Note von 1 bis 6';

COMMENT ON COLUMN "beurteilungen"."gewichtung" IS 'Gewichtung von 0 bis 1';
