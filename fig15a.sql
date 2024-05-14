SELECT
    CASE 
        WHEN cont.name = 'United States' THEN 'USA'
        WHEN cont.name = 'United Kingdom' THEN 'UK'
        ELSE cont.name
    END AS Country_Name,
    COUNT(DISTINCT CASE WHEN pub2.venue = 'SIGMOD' THEN pubPub.dblp_key ELSE NULL END) AS SIGMOD,
    COUNT(DISTINCT CASE WHEN pub2.venue = 'PODS' THEN pubPub.dblp_key ELSE NULL END) AS PODS
FROM pub_data_publication pubPub
JOIN pub_data_publication_authors pubPubAut ON pubPub.id = pubPubAut.publication_id
JOIN pub_data_authoraffiliation pubAutAff ON pubAutAff.id = pubPubAut.authoraffiliation_id
JOIN pub_data_author pubAuth ON pubAutAff.author_id = pubAuth.id
JOIN pub_data_affiliation pubAff ON pubAutAff.affiliation_id = pubAff.id
JOIN publication pub ON pubPub.dblp_key = pub.pubkey
JOIN publications2 pub2 ON pub2.pubid = pub.pubid
JOIN pub_data_country cont ON pubAff.country_Id = cont.id
WHERE (pub2.venue = 'SIGMOD' OR pub2.venue = 'PODS')
AND pub2.year BETWEEN 2001 AND 2011
AND cont.name IN ('United States', 'Canada', 'Hong Kong', 'Germany', 'India', 'Italy', 'United Kingdom')
GROUP BY Country_Name;