create table Airports
(
    name          varchar(100)  not null,
    latitude_deg  float(23, 20) not null,
    longitude_deg float(23, 20) not null,
    elevation_ft  int           not null,
    municipality  varchar(50)   not null,
    iata_code     char(3)       not null
        primary key
);

INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Ted Stevens Anchorage International Airport', 61.1744, -149.996, 152, 'Anchorage', 'ANC');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Hartsfield Jackson Atlanta International Airport', 33.6367, -84.4281, 1026, 'Atlanta', 'ATL');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Austin Bergstrom International Airport', 30.197535, -97.66202, 542, 'Austin', 'AUS');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Nashville International Airport', 36.1245, -86.6782, 599, 'Nashville', 'BNA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Logan International Airport', 42.3643, -71.0052, 20, 'Boston', 'BOS');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Buffalo Niagara International Airport', 42.9405, -78.7322, 728, 'Buffalo', 'BUF');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Baltimore/Washington International Thurgood Marshall Airport', 39.1754, -76.6683, 146, 'Baltimore', 'BWI');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Cleveland Hopkins International Airport', 41.4117, -81.8498, 791, 'Cleveland', 'CLE');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Charlotte Douglas International Airport', 35.214, -80.9431, 748, 'Charlotte', 'CLT');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('John Glenn Columbus International Airport', 39.998, -82.8919, 815, 'Columbus', 'CMH');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Cincinnati Northern Kentucky International Airport', 39.0488, -84.6678, 896, 'Cincinnati / Covington', 'CVG');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Ronald Reagan Washington National Airport', 38.8521, -77.0377, 15, 'Washington', 'DCA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Denver International Airport', 39.8617, -104.673, 5431, 'Denver', 'DEN');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Dallas Fort Worth International Airport', 32.8968, -97.038, 607, 'Dallas-Fort Worth', 'DFW');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Detroit Metropolitan Wayne County Airport', 42.2124, -83.3534, 645, 'Detroit', 'DTW');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Newark Liberty International Airport', 40.6925, -74.1687, 18, 'Newark', 'EWR');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Fairbanks International Airport', 64.8151, -147.856, 439, 'Fairbanks', 'FAI');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Fort Lauderdale Hollywood International Airport', 26.0726, -80.1527, 9, 'Fort Lauderdale', 'FLL');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Daniel K Inouye International Airport', 21.32062, -157.92422, 13, 'Honolulu', 'HNL');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Washington Dulles International Airport', 38.9445, -77.4558, 312, 'Dulles', 'IAD');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('George Bush Intercontinental Houston Airport', 29.9844, -95.3414, 97, 'Houston', 'IAH');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Indianapolis International Airport', 39.7173, -86.2944, 797, 'Indianapolis', 'IND');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Jacksonville International Airport', 30.4941, -81.6879, 30, 'Jacksonville', 'JAX');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('John F Kennedy International Airport', 40.639446, -73.77932, 13, 'New York', 'JFK');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Harry Reid International Airport', 36.083363, -115.15182, 2181, 'Las Vegas', 'LAS');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Los Angeles International Airport', 33.9425, -118.408, 125, 'Los Angeles', 'LAX');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('La Guardia Airport', 40.7772, -73.8726, 21, 'New York', 'LGA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Kansas City International Airport', 39.2976, -94.7139, 1026, 'Kansas City', 'MCI');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Orlando International Airport', 28.4294, -81.309, 96, 'Orlando', 'MCO');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Chicago Midway International Airport', 41.786, -87.7524, 620, 'Chicago', 'MDW');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Memphis International Airport', 35.0424, -89.9767, 341, 'Memphis', 'MEM');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Miami International Airport', 25.7932, -80.2906, 8, 'Miami', 'MIA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('General Mitchell International Airport', 42.9472, -87.8966, 723, 'Milwaukee', 'MKE');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Minneapolisâ€“Saint Paul International Airport / Woldâ€“Chamberlain Field', 44.882, -93.2218, 841, 'Minneapolis', 'MSP');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Louis Armstrong New Orleans International Airport', 29.9934, -90.258, 4, 'New Orleans', 'MSY');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Metropolitan Oakland International Airport', 37.7213, -122.221, 9, 'Oakland', 'OAK');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Ontario International Airport', 34.056, -117.601, 944, 'Ontario', 'ONT');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Chicago O''Hare International Airport', 41.9786, -87.9048, 672, 'Chicago', 'ORD');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Palm Beach International Airport', 26.6832, -80.0956, 19, 'West Palm Beach', 'PBI');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Portland International Airport', 45.5887, -122.598, 31, 'Portland', 'PDX');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Philadelphia International Airport', 39.8719, -75.2411, 36, 'Philadelphia', 'PHL');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Phoenix Sky Harbor International Airport', 33.435303, -112.005905, 1135, 'Phoenix', 'PHX');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Pittsburgh International Airport', 40.4915, -80.2329, 1203, 'Pittsburgh', 'PIT');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Theodore Francis Green State Airport', 41.725037, -71.42567, 55, 'Warwick', 'PVD');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Portland International Jetport', 43.6462, -70.3093, 76, 'Portland', 'PWM');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Raleigh Durham International Airport', 35.8776, -78.7875, 435, 'Raleigh/Durham', 'RDU');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Richmond International Airport', 37.5052, -77.3197, 167, 'Richmond', 'RIC');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Reno Tahoe International Airport', 39.4991, -119.768, 4415, 'Reno', 'RNO');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Southwest Florida International Airport', 26.5362, -81.7552, 30, 'Fort Myers', 'RSW');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('San Diego International Airport', 32.7336, -117.19, 17, 'San Diego', 'SAN');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('San Antonio International Airport', 29.5337, -98.4698, 809, 'San Antonio', 'SAT');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Savannah Hilton Head International Airport', 32.1276, -81.2021, 50, 'Savannah', 'SAV');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Louisville Muhammad Ali International Airport', 38.1744, -85.736, 501, 'Louisville', 'SDF');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Seattleâ€“Tacoma International Airport', 47.44916, -122.311134, 433, 'Seattle', 'SEA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Orlando Sanford International Airport', 28.7776, -81.2375, 55, 'Orlando', 'SFB');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('San Francisco International Airport', 37.619, -122.375, 13, 'San Francisco', 'SFO');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Norman Y. Mineta San Jose International Airport', 37.362453, -121.92919, 62, 'San Jose', 'SJC');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Salt Lake City International Airport', 40.785748, -111.979744, 4227, 'Salt Lake City', 'SLC');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Sacramento International Airport', 38.6954, -121.591, 27, 'Sacramento', 'SMF');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('John Wayne Airport-Orange County Airport', 33.6757, -117.868, 56, 'Santa Ana', 'SNA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('St Louis Lambert International Airport', 38.748695, -90.37, 618, 'St Louis', 'STL');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Syracuse Hancock International Airport', 43.1112, -76.1063, 421, 'Syracuse', 'SYR');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Tampa International Airport', 27.9755, -82.5332, 26, 'Tampa', 'TPA');
INSERT INTO Airports (name, latitude_deg, longitude_deg, elevation_ft, municipality, iata_code) VALUES ('Tulsa International Airport', 36.1984, -95.8881, 677, 'Tulsa', 'TUL');
