# UpNews

### Features:
- **Article Management** – The logic is divided between layers of the SVIP architecture, ensuring code structure and simplifying maintenance.

- **API Interaction** – A network layer has been implemented, which includes error handling, asynchronous work via URLSession with closures, support for various types of requests, and data serialization/deserialization.

- **Displaying Article List** – Custom news cells with images, titles, and descriptions have been implemented. Efficient reuse of cells and optimized layout are ensured.

- **Loading New Articles** – New articles are automatically loaded when the user scrolls to the bottom of the list, ensuring that fresh content is always available as they browse through the news.

- **Refreshing News** – The news can be refreshed by pulling down on the top-most cell, automatically reloading the latest articles from the source.
  
- **Shimmer Animation Implementation** – The animation is implemented using CAGradientLayer to create a smooth gradient movement effect, simulating the content loading process.
  
- **Image Caching** – Image caching is implemented using NSCache, enabling efficient storage and loading of images in memory, improving app performance and reducing load times.
  
- **Article Viewing** – News articles are opened through SFSafariViewController.
  
- **Sharing Feature** – A sharing option has been implemented through UIActivityViewController. Users can long-press on a cell to open the sharing menu.


### Architecture
**SVIP (VIPER)** – Clear separation of components:
  - **View** – Displays the interface and interacts with the user.
  - **Interactor** – Business logic of the application.
  - **Presenter** – Prepares data for UI & implements RoutingLogic.
  - **Router** – Manages screen transitions.
  - **Worker** – Handles data processing and network requests.


### Technologies
- UIKit | AutoLayout
- URLSession
- GCD
- SVIP (VIPER)
- SOLID
- SafariServices

# Visual
<img src="https://github.com/user-attachments/assets/848c4ccc-75a4-4eb7-9cf4-186e2bc4fd5f" width="358.33"/>
<img width="358.33" alt="image" src="https://github.com/user-attachments/assets/2d787eff-7a3c-40d4-89c2-72fb70d6f949" />
<img width="358.33" alt="image" src="https://github.com/user-attachments/assets/bccfb05b-6b9d-4e9f-9f1a-f893fa54c9a6" />
<img width="358.33" alt="image" src="https://github.com/user-attachments/assets/d907c4ed-0fd9-4916-a54d-fc684a993e28" />


