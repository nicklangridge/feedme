import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import '../styles/main.scss';
import App from './containers/App';

const albums = get_albums();

ReactDOM.render(
  <App albums={albums}/>,
  document.getElementById('main')
);

function get_albums() {
  return [
   {
      "album_id":"133",
      "album_name":"Emergence",
      "album_slug":"emergence",
      "album_uri":"spotify:album:26vmJ6CjPxYWYYa2B4d9my",
      "artist_id":"131",
      "artist_name":"Max Cooper",
      "artist_slug":"max-cooper",
      "artist_uri":"spotify:artist:0WSSKmoRbxqLf3MnXInQ2J",
      "created":"2016-11-27 10:26:54",
      "genres":[
         {
            "name":"deep euro house",
            "slug":"deep-euro-house"
         },
         {
            "name":"deep melodic euro house",
            "slug":"deep-melodic-euro-house"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"microhouse",
            "slug":"microhouse"
         },
         {
            "name":"minimal techno",
            "slug":"minimal-techno"
         },
         {
            "name":"tech house",
            "slug":"tech-house"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/5f33042f977182f71becc292674fb4e375de299a",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/11\/max-cooper-emergence\/"
         }
      ]
   },
   {
      "album_id":"132",
      "album_name":"Complekt",
      "album_slug":"complekt",
      "album_uri":"spotify:album:1gge3WnJ5j39qG7bKyVBGf",
      "artist_id":"130",
      "artist_name":"Landing",
      "artist_slug":"landing",
      "artist_uri":"spotify:artist:6jrhwgDm1EcvFgDJoo8eY1",
      "created":"2016-11-27 10:26:33",
      "genres":[
         {
            "name":"slow core",
            "slug":"slow-core"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/17c9ac267b67a902538bbe1cbba2f9488e66ca83",
      "reviews":[
         {
            "name":"Spin",
            "slug":"spin",
            "url":"http:\/\/www.spin.com\/2016\/11\/landing-complekt-premiere\/"
         }
      ]
   },
   {
      "album_id":"131",
      "album_name":"Analogue Creatures Living On An Island",
      "album_slug":"analogue-creatures-living-on-an-island",
      "album_uri":"spotify:album:700mTVNrnf2mfCsnT9SA8X",
      "artist_id":"129",
      "artist_name":"Immersion",
      "artist_slug":"immersion",
      "artist_uri":"spotify:artist:70rsyhGzfQKX1k8QZDzK1d",
      "created":"2016-11-27 10:26:11",
      "genres":[
         {
            "name":"acid techno",
            "slug":"acid-techno"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/91ab0d7bd39f422a78ab4cbecd0e969f66b4184f",
      "reviews":[
         {
            "name":"The Quietus",
            "slug":"quietus",
            "url":"http:\/\/thequietus.com\/articles\/21318-immersion-analogue-creatures-living-on-an-island-album-review"
         }
      ]
   },
   {
      "album_id":"129",
      "album_name":"Guardians",
      "album_slug":"guardians",
      "album_uri":"spotify:album:5dymAjByvfPsuDfCzLT7nQ",
      "artist_id":"127",
      "artist_name":"Saor",
      "artist_slug":"saor",
      "artist_uri":"spotify:artist:4rHMzJ1RKUMtid1K2QEYbr",
      "created":"2016-11-27 10:25:39",
      "genres":[
         {
            "name":"atmospheric black metal",
            "slug":"atmospheric-black-metal"
         },
         {
            "name":"avantgarde metal",
            "slug":"avantgarde-metal"
         },
         {
            "name":"folk metal",
            "slug":"folk-metal"
         },
         {
            "name":"pagan black metal",
            "slug":"pagan-black-metal"
         },
         {
            "name":"viking metal",
            "slug":"viking-metal"
         },
         {
            "name":"voidgaze",
            "slug":"voidgaze"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/159c0fc2cdb9a15d731b830409dfcb63a717219d",
      "reviews":[
         {
            "name":"The Quietus",
            "slug":"quietus",
            "url":"http:\/\/thequietus.com\/articles\/21369-saor-guardians-andy-marshall-album-review"
         }
      ]
   },
   {
      "album_id":"128",
      "album_name":"Telepath",
      "album_slug":"telepath",
      "album_uri":"spotify:album:2CiqGQuZLBwuerYTGnvORK",
      "artist_id":"126",
      "artist_name":"HORNSS",
      "artist_slug":"hornss",
      "artist_uri":"spotify:artist:58KlJRj4jAgELZtOir7qIr",
      "created":"2016-11-27 10:25:39",
      "genres":[
         {
            "name":"psychedelic doom",
            "slug":"psychedelic-doom"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/3ba49b8b072f025083a75e52a5912e6963243240",
      "reviews":[
         {
            "name":"The Quietus",
            "slug":"quietus",
            "url":"http:\/\/thequietus.com\/articles\/21370-hornss-telepath-album-review"
         }
      ]
   },
   {
      "album_id":"127",
      "album_name":"Starting Point of the Royal Cyclopean",
      "album_slug":"starting-point-of-the-royal-cyclopean",
      "album_uri":"spotify:album:0WC22CzRk1dKT1iAHFw4yR",
      "artist_id":"125",
      "artist_name":"ESP Ohio",
      "artist_slug":"esp-ohio",
      "artist_uri":"spotify:artist:0GrrKNwVoavHBMDE0f5upS",
      "created":"2016-11-27 10:24:54",
      "genres":[
         {
            "name":"gbvfi",
            "slug":"gbvfi"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/ea0c1e96310ea7482b3e5395edb464cd801b18f0",
      "reviews":[
         {
            "name":"Spotinews",
            "slug":"spotinews",
            "url":"https:\/\/spotinews.wordpress.com\/2016\/11\/23\/esp-ohio-starting-point-of-the-royal-cyclopean\/"
         }
      ]
   },
   {
      "album_id":"123",
      "album_name":"Glory Days (Deluxe)",
      "album_slug":"glory-days-deluxe",
      "album_uri":"spotify:album:2GJLzxAajkFeyDPVH7X4Cs",
      "artist_id":"121",
      "artist_name":"Little Mix",
      "artist_slug":"little-mix",
      "artist_uri":"spotify:artist:3e7awlrlDSwF3iM0WBjGMp",
      "created":"2016-11-27 10:24:42",
      "genres":[
         {
            "name":"dance pop",
            "slug":"dance-pop"
         },
         {
            "name":"pop",
            "slug":"pop"
         },
         {
            "name":"post-teen pop",
            "slug":"post-teen-pop"
         },
         {
            "name":"talent show",
            "slug":"talent-show"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/becbe3bc62dafa4ab9edd7ef313f6ab3fe38b5b6",
      "reviews":[
         {
            "name":"The Line of Best Fit",
            "slug":"bestfit",
            "url":"http:\/\/www.thelineofbestfit.com\/reviews\/albums\/glory-days-little-mix-review"
         }
      ]
   },
   {
      "album_id":"124",
      "album_name":"Forward Constant Motion",
      "album_slug":"forward-constant-motion",
      "album_uri":"spotify:album:5KPVFLgmqrsAWL6HYtEnZq",
      "artist_id":"122",
      "artist_name":"Virginia Wing",
      "artist_slug":"virginia-wing",
      "artist_uri":"spotify:artist:26YMx1oNjSN1c0qZHLyZ2k",
      "created":"2016-11-27 10:24:42",
      "genres":[
         {
            "name":"garage psych",
            "slug":"garage-psych"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/c44dca7dc06fb334fab0adfa99ce1784a90581ca",
      "reviews":[
         {
            "name":"The Line of Best Fit",
            "slug":"bestfit",
            "url":"http:\/\/www.thelineofbestfit.com\/reviews\/albums\/virginia-wing-forward-constant-motion"
         }
      ]
   },
   {
      "album_id":"120",
      "album_name":"Redemption",
      "album_slug":"redemption",
      "album_uri":"spotify:album:5EWjm9YHk3X7gV5PzuAV4c",
      "artist_id":"118",
      "artist_name":"Dawn Richard",
      "artist_slug":"dawn-richard",
      "artist_uri":"spotify:artist:6pSsE5y0uJMwYj83KrPyf9",
      "created":"2016-11-27 10:23:47",
      "genres":[
         {
            "name":"dance pop",
            "slug":"dance-pop"
         },
         {
            "name":"deep indie r&b",
            "slug":"deep-indie-randb"
         },
         {
            "name":"deep pop r&b",
            "slug":"deep-pop-randb"
         },
         {
            "name":"escape room",
            "slug":"escape-room"
         },
         {
            "name":"hip pop",
            "slug":"hip-pop"
         },
         {
            "name":"indie r&b",
            "slug":"indie-randb"
         },
         {
            "name":"neo soul",
            "slug":"neo-soul"
         },
         {
            "name":"r&b",
            "slug":"randb"
         },
         {
            "name":"urban contemporary",
            "slug":"urban-contemporary"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/940e84bcacf2b02df6e1c9304781e3e2d7743653",
      "reviews":[
         {
            "name":"Pitchfork",
            "slug":"pitchfork",
            "url":"http:\/\/pitchfork.com\/reviews\/albums\/22648-redemption\/"
         }
      ]
   },
   {
      "album_id":"121",
      "album_name":"WORRY.",
      "album_slug":"worry",
      "album_uri":"spotify:album:25DyIBkqzuy4YD5BgJEgm0",
      "artist_id":"119",
      "artist_name":"Jeff Rosenstock",
      "artist_slug":"jeff-rosenstock",
      "artist_uri":"spotify:artist:0wNZvrIMNUCs24G0wFg2D6",
      "created":"2016-11-27 10:23:47",
      "genres":[
         {
            "name":"alternative emo",
            "slug":"alternative-emo"
         },
         {
            "name":"emo",
            "slug":"emo"
         },
         {
            "name":"folk punk",
            "slug":"folk-punk"
         },
         {
            "name":"indie punk",
            "slug":"indie-punk"
         },
         {
            "name":"lo-fi",
            "slug":"lo-fi"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/8f64cc941ca1d8e352c622f3c525d32c42c183cc",
      "reviews":[
         {
            "name":"Pitchfork",
            "slug":"pitchfork",
            "url":"http:\/\/pitchfork.com\/reviews\/albums\/22622-worry\/"
         }
      ]
   },
   {
      "album_id":"117",
      "album_name":"Death Certificate",
      "album_slug":"death-certificate",
      "album_uri":"spotify:album:0VoorTgcwMRROTmmZlxPSG",
      "artist_id":"115",
      "artist_name":"Ice Cube",
      "artist_slug":"ice-cube",
      "artist_uri":"spotify:artist:3Mcii5XWf6E0lrY3Uky4cA",
      "created":"2016-11-27 10:23:46",
      "genres":[
         {
            "name":"dirty south rap",
            "slug":"dirty-south-rap"
         },
         {
            "name":"g funk",
            "slug":"g-funk"
         },
         {
            "name":"gangster rap",
            "slug":"gangster-rap"
         },
         {
            "name":"hardcore hip hop",
            "slug":"hardcore-hip-hop"
         },
         {
            "name":"hip hop",
            "slug":"hip-hop"
         },
         {
            "name":"pop rap",
            "slug":"pop-rap"
         },
         {
            "name":"rap",
            "slug":"rap"
         },
         {
            "name":"southern hip hop",
            "slug":"southern-hip-hop"
         },
         {
            "name":"west coast rap",
            "slug":"west-coast-rap"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/d77181302596001b87cf1704ea6a49354c255909",
      "reviews":[
         {
            "name":"Pitchfork",
            "slug":"pitchfork",
            "url":"http:\/\/pitchfork.com\/reviews\/albums\/22561-death-certificate\/"
         }
      ]
   },
   {
      "album_id":"118",
      "album_name":"What's Your Sign?",
      "album_slug":"whats-your-sign",
      "album_uri":"spotify:album:7ftZThvecoYcYLtaSz463F",
      "artist_id":"116",
      "artist_name":"Oneida",
      "artist_slug":"oneida",
      "artist_uri":"spotify:artist:6If4kQp0rhfVgAZDNudjjS",
      "created":"2016-11-27 10:23:46",
      "genres":[
         {
            "name":"experimental rock",
            "slug":"experimental-rock"
         },
         {
            "name":"neo-psychedelic",
            "slug":"neo-psychedelic"
         },
         {
            "name":"noise rock",
            "slug":"noise-rock"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/55491449c46690309722e3a4a2bbd837e9666f82",
      "reviews":[
         {
            "name":"Pitchfork",
            "slug":"pitchfork",
            "url":"http:\/\/pitchfork.com\/reviews\/albums\/22531-oneida-rhys-chatham-whats-your-sign\/"
         }
      ]
   },
   {
      "album_id":"119",
      "album_name":"Vergers",
      "album_slug":"vergers",
      "album_uri":"spotify:album:2MfGjYqGBrXFFPqr2Cduv6",
      "artist_id":"117",
      "artist_name":"Sarah Davachi",
      "artist_slug":"sarah-davachi",
      "artist_uri":"spotify:artist:2Swn6We5XXpyDz1YxRkprA",
      "created":"2016-11-27 10:23:46",
      "genres":[
         {
            "name":"mandible",
            "slug":"mandible"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/ee9b27910bb9c001d6cf5867d212f537f82d2bfc",
      "reviews":[
         {
            "name":"Pitchfork",
            "slug":"pitchfork",
            "url":"http:\/\/pitchfork.com\/reviews\/albums\/22533-vergers\/"
         }
      ]
   },
   {
      "album_id":"115",
      "album_name":"In Waves",
      "album_slug":"in-waves",
      "album_uri":"spotify:album:5SXoacnbj1KYzJyMyzeGHj",
      "artist_id":"113",
      "artist_name":"Lord Of The Isles",
      "artist_slug":"lord-of-the-isles",
      "artist_uri":"spotify:artist:2PoiNhvPSC4fivyrDJOoru",
      "created":"2016-11-27 10:23:18",
      "genres":[
         {
            "name":"balearic",
            "slug":"balearic"
         },
         {
            "name":"deep soul house",
            "slug":"deep-soul-house"
         },
         {
            "name":"float house",
            "slug":"float-house"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/e0494b77fb2de5de21261dfc1e05cf6c4ec3acd0",
      "reviews":[
         {
            "name":"Resident Advisor",
            "slug":"residentadvisor",
            "url":"http:\/\/www.residentadvisor.net\/review-view.aspx?id=20140"
         }
      ]
   },
   {
      "album_id":"113",
      "album_name":"On The Green Again",
      "album_slug":"on-the-green-again",
      "album_uri":"spotify:album:1ASGNkMTcydM6JMFOWzMmD",
      "artist_id":"111",
      "artist_name":"Tiger & Woods",
      "artist_slug":"tiger-and-woods",
      "artist_uri":"spotify:artist:0AEi1DK5ehyvkZzOUlqEVz",
      "created":"2016-11-27 10:23:17",
      "genres":[
         {
            "name":"balearic",
            "slug":"balearic"
         },
         {
            "name":"deep soul house",
            "slug":"deep-soul-house"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"nu disco",
            "slug":"nu-disco"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/e35a03d06ff9245afa470f00e73d186045d69ef0",
      "reviews":[
         {
            "name":"Resident Advisor",
            "slug":"residentadvisor",
            "url":"http:\/\/www.residentadvisor.net\/review-view.aspx?id=20003"
         }
      ]
   },
   {
      "album_id":"114",
      "album_name":"Full On Mask Hysteria",
      "album_slug":"full-on-mask-hysteria",
      "album_uri":"spotify:album:6f4KhDYOLZxTr0opG0Bqfm",
      "artist_id":"112",
      "artist_name":"Altern 8",
      "artist_slug":"altern-8",
      "artist_uri":"spotify:artist:4rOv05Duzyn6YkBfQepDYC",
      "created":"2016-11-27 10:23:17",
      "genres":[
         {
            "name":"acid house",
            "slug":"acid-house"
         },
         {
            "name":"breakbeat",
            "slug":"breakbeat"
         },
         {
            "name":"electronic",
            "slug":"electronic"
         },
         {
            "name":"hardcore techno",
            "slug":"hardcore-techno"
         },
         {
            "name":"hip house",
            "slug":"hip-house"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/0f848a52e027e7524beda322b5228f8a094a81b5",
      "reviews":[
         {
            "name":"Resident Advisor",
            "slug":"residentadvisor",
            "url":"http:\/\/www.residentadvisor.net\/review-view.aspx?id=19983"
         }
      ]
   },
   {
      "album_id":"111",
      "album_name":"The Heavy Entertainment Show (Deluxe)",
      "album_slug":"the-heavy-entertainment-show-deluxe",
      "album_uri":"spotify:album:002H8sA77XFikjH4kbPaph",
      "artist_id":"109",
      "artist_name":"Robbie Williams",
      "artist_slug":"robbie-williams",
      "artist_uri":"spotify:artist:2HcwFjNelS49kFbfvMxQYw",
      "created":"2016-11-27 10:22:33",
      "genres":[
         {
            "name":"boy band",
            "slug":"boy-band"
         },
         {
            "name":"dance pop",
            "slug":"dance-pop"
         },
         {
            "name":"europop",
            "slug":"europop"
         },
         {
            "name":"neo mellow",
            "slug":"neo-mellow"
         },
         {
            "name":"pop",
            "slug":"pop"
         },
         {
            "name":"pop christmas",
            "slug":"pop-christmas"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/27024c76862d416397aadf5b51b49be16ba64b33",
      "reviews":[
         {
            "name":"Clash",
            "slug":"clash",
            "url":"http:\/\/www.clashmusic.com\/reviews\/robbie-williams-the-heavy-entertainment-show"
         }
      ]
   },
   {
      "album_id":"109",
      "album_name":"Neume",
      "album_slug":"neume",
      "album_uri":"spotify:album:2S0siM2VAHS4RuFpprIbha",
      "artist_id":"107",
      "artist_name":"Answer Code Request",
      "artist_slug":"answer-code-request",
      "artist_uri":"spotify:artist:52NOZYgYNsmv3nS0me6cqO",
      "created":"2016-11-22 19:06:21",
      "genres":[
         {
            "name":"dub techno",
            "slug":"dub-techno"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"minimal dub",
            "slug":"minimal-dub"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         },
         {
            "name":"techno",
            "slug":"techno"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/ca540d519c7aeca9d85ea654fd0c2f827da5152a",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/06\/answer-code-request-neume\/"
         }
      ]
   },
   {
      "album_id":"106",
      "album_name":"Cyclicality Between Procyon and Gomeisa",
      "album_slug":"cyclicality-between-procyon-and-gomeisa",
      "album_uri":"spotify:album:71DS3bGr97gNTQCWbZAZc5",
      "artist_id":"104",
      "artist_name":"Vakula",
      "artist_slug":"vakula",
      "artist_uri":"spotify:artist:71LM30jsskgKlpbBHDliB8",
      "created":"2016-11-22 19:06:20",
      "genres":[
         {
            "name":"deep soul house",
            "slug":"deep-soul-house"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/6648896d19c96d912d9d73f3c0d5e987cb76cd35",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/07\/vakula-cyclicality-between-procyon-and-gomeisa\/"
         }
      ]
   },
   {
      "album_id":"104",
      "album_name":"Kern, Vol. 3 (Continuous Mix)",
      "album_slug":"kern-vol-3-continuous-mix",
      "album_uri":"spotify:album:1tciG9V2wfWrU4191zQYJa",
      "artist_id":"102",
      "artist_name":"Objekt",
      "artist_slug":"objekt",
      "artist_uri":"spotify:artist:44z1nVVXZE8d4njcQmQLWc",
      "created":"2016-11-22 19:06:19",
      "genres":[
         {
            "name":"bass music",
            "slug":"bass-music"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"fluxwork",
            "slug":"fluxwork"
         },
         {
            "name":"future garage",
            "slug":"future-garage"
         },
         {
            "name":"minimal dub",
            "slug":"minimal-dub"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/23858fca371f91ae57e54d892761efd041728b4a",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/07\/objekt-kern-vol-3\/"
         }
      ]
   },
   {
      "album_id":"102",
      "album_name":"LA",
      "album_slug":"la",
      "album_uri":"spotify:album:4Ce8lbZbxE3X1WhJiabzIM",
      "artist_id":"100",
      "artist_name":"Djrum",
      "artist_slug":"djrum",
      "artist_uri":"spotify:artist:4HwlolvniI44ETSg5tajeZ",
      "created":"2016-11-22 19:06:18",
      "genres":[
         {
            "name":"bass music",
            "slug":"bass-music"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"fluxwork",
            "slug":"fluxwork"
         },
         {
            "name":"future garage",
            "slug":"future-garage"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         },
         {
            "name":"substep",
            "slug":"substep"
         },
         {
            "name":"wonky",
            "slug":"wonky"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/0911df0e5d619afe6791f850e50c2b0792cc0087",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/07\/djrum-la\/"
         }
      ]
   },
   {
      "album_id":"100",
      "album_name":"Arc Angel",
      "album_slug":"arc-angel",
      "album_uri":"spotify:album:2Ip5pSdQF7SGyBIAlGeIp3",
      "artist_id":"98",
      "artist_name":"Planetary Assault Systems",
      "artist_slug":"planetary-assault-systems",
      "artist_uri":"spotify:artist:7umQgFrDu3yrchEbFfJd60",
      "created":"2016-11-22 19:06:17",
      "genres":[
         {
            "name":"acid house",
            "slug":"acid-house"
         },
         {
            "name":"detroit techno",
            "slug":"detroit-techno"
         },
         {
            "name":"dub techno",
            "slug":"dub-techno"
         },
         {
            "name":"electro",
            "slug":"electro"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"microhouse",
            "slug":"microhouse"
         },
         {
            "name":"minimal dub",
            "slug":"minimal-dub"
         },
         {
            "name":"minimal techno",
            "slug":"minimal-techno"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         },
         {
            "name":"techno",
            "slug":"techno"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/d9f6ead3b8979b559bfadcdc2e8f5de823bf8f29",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/09\/planetary-assault-systems-arc-angel\/"
         }
      ]
   },
   {
      "album_id":"97",
      "album_name":"Alan Abrahams",
      "album_slug":"alan-abrahams",
      "album_uri":"spotify:album:1291SJfv7hMFuQhXRhzNew",
      "artist_id":"95",
      "artist_name":"Portable",
      "artist_slug":"portable",
      "artist_uri":"spotify:artist:64PiD6gdmMy2lEgS5XgdjR",
      "created":"2016-11-22 19:06:14",
      "genres":[
         {
            "name":"dub techno",
            "slug":"dub-techno"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"fluxwork",
            "slug":"fluxwork"
         },
         {
            "name":"microhouse",
            "slug":"microhouse"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/d4454565f2854eef354c7534086da6e7486d58bc",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/08\/portable-alan-abrahams\/"
         }
      ]
   },
   {
      "album_id":"98",
      "album_name":"The Bells",
      "album_slug":"the-bells",
      "album_uri":"spotify:album:1K4HO2nKwsJfZd0QmJqA60",
      "artist_id":"96",
      "artist_name":"KornÃ©l KovÃ¡cs",
      "artist_slug":"korna-l-kova-cs",
      "artist_uri":"spotify:artist:0Ij7th9uWcDVYNAIOn5W22",
      "created":"2016-11-22 19:06:14",
      "genres":[
         {
            "name":"balearic",
            "slug":"balearic"
         },
         {
            "name":"deep soul house",
            "slug":"deep-soul-house"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"fluxwork",
            "slug":"fluxwork"
         },
         {
            "name":"microhouse",
            "slug":"microhouse"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/13a7845f62bc917a5b3a18e8b354b2245e810f70",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/08\/kornel-kovacs-the-bells\/"
         }
      ]
   },
   {
      "album_id":"96",
      "album_name":"Sirens",
      "album_slug":"sirens",
      "album_uri":"spotify:album:2EvZiOMBlC9b5hbjbZCjZv",
      "artist_id":"94",
      "artist_name":"Nicolas Jaar",
      "artist_slug":"nicolas-jaar",
      "artist_uri":"spotify:artist:5a0etAzO5V26gvlbmHzT9W",
      "created":"2016-11-22 19:06:13",
      "genres":[
         {
            "name":"alternative dance",
            "slug":"alternative-dance"
         },
         {
            "name":"deep melodic euro house",
            "slug":"deep-melodic-euro-house"
         },
         {
            "name":"downtempo",
            "slug":"downtempo"
         },
         {
            "name":"electronic",
            "slug":"electronic"
         },
         {
            "name":"indie r&b",
            "slug":"indie-randb"
         },
         {
            "name":"indietronica",
            "slug":"indietronica"
         },
         {
            "name":"microhouse",
            "slug":"microhouse"
         },
         {
            "name":"minimal techno",
            "slug":"minimal-techno"
         },
         {
            "name":"new rave",
            "slug":"new-rave"
         },
         {
            "name":"nu jazz",
            "slug":"nu-jazz"
         },
         {
            "name":"trip hop",
            "slug":"trip-hop"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/e7ae3b621252ce33aa7ccfed39017939f3fa5d87",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/09\/nicolas-jaar-sirens\/"
         }
      ]
   },
   {
      "album_id":"95",
      "album_name":"Atrocity Exhibition",
      "album_slug":"atrocity-exhibition",
      "album_uri":"spotify:album:3e7vtKJ3m1zVh38VGq2g3H",
      "artist_id":"93",
      "artist_name":"Danny Brown",
      "artist_slug":"danny-brown",
      "artist_uri":"spotify:artist:7aA592KWirLsnfb5ulGWvU",
      "created":"2016-11-22 19:06:12",
      "genres":[
         {
            "name":"alternative hip hop",
            "slug":"alternative-hip-hop"
         },
         {
            "name":"detroit hip hop",
            "slug":"detroit-hip-hop"
         },
         {
            "name":"dirty south rap",
            "slug":"dirty-south-rap"
         },
         {
            "name":"electronic trap",
            "slug":"electronic-trap"
         },
         {
            "name":"escape room",
            "slug":"escape-room"
         },
         {
            "name":"hip hop",
            "slug":"hip-hop"
         },
         {
            "name":"indie r&b",
            "slug":"indie-randb"
         },
         {
            "name":"pop rap",
            "slug":"pop-rap"
         },
         {
            "name":"rap",
            "slug":"rap"
         },
         {
            "name":"southern hip hop",
            "slug":"southern-hip-hop"
         },
         {
            "name":"trap music",
            "slug":"trap-music"
         },
         {
            "name":"underground hip hop",
            "slug":"underground-hip-hop"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/c2217a5df05c54f1522526571136522be992ce6e",
      "reviews":[
         {
            "name":"XLR8R",
            "slug":"xlr8r",
            "url":"https:\/\/www.xlr8r.com\/reviews\/2016\/10\/danny-brown-atrocity-exhibition\/"
         }
      ]
   },
   {
      "album_id":"93",
      "album_name":"Dama",
      "album_slug":"dama",
      "album_uri":"spotify:album:0LLWMMLXtW1YwOYbNZwDZn",
      "artist_id":"91",
      "artist_name":"TitÃ¡n",
      "artist_slug":"tita-n",
      "artist_uri":"spotify:artist:4pznqIbj3YFnwvG44k1GIu",
      "created":"2016-11-22 19:06:11",
      "genres":[
         {
            "name":"deep latin alternative",
            "slug":"deep-latin-alternative"
         },
         {
            "name":"latin alternative",
            "slug":"latin-alternative"
         },
         {
            "name":"mexican indie",
            "slug":"mexican-indie"
         },
         {
            "name":"rock en espanol",
            "slug":"rock-en-espanol"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/7a4bb3b7dbf5582e32c09c1d8f70d5bf1bbe89fa",
      "reviews":[
         {
            "name":"Spotinews",
            "slug":"spotinews",
            "url":"https:\/\/spotinews.wordpress.com\/2016\/10\/31\/titan-dama\/"
         }
      ]
   },
   {
      "album_id":"89",
      "album_name":"Strands",
      "album_slug":"strands",
      "album_uri":"spotify:album:2W0Onu4JKgSYhJAzR19cZ0",
      "artist_id":"87",
      "artist_name":"Steve Hauschildt",
      "artist_slug":"steve-hauschildt",
      "artist_uri":"spotify:artist:2L00vHmYcwC9OlsEv6M5UO",
      "created":"2016-11-22 19:06:10",
      "genres":[
         {
            "name":"ambient",
            "slug":"ambient"
         },
         {
            "name":"bass music",
            "slug":"bass-music"
         },
         {
            "name":"chillwave",
            "slug":"chillwave"
         },
         {
            "name":"compositional ambient",
            "slug":"compositional-ambient"
         },
         {
            "name":"drone",
            "slug":"drone"
         },
         {
            "name":"dub techno",
            "slug":"dub-techno"
         },
         {
            "name":"float house",
            "slug":"float-house"
         },
         {
            "name":"fluxwork",
            "slug":"fluxwork"
         },
         {
            "name":"fourth world",
            "slug":"fourth-world"
         },
         {
            "name":"glitch",
            "slug":"glitch"
         },
         {
            "name":"hauntology",
            "slug":"hauntology"
         },
         {
            "name":"intelligent dance music",
            "slug":"intelligent-dance-music"
         },
         {
            "name":"mandible",
            "slug":"mandible"
         },
         {
            "name":"microhouse",
            "slug":"microhouse"
         },
         {
            "name":"minimal",
            "slug":"minimal"
         },
         {
            "name":"outsider house",
            "slug":"outsider-house"
         },
         {
            "name":"vaporwave",
            "slug":"vaporwave"
         },
         {
            "name":"warm drone",
            "slug":"warm-drone"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/6a5c6e6a0ce0127ca1d595dc051a50611afa019f",
      "reviews":[
         {
            "name":"Spotinews",
            "slug":"spotinews",
            "url":"https:\/\/spotinews.wordpress.com\/2016\/11\/03\/steve-hauschildt-strands\/"
         }
      ]
   },
   {
      "album_id":"86",
      "album_name":"Heavy Flow",
      "album_slug":"heavy-flow",
      "album_uri":"spotify:album:19w2M94vEN1e9QLeXMw2Po",
      "artist_id":"84",
      "artist_name":"Skinny Girl Diet",
      "artist_slug":"skinny-girl-diet",
      "artist_uri":"spotify:artist:4Ro2RFtETEWmXTEJxEfB2v",
      "created":"2016-11-22 19:06:09",
      "genres":[
         {
            "name":"indie punk",
            "slug":"indie-punk"
         },
         {
            "name":"riot grrrl",
            "slug":"riot-grrrl"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/d15f9fbd87425472eba087021de189ca922b7ad4",
      "reviews":[
         {
            "name":"Spotinews",
            "slug":"spotinews",
            "url":"https:\/\/spotinews.wordpress.com\/2016\/11\/05\/skinny-girl-diet-heavy-flow\/"
         }
      ]
   },
   {
      "album_id":"85",
      "album_name":"Until the Hunter",
      "album_slug":"until-the-hunter",
      "album_uri":"spotify:album:72uDE3xlSwejX3iYZqWTWU",
      "artist_id":"83",
      "artist_name":"Hope Sandoval and the Warm Inventions",
      "artist_slug":"hope-sandoval-and-the-warm-inventions",
      "artist_uri":"spotify:artist:38u18VoGaIwVeSyVoA0eU5",
      "created":"2016-11-22 19:06:08",
      "genres":[
         {
            "name":"chamber psych",
            "slug":"chamber-psych"
         },
         {
            "name":"dream pop",
            "slug":"dream-pop"
         },
         {
            "name":"freak folk",
            "slug":"freak-folk"
         },
         {
            "name":"lo-fi",
            "slug":"lo-fi"
         },
         {
            "name":"melancholia",
            "slug":"melancholia"
         },
         {
            "name":"new weird america",
            "slug":"new-weird-america"
         },
         {
            "name":"shoegaze",
            "slug":"shoegaze"
         },
         {
            "name":"slow core",
            "slug":"slow-core"
         }
      ],
      "image":"https:\/\/i.scdn.co\/image\/710f1c4084251a8e0066cc58b35b46d2e3f1ea1e",
      "reviews":[
         {
            "name":"Spotinews",
            "slug":"spotinews",
            "url":"https:\/\/spotinews.wordpress.com\/2016\/11\/06\/hope-sandoval-the-warm-inventions-until-the-hunter\/"
         }
      ]
   }
];
}