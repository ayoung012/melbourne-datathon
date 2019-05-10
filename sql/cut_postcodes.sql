CREATE TABLE postcodes_geo
(
  postcode varchar(5) default NULL,
  state varchar(4) default NULL,
  latitude decimal(6,4) default NULL,
  longitude decimal(6,4) default NULL
);

INSERT INTO postcodes_geo
	SELECT postcode, state, AVG(latitude), AVG(longitude) FROM postcodes_temp
	GROUP BY postcode
	;

