/* A table for Roux Academy art conference participants */

CREATE TABLE artists(
 id CHAR (32) NOT NULL,
 PRIMARY KEY(id),
 artist_name VARCHAR(64),
 url VARCHAR(256),
 email VARCHAR(128),
 pieces INTEGER
);

/* Seed records */
INSERT INTO artists ( id, artist_name, url, email, pieces ) VALUES ( clock_timestamp(), 'pollock', 'http://pollock.org', 'pollock@roux.edu', 6 );
INSERT INTO artists ( id, artist_name, url, email, pieces ) VALUES ( clock_timestamp(), 'okeeffe', 'http://okeeffee.net/', 'okeeffe@roux.edu', 5 );
INSERT INTO artists ( id, artist_name, url, email, pieces ) VALUES ( clock_timestamp(), 'monet', 'http://monet.com', 'monet@roux.edu', 4 );
INSERT INTO artists ( id, artist_name, url, email, pieces ) VALUES ( clock_timestamp(), 'dali', 'http://dali.org/', 'dali@roux.edu', 3 );
INSERT INTO artists ( id, artist_name, url, email, pieces ) VALUES ( clock_timestamp(), 'kahlo', 'http://kahlo.com/', 'kahlo@roux.edu', 3 );