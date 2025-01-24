### Summary: Include screen shots or a video of your app highlighting its features
    Please, find all screenshots and recording in photos_videos folder.
    
### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
    - Network layer. Robust network layer avoids issues with data fetching. Retry mechanism.
    - Good UI/UX experience. This is what the user will interact with and I paid attentiont to details for the best experience.
    - Caching mechanism. This helped to reduce network usage everytime an image is claimed to be re-downloaded.
    - Refreshing. Pull the ScrollView down to clean the cache and make another HTTP call to fetch the recipes.
    - Details. Get more information about the recipe by tap on its card. It will send you to the source URL or Youtube if the links are available.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
    - ~5 hours

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?'
    - Testing. I haven't added unit tests for all classes because the assignment took me enough time. In real world scenario, I would increase the code coverage and test thoroughly all business logic classes like view models, services, caching, extensions, helpers and utilities.
    - Disk cache. Instead of caching images to the disc a better approach would be to use a database like SwiftData or Core Data.
    - Splash screen. Launch screen would be a good addition.
    - Improve UI. Add more elements to the UI to use in all extent the ddata provided by API. For example, add buttons for source URL and youtube url, add sorting by cuisine, etc.

### Weakest Part of the Project: What do you think is the weakest part of your project?
    -Overall, the app is pretty robust. However, the testing should be improved.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
    - There is a plenty of logging. I would decrease/remove the logging at least for release version or if this wouldn't be an examplorary testing assignment.
    - I used version control and tried to keep each feature in a separate commit.
