CREATE TABLE analysis.dm_rfm_segments (
    user_id int NOT NULL PRIMARY KEY,
    recency int NOT NULL CHECK(recency >= 1 AND recency <= 5),
    frequency int NOT NULL CHECK(recency >= 1 AND recency <= 5),
    monetary_value int NOT NULL CHECK(recency >= 1 AND recency <= 5)
);