SELECT '# This is it'

UNION ALL SELECT '|--|--|--|'

UNION ALL SELECT '| '+CAST(ID AS VARCHAR(100)) +' | '+rss+' | '+lang+' |' FROM [dbo].[sites]


