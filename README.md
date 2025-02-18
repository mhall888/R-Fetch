# R•Fetch / AKA R-Fetch, R_Fetch or "Recipe Fetch"

## Submitted by Mark Hall, markhall@obsidian-logic.com

### Summary:
Screenshots for iPhone 16 Pro Max, iPad Pro 13-inch, Apple Vision Pro and macOS
## Empty States
![Empty state on iPhone 16 Pro Max.png](<./Resources/Empty State/iPhone 16 Pro Max.png>)
![Empty state on iPad Pro 13-inch.png](<./Resources/Empty State/iPad Pro 13-inch.png>)
![Empty state on Apple Vision Pro.png](<./Resources/Empty State/Apple Vision Pro.png>)
![Empty state on macOS.png](<./Resources/Empty State/macOS.png>)
## Populated with Recipes
![With recipes on iPhone 16 Pro Max.png](<./Resources/Populated/iPhone 16 Pro Max.png>)
![With recipes on iPad Pro 13-inch.png](<./Resources/Populated/iPad Pro 13-inch.png>)
![With recipes on Apple Vision Pro.png](<./Resources/Populated/Apple Vision Pro.png>)
![With recipes on macOS.png](<./Resources/Populated/macOS.png>)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I chose to focus on creating a compelling experience that maximizes the breadth of features by using available data. Quickly opening a browser for the user to see the source or video is an essential part of the curation process... what am I going to cook next? Filter/sort would be the obvious next feature. I was also striving to support as many devices as possible within Apple's ecosystem, so the application is customized to work around defects by presenting device specific UI elements.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent a portion of a day building this application across two calendar days. It helped that there were many building blocks that I'd already assembled recently while polishing my networking, concurrency and SwiftUI skills. I first allotted time to fully understand the requirements and draft an implementation plan based on the most impactful features. Then I built out the models, networking, image cache, view models and basic views. With the base requirements met, I decided to focus on the UX and expand the feature set. A final chunk of time was allocated for bug fixing, taking screenshots and finalizing the ReadMe. With the packaging included, I've spent the better part of a day.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- The riskiest decision I made was a trade of on the requirements. They stated that image data should be cached... specifically, to disk! My recent experience with thumbnail caching at GoPro emphasized that lots of questions should be asked prior to implementation, since typical cascading issues arise as soon as you start writing to the filesystem. Folder location specific to the platform, policy on stale data and how it is detected, managing multiple users on the same device (PII), whale account users with more than 30K items... just a few topics that might need exploring. So, I chose to make an in-memory cache. It allowed for 'Efficient Network Usage' within each run of the application, since the image data footprint is _currently_ so small. 
- No handling for memory pressure from the cache (no subscription to UIApplication.didReceiveMemoryWarningNotification, etc.). Purging would not be expected with such a small footprint, yet production code would demand it.
- Not enough time for comments/documentation and constants instead of magic #s
- Not having state management for the image cache makes it challenging to track the phases of loading like an `AsyncImage` does. This also impacts the typical 'stepped into an elevator' mobile use case. There is a `TODO` comment that suggests states be added for error handling and reachability improvements.
- The placeholder flashes at launch and... you guessed it... more state management would smooth that out, too.

### Weakest Part of the Project: What do you think is the weakest part of your project?
There are warnings related to Swift 6 support. The project is currently compiling in Swift 5 language mode, yet I fixed _most_ warnings/issues by turning 6 on. Dealing with ImageRenderer was interesting and it seems dangerous to just silence the warnings. The currently visible warnings are related to rendering the broken image icon made at runtime, so I could eliminate the offending code altogether by just making a custom image in the asset catalog.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- Support for both UIKit and AppKit is accomplished by using `Data` as the common abstraction. The framework extensions handle all the translations specific to the kit being used.
- Failure from a bad URL (404) will result in a 'broken image' icon, yet all other errors will result in a retry.
- Encountered defects in UIKit when multiple `Link` views exist on the same `List` row. Tried a few different ways and they all failed the same way. So, implemented one at a time with a picker when running on UIKit.
- Wanted to keep the placeholder generic, so injected the refresh button. That allowed the preview to provide a button with a no-op action and RecipesListView builds one that uses recipesViewModel to fetch new data.
- Refresh is present in several forms: always there on macOS / in UIKit lists by 'pull down' and in empty state view.


---

Copyright © 2025 Mark Hall. All Rights Reserved.
