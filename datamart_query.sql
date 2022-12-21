INSERT INTO analysis.dm_rfm_segments
SELECT user_id, recency, frequency, monetary_value
FROM analysis.tmp_rfm_recency
JOIN analysis.tmp_rfm_frequency USING(user_id)
JOIN analysis.tmp_rfm_monetary_value USING(user_id);

-- user_id recency frequency monetary_value
-- 0	    3	    5	    5
-- 1	    4	    4	    4
-- 2	    3	    3	    3
-- 3	    3	    3	    2
-- 4	    3	    4	    2
-- 5	    4	    5	    5
-- 6	    1	    2	    2
-- 7	    5	    1	    2
-- 8	    4	    1	    2
-- 9	    4	    3	    2