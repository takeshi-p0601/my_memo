This PR fixes an issue where strokes are not displayed.

As in the attached json file, when "k=0" the stroke is not visible.
This issue does not occur on lottie-android and I spent a lot of time trying to determine the cause of the issue, 
so please confirm. 

Also Please let us know if you have any other suggestions.

json file 

```
                            "bm": 0,
                            "d": [
                                {
                                    "n": "d",
                                    "nm": "dash",
                                    "v": {
                                        "a": 0,
                                        "k": 0, // here
                                        "ix": 1
                                    }
                                },
                                {
                                    "n": "o",
                                    "nm": "offset",
                                    "v": {
                                        "a": 0,
                                        "k": 0,
                                        "ix": 7
                                    }
                                }
                            ],
                            "nm": "Stroke 1",
                            "mn": "ADBE Vector Graphic - Stroke",
                            "hd": false
                        },
```

|before|after|
|---|---|
|<img src="https://user-images.githubusercontent.com/16571394/182263895-4a75614a-d8ca-49b9-9feb-907fc1f185f2.png" width="240">|<img src="https://user-images.githubusercontent.com/16571394/182263712-cbbaeefa-36b5-413a-807e-9fccdeb55f79.gif" width="240">|
