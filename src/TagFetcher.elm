module TagFetcher where

import Secrets exposing (apiKey)

import Json.Decode exposing (..)

url = "http://content.guardianapis.com/search?show-tags=keyword&page-size=10&api-key=" ++ apiKey

json : String
json = """{"response":{"status":"ok","userTier":"developer","total":1840788,"startIndex":1,"pageSize":10,"currentPage":1,"pages":184079,"orderBy":"newest","results":[{"type":"article","sectionId":"commentisfree","webTitle":"The song of the year urged us to let it flow. Instead, we pushed back | Brigid Delaney","webPublicationDate":"2015-12-24T22:00:32Z","id":"commentisfree/2015/dec/25/the-song-of-the-year-urged-us-to-let-it-flow-instead-we-pushed-back","webUrl":"http://www.theguardian.com/commentisfree/2015/dec/25/the-song-of-the-year-urged-us-to-let-it-flow-instead-we-pushed-back","apiUrl":"http://content.guardianapis.com/commentisfree/2015/dec/25/the-song-of-the-year-urged-us-to-let-it-flow-instead-we-pushed-back","sectionName":"Opinion","tags":[{"id":"music/tame-impala","webTitle":"Tame Impala","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/tame-impala","apiUrl":"http://content.guardianapis.com/music/tame-impala","sectionName":"Music"},{"id":"world/bali-nine","webTitle":"Bali Nine","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/bali-nine","apiUrl":"http://content.guardianapis.com/world/bali-nine","sectionName":"World news"},{"id":"australia-news/q-a","webTitle":"Q&A","description":"The latest news and comment on the Australian television program","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/q-a","apiUrl":"http://content.guardianapis.com/australia-news/q-a","sectionName":"Australia news"},{"id":"australia-news/tony-abbott","webTitle":"Tony Abbott","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/tony-abbott","apiUrl":"http://content.guardianapis.com/australia-news/tony-abbott","sectionName":"Australia news"},{"id":"media/australian-broadcasting-corporation","webTitle":"Australian Broadcasting Corporation","description":"Latest news and analysis on the Australian Broadcasting Corporation","type":"keyword","sectionId":"media","webUrl":"http://www.theguardian.com/media/australian-broadcasting-corporation","apiUrl":"http://content.guardianapis.com/media/australian-broadcasting-corporation","sectionName":"Media"},{"id":"australia-news/australian-politics","webTitle":"Australian politics","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/australian-politics","apiUrl":"http://content.guardianapis.com/australia-news/australian-politics","sectionName":"Australia news"},{"id":"media/australia-media","webTitle":"Australian media","description":"Latest news and analysis on Australian media","type":"keyword","sectionId":"media","webUrl":"http://www.theguardian.com/media/australia-media","apiUrl":"http://content.guardianapis.com/media/australia-media","sectionName":"Media"},{"id":"media/media","webTitle":"Media","type":"keyword","sectionId":"media","webUrl":"http://www.theguardian.com/media/media","apiUrl":"http://content.guardianapis.com/media/media","sectionName":"Media"},{"id":"politics/polls","webTitle":"Opinion polls","type":"keyword","sectionId":"politics","webUrl":"http://www.theguardian.com/politics/polls","apiUrl":"http://content.guardianapis.com/politics/polls","sectionName":"Politics"},{"id":"australia-news/gillian-triggs","webTitle":"Gillian Triggs","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/gillian-triggs","apiUrl":"http://content.guardianapis.com/australia-news/gillian-triggs","sectionName":"Australia news"},{"id":"world/charlie-hebdo-attack","webTitle":"Charlie Hebdo attack","description":"Latest news and comment on the Charlie Hebdo attack in Paris ","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/charlie-hebdo-attack","apiUrl":"http://content.guardianapis.com/world/charlie-hebdo-attack","sectionName":"World news"},{"id":"world/paris-attacks","webTitle":"Paris attacks","description":"The latest news and opinion on the attacks across Paris on 13 November 2015","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/paris-attacks","apiUrl":"http://content.guardianapis.com/world/paris-attacks","sectionName":"World news"},{"id":"australia-news/sydney-siege","webTitle":"Sydney siege","description":"The latest news and comment on the Sydney siege","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/sydney-siege","apiUrl":"http://content.guardianapis.com/australia-news/sydney-siege","sectionName":"Australia news"},{"id":"us-news/rachel-dolezal","webTitle":"Rachel Dolezal","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/rachel-dolezal","apiUrl":"http://content.guardianapis.com/us-news/rachel-dolezal","sectionName":"US news"},{"id":"world/refugees","webTitle":"Refugees","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/refugees","apiUrl":"http://content.guardianapis.com/world/refugees","sectionName":"World news"},{"id":"sport/adam-goodes","webTitle":"Adam Goodes","description":"Adam Goodes is an Australian rules football professional","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/adam-goodes","apiUrl":"http://content.guardianapis.com/sport/adam-goodes","sectionName":"Sport"},{"id":"australia-news/australia-news","webTitle":"Australia news","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/australia-news","apiUrl":"http://content.guardianapis.com/australia-news/australia-news","sectionName":"Australia news"}]},{"type":"article","sectionId":"us-news","webTitle":"US plan to deport undocumented families angers Democratic candidates","webPublicationDate":"2015-12-24T21:06:24Z","id":"us-news/2015/dec/24/homeland-security-raids-deportation-undocumented-families-angers-democratic-candidates","webUrl":"http://www.theguardian.com/us-news/2015/dec/24/homeland-security-raids-deportation-undocumented-families-angers-democratic-candidates","apiUrl":"http://content.guardianapis.com/us-news/2015/dec/24/homeland-security-raids-deportation-undocumented-families-angers-democratic-candidates","sectionName":"US news","tags":[{"id":"us-news/usimmigration","webTitle":"US immigration","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/usimmigration","apiUrl":"http://content.guardianapis.com/us-news/usimmigration","sectionName":"US news"},{"id":"us-news/obama-administration","webTitle":"Obama administration","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/obama-administration","apiUrl":"http://content.guardianapis.com/us-news/obama-administration","sectionName":"US news"},{"id":"us-news/us-news","webTitle":"US news","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/us-news","apiUrl":"http://content.guardianapis.com/us-news/us-news","sectionName":"US news"}]},{"type":"article","sectionId":"music","webTitle":"Readers recommend: songs about gifts and giving | Peter Kimpton","webPublicationDate":"2015-12-24T20:00:30Z","id":"music/musicblog/2015/dec/24/christmas-gifts-presents-giving-songs-readers-recommend","webUrl":"http://www.theguardian.com/music/musicblog/2015/dec/24/christmas-gifts-presents-giving-songs-readers-recommend","apiUrl":"http://content.guardianapis.com/music/musicblog/2015/dec/24/christmas-gifts-presents-giving-songs-readers-recommend","sectionName":"Music","tags":[{"id":"music/music","webTitle":"Music","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/music","apiUrl":"http://content.guardianapis.com/music/music","sectionName":"Music"},{"id":"music/popandrock","webTitle":"Pop and rock","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/popandrock","apiUrl":"http://content.guardianapis.com/music/popandrock","sectionName":"Music"},{"id":"lifeandstyle/christmas","webTitle":"Christmas","type":"keyword","sectionId":"lifeandstyle","webUrl":"http://www.theguardian.com/lifeandstyle/christmas","apiUrl":"http://content.guardianapis.com/lifeandstyle/christmas","sectionName":"Life and style"},{"id":"music/folk","webTitle":"Folk music","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/folk","apiUrl":"http://content.guardianapis.com/music/folk","sectionName":"Music"},{"id":"music/soul","webTitle":"Soul","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/soul","apiUrl":"http://content.guardianapis.com/music/soul","sectionName":"Music"},{"id":"lifeandstyle/shopping","webTitle":"Shopping","type":"keyword","sectionId":"lifeandstyle","webUrl":"http://www.theguardian.com/lifeandstyle/shopping","apiUrl":"http://content.guardianapis.com/lifeandstyle/shopping","sectionName":"Life and style"},{"id":"business/retail","webTitle":"Retail industry","type":"keyword","sectionId":"business","webUrl":"http://www.theguardian.com/business/retail","apiUrl":"http://content.guardianapis.com/business/retail","sectionName":"Business"},{"id":"music/indie","webTitle":"Indie","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/indie","apiUrl":"http://content.guardianapis.com/music/indie","sectionName":"Music"},{"id":"lifeandstyle/lifeandstyle","webTitle":"Life and style","type":"keyword","sectionId":"lifeandstyle","webUrl":"http://www.theguardian.com/lifeandstyle/lifeandstyle","apiUrl":"http://content.guardianapis.com/lifeandstyle/lifeandstyle","sectionName":"Life and style"},{"id":"film/film","webTitle":"Film","type":"keyword","sectionId":"film","webUrl":"http://www.theguardian.com/film/film","apiUrl":"http://content.guardianapis.com/film/film","sectionName":"Film"},{"id":"culture/culture","webTitle":"Culture","type":"keyword","sectionId":"culture","webUrl":"http://www.theguardian.com/culture/culture","apiUrl":"http://content.guardianapis.com/culture/culture","sectionName":"Culture"},{"id":"music/country","webTitle":"Country","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/country","apiUrl":"http://content.guardianapis.com/music/country","sectionName":"Music"},{"id":"music/aretha-franklin","webTitle":"Aretha Franklin","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/aretha-franklin","apiUrl":"http://content.guardianapis.com/music/aretha-franklin","sectionName":"Music"},{"id":"music/jonimitchell","webTitle":"Joni Mitchell","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/jonimitchell","apiUrl":"http://content.guardianapis.com/music/jonimitchell","sectionName":"Music"},{"id":"film/horror","webTitle":"Horror","type":"keyword","sectionId":"film","webUrl":"http://www.theguardian.com/film/horror","apiUrl":"http://content.guardianapis.com/film/horror","sectionName":"Film"}]},{"type":"article","sectionId":"australia-news","webTitle":"British Syrian-born woman has visa revoked without explanation before flight to Australia","webPublicationDate":"2015-12-24T17:25:35Z","id":"australia-news/2015/dec/24/british-syrian-born-woman-has-visa-revoked-without-explanation-before-flight-to-australia","webUrl":"http://www.theguardian.com/australia-news/2015/dec/24/british-syrian-born-woman-has-visa-revoked-without-explanation-before-flight-to-australia","apiUrl":"http://content.guardianapis.com/australia-news/2015/dec/24/british-syrian-born-woman-has-visa-revoked-without-explanation-before-flight-to-australia","sectionName":"Australia news","tags":[{"id":"australia-news/australian-immigration-and-asylum","webTitle":"Australian immigration and asylum","description":"Latest news affecting Australian immigration and asylum from the Guardian","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/australian-immigration-and-asylum","apiUrl":"http://content.guardianapis.com/australia-news/australian-immigration-and-asylum","sectionName":"Australia news"},{"id":"uk/uk","webTitle":"UK news","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/uk","apiUrl":"http://content.guardianapis.com/uk/uk","sectionName":"UK news"},{"id":"australia-news/australia-news","webTitle":"Australia news","type":"keyword","sectionId":"australia-news","webUrl":"http://www.theguardian.com/australia-news/australia-news","apiUrl":"http://content.guardianapis.com/australia-news/australia-news","sectionName":"Australia news"}]},{"type":"article","sectionId":"world","webTitle":"Put on some Putin: Russian president inspires new perfume","webPublicationDate":"2015-12-24T17:24:53Z","id":"world/2015/dec/24/vladimir-putin-perfume-leaders-number-one","webUrl":"http://www.theguardian.com/world/2015/dec/24/vladimir-putin-perfume-leaders-number-one","apiUrl":"http://content.guardianapis.com/world/2015/dec/24/vladimir-putin-perfume-leaders-number-one","sectionName":"World news","tags":[{"id":"world/vladimir-putin","webTitle":"Vladimir Putin","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/vladimir-putin","apiUrl":"http://content.guardianapis.com/world/vladimir-putin","sectionName":"World news"},{"id":"fashion/fragrance","webTitle":"Fragrance","description":"News, features and reviews of perfume, aftershave, scent and fragrances.","type":"keyword","sectionId":"fashion","webUrl":"http://www.theguardian.com/fashion/fragrance","apiUrl":"http://content.guardianapis.com/fashion/fragrance","sectionName":"Fashion"},{"id":"world/russia","webTitle":"Russia","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/russia","apiUrl":"http://content.guardianapis.com/world/russia","sectionName":"World news"},{"id":"world/world","webTitle":"World news","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/world","apiUrl":"http://content.guardianapis.com/world/world","sectionName":"World news"}]},{"type":"article","sectionId":"tv-and-radio","webTitle":"Serial recap  season two, episode three: Escaping","webPublicationDate":"2015-12-24T16:53:28Z","id":"tv-and-radio/2015/dec/24/serial-recap-season-two-episode-three-escaping-bowe-bergdahl","webUrl":"http://www.theguardian.com/tv-and-radio/2015/dec/24/serial-recap-season-two-episode-three-escaping-bowe-bergdahl","apiUrl":"http://content.guardianapis.com/tv-and-radio/2015/dec/24/serial-recap-season-two-episode-three-escaping-bowe-bergdahl","sectionName":"Television & radio","tags":[{"id":"tv-and-radio/serial","webTitle":"Serial","description":"The latest news and comment on the podcast series Serial, an episodic investigative journalism program from the producers of This American Life","type":"keyword","sectionId":"tv-and-radio","webUrl":"http://www.theguardian.com/tv-and-radio/serial","apiUrl":"http://content.guardianapis.com/tv-and-radio/serial","sectionName":"Television & radio"},{"id":"media/podcasting","webTitle":"Podcasting","type":"keyword","sectionId":"media","webUrl":"http://www.theguardian.com/media/podcasting","apiUrl":"http://content.guardianapis.com/media/podcasting","sectionName":"Media"},{"id":"us-news/bowe-bergdahl","webTitle":"Bowe Bergdahl","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/bowe-bergdahl","apiUrl":"http://content.guardianapis.com/us-news/bowe-bergdahl","sectionName":"US news"},{"id":"culture/culture","webTitle":"Culture","type":"keyword","sectionId":"culture","webUrl":"http://www.theguardian.com/culture/culture","apiUrl":"http://content.guardianapis.com/culture/culture","sectionName":"Culture"},{"id":"culture/radio","webTitle":"Radio","type":"keyword","sectionId":"tv-and-radio","webUrl":"http://www.theguardian.com/culture/radio","apiUrl":"http://content.guardianapis.com/culture/radio","sectionName":"Television & radio"},{"id":"media/digital-media","webTitle":"Digital media","type":"keyword","sectionId":"media","webUrl":"http://www.theguardian.com/media/digital-media","apiUrl":"http://content.guardianapis.com/media/digital-media","sectionName":"Media"}]},{"type":"article","sectionId":"us-news","webTitle":"Tornadoes and severe storms across southern US leave at least 11 dead","webPublicationDate":"2015-12-24T16:48:45Z","id":"us-news/2015/dec/24/tornadoes-storms-the-south-holiday-travel-deaths","webUrl":"http://www.theguardian.com/us-news/2015/dec/24/tornadoes-storms-the-south-holiday-travel-deaths","apiUrl":"http://content.guardianapis.com/us-news/2015/dec/24/tornadoes-storms-the-south-holiday-travel-deaths","sectionName":"US news","tags":[{"id":"us-news/us-news","webTitle":"US news","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/us-news","apiUrl":"http://content.guardianapis.com/us-news/us-news","sectionName":"US news"},{"id":"us-news/us-weather","webTitle":"US weather","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/us-weather","apiUrl":"http://content.guardianapis.com/us-news/us-weather","sectionName":"US news"},{"id":"us-news/tennessee","webTitle":"Tennessee","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/tennessee","apiUrl":"http://content.guardianapis.com/us-news/tennessee","sectionName":"US news"},{"id":"us-news/mississippi","webTitle":"Mississippi","type":"keyword","sectionId":"us-news","webUrl":"http://www.theguardian.com/us-news/mississippi","apiUrl":"http://content.guardianapis.com/us-news/mississippi","sectionName":"US news"}]},{"type":"article","sectionId":"uk-news","webTitle":"Homelessness, health and humanity on the streets of Britain's capital","webPublicationDate":"2015-12-24T16:28:50Z","id":"uk-news/davehillblog/2015/dec/24/homelessness-health-and-humanity-on-the-streets-of-britains-capital","webUrl":"http://www.theguardian.com/uk-news/davehillblog/2015/dec/24/homelessness-health-and-humanity-on-the-streets-of-britains-capital","apiUrl":"http://content.guardianapis.com/uk-news/davehillblog/2015/dec/24/homelessness-health-and-humanity-on-the-streets-of-britains-capital","sectionName":"UK news","tags":[{"id":"uk/uk","webTitle":"UK news","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/uk","apiUrl":"http://content.guardianapis.com/uk/uk","sectionName":"UK news"},{"id":"uk/london","webTitle":"London","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/london","apiUrl":"http://content.guardianapis.com/uk/london","sectionName":"UK news"},{"id":"politics/politics","webTitle":"Politics","type":"keyword","sectionId":"politics","webUrl":"http://www.theguardian.com/politics/politics","apiUrl":"http://content.guardianapis.com/politics/politics","sectionName":"Politics"},{"id":"politics/london","webTitle":"London politics","type":"keyword","sectionId":"politics","webUrl":"http://www.theguardian.com/politics/london","apiUrl":"http://content.guardianapis.com/politics/london","sectionName":"Politics"},{"id":"politics/mayoral-elections","webTitle":"Mayoral elections","type":"keyword","sectionId":"politics","webUrl":"http://www.theguardian.com/politics/mayoral-elections","apiUrl":"http://content.guardianapis.com/politics/mayoral-elections","sectionName":"Politics"},{"id":"society/society","webTitle":"Society","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/society","apiUrl":"http://content.guardianapis.com/society/society","sectionName":"Society"},{"id":"politics/localgovernment","webTitle":"Local politics","type":"keyword","sectionId":"politics","webUrl":"http://www.theguardian.com/politics/localgovernment","apiUrl":"http://content.guardianapis.com/politics/localgovernment","sectionName":"Politics"},{"id":"society/localgovernment","webTitle":"Local government","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/localgovernment","apiUrl":"http://content.guardianapis.com/society/localgovernment","sectionName":"Society"},{"id":"society/homelessness","webTitle":"Homelessness","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/homelessness","apiUrl":"http://content.guardianapis.com/society/homelessness","sectionName":"Society"},{"id":"society/charities","webTitle":"Charities","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/charities","apiUrl":"http://content.guardianapis.com/society/charities","sectionName":"Society"},{"id":"society/voluntarysector","webTitle":"Voluntary sector","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/voluntarysector","apiUrl":"http://content.guardianapis.com/society/voluntarysector","sectionName":"Society"},{"id":"society/socialexclusion","webTitle":"Social exclusion","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/socialexclusion","apiUrl":"http://content.guardianapis.com/society/socialexclusion","sectionName":"Society"},{"id":"society/housing","webTitle":"Housing","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/housing","apiUrl":"http://content.guardianapis.com/society/housing","sectionName":"Society"},{"id":"society/communities","webTitle":"Communities","type":"keyword","sectionId":"society","webUrl":"http://www.theguardian.com/society/communities","apiUrl":"http://content.guardianapis.com/society/communities","sectionName":"Society"},{"id":"world/catholicism","webTitle":"Catholicism","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/catholicism","apiUrl":"http://content.guardianapis.com/world/catholicism","sectionName":"World news"},{"id":"world/world","webTitle":"World news","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/world","apiUrl":"http://content.guardianapis.com/world/world","sectionName":"World news"},{"id":"world/religion","webTitle":"Religion","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/religion","apiUrl":"http://content.guardianapis.com/world/religion","sectionName":"World news"},{"id":"world/christianity","webTitle":"Christianity","type":"keyword","sectionId":"world","webUrl":"http://www.theguardian.com/world/christianity","apiUrl":"http://content.guardianapis.com/world/christianity","sectionName":"World news"}]},{"type":"article","sectionId":"football","webTitle":"Farewell to (mens) footballs annus horribilis | Letters","webPublicationDate":"2015-12-24T16:18:47Z","id":"football/2015/dec/24/farewell-to-mens-footballs-annus-horribilis","webUrl":"http://www.theguardian.com/football/2015/dec/24/farewell-to-mens-footballs-annus-horribilis","apiUrl":"http://content.guardianapis.com/football/2015/dec/24/farewell-to-mens-footballs-annus-horribilis","sectionName":"Football","tags":[{"id":"football/football","webTitle":"Football","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/football","apiUrl":"http://content.guardianapis.com/football/football","sectionName":"Football"},{"id":"sport/sport","webTitle":"Sport","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/sport","apiUrl":"http://content.guardianapis.com/sport/sport","sectionName":"Sport"},{"id":"uk/uk","webTitle":"UK news","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/uk","apiUrl":"http://content.guardianapis.com/uk/uk","sectionName":"UK news"},{"id":"football/manchestercity","webTitle":"Manchester City","description":"Read the latest Manchester City news, transfer rumours, match reports, fixtures and live scores from the Guardian","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/manchestercity","apiUrl":"http://content.guardianapis.com/football/manchestercity","sectionName":"Football"},{"id":"football/chelsea","webTitle":"Chelsea","description":"Read the latest Chelsea news, transfer rumours, match reports, fixtures and live scores from the Guardian","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/chelsea","apiUrl":"http://content.guardianapis.com/football/chelsea","sectionName":"Football"},{"id":"football/fifa","webTitle":"Fifa","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/fifa","apiUrl":"http://content.guardianapis.com/football/fifa","sectionName":"Football"},{"id":"football/footballpolitics","webTitle":"Football politics","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/footballpolitics","apiUrl":"http://content.guardianapis.com/football/footballpolitics","sectionName":"Football"},{"id":"football/sepp-blatter","webTitle":"Sepp Blatter","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/sepp-blatter","apiUrl":"http://content.guardianapis.com/football/sepp-blatter","sectionName":"Football"},{"id":"football/michel-platini","webTitle":"Michel Platini","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/michel-platini","apiUrl":"http://content.guardianapis.com/football/michel-platini","sectionName":"Football"},{"id":"sport/andymurray","webTitle":"Andy Murray","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/andymurray","apiUrl":"http://content.guardianapis.com/sport/andymurray","sectionName":"Sport"},{"id":"sport/tennis","webTitle":"Tennis","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/tennis","apiUrl":"http://content.guardianapis.com/sport/tennis","sectionName":"Sport"},{"id":"sport/jessica-ennis","webTitle":"Jessica Ennis-Hill","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/jessica-ennis","apiUrl":"http://content.guardianapis.com/sport/jessica-ennis","sectionName":"Sport"},{"id":"sport/athletics","webTitle":"Athletics","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/athletics","apiUrl":"http://content.guardianapis.com/sport/athletics","sectionName":"Sport"},{"id":"sport/rugbyleague","webTitle":"Rugby league","type":"keyword","sectionId":"sport","webUrl":"http://www.theguardian.com/sport/rugbyleague","apiUrl":"http://content.guardianapis.com/sport/rugbyleague","sectionName":"Sport"},{"id":"football/womensfootball","webTitle":"Women's football","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/womensfootball","apiUrl":"http://content.guardianapis.com/football/womensfootball","sectionName":"Football"},{"id":"football/women-s-world-cup-2015","webTitle":"Women's World Cup 2015","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/women-s-world-cup-2015","apiUrl":"http://content.guardianapis.com/football/women-s-world-cup-2015","sectionName":"Football"},{"id":"football/northampton","webTitle":"Northampton","type":"keyword","sectionId":"football","webUrl":"http://www.theguardian.com/football/northampton","apiUrl":"http://content.guardianapis.com/football/northampton","sectionName":"Football"}]},{"type":"article","sectionId":"music","webTitle":"Birminghams hall strikes the right chord | Letters","webPublicationDate":"2015-12-24T16:18:26Z","id":"music/2015/dec/24/birminghams-hall-strikes-the-right-chord","webUrl":"http://www.theguardian.com/music/2015/dec/24/birminghams-hall-strikes-the-right-chord","apiUrl":"http://content.guardianapis.com/music/2015/dec/24/birminghams-hall-strikes-the-right-chord","sectionName":"Music","tags":[{"id":"music/simon-rattle","webTitle":"Simon Rattle","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/simon-rattle","apiUrl":"http://content.guardianapis.com/music/simon-rattle","sectionName":"Music"},{"id":"uk/birmingham","webTitle":"Birmingham","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/birmingham","apiUrl":"http://content.guardianapis.com/uk/birmingham","sectionName":"UK news"},{"id":"music/music","webTitle":"Music","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/music","apiUrl":"http://content.guardianapis.com/music/music","sectionName":"Music"},{"id":"uk/london","webTitle":"London","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/london","apiUrl":"http://content.guardianapis.com/uk/london","sectionName":"UK news"},{"id":"uk/uk","webTitle":"UK news","type":"keyword","sectionId":"uk-news","webUrl":"http://www.theguardian.com/uk/uk","apiUrl":"http://content.guardianapis.com/uk/uk","sectionName":"UK news"},{"id":"music/classicalmusicandopera","webTitle":"Classical music","type":"keyword","sectionId":"music","webUrl":"http://www.theguardian.com/music/classicalmusicandopera","apiUrl":"http://content.guardianapis.com/music/classicalmusicandopera","sectionName":"Music"},{"id":"education/music","webTitle":"Music","type":"keyword","sectionId":"education","webUrl":"http://www.theguardian.com/education/music","apiUrl":"http://content.guardianapis.com/education/music","sectionName":"Education"}]}]}}"""

json2 = """
    { "response" : {
        "status": "ok",
        "results": [
                { "out": "span"
                },
                { "out": "lier"
                },
                { "out": "wards"
                }
            ]
        }
    }
"""

statusDec : Decoder String
statusDec = at ["response", "status"] string

-- Can use that with:
-- decodeString statusDec json

-- See http://stackoverflow.com/questions/32575003/elm-how-to-decode-data-from-json-api
-- See http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Json-Decode

outer : Decoder String
outer = ("out" := string)

outers : Decoder (List String)
outers = list outer

ress : Decoder (List String)
ress = at ["response", "results"] outers

{-
   > import Json.Decode exposing (..)
   > decodeString ress json2
   Ok ["span","lier","wards"] : Result.Result String (List String)
   >
-}

tagToWebTitle : Decoder String
tagToWebTitle = ("webTitle" := string)

tagToId : Decoder String
tagToId = ("id" := string)

