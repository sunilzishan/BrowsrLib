# ``BrowsrLib``

BrowsrLib is a Swift library that provides convenient features for fetching data from the GitHub API, including organizations and their avatar images.

## Features

- Fetch a list of organizations from the GitHub API.
- Fetch and store avatar pictures for organizations.
- Handle errors appropriately during data fetching and processing.

## Architecture

BrowsrLib follows the principles of the SOLID design principles to ensure a modular, maintainable, and extensible architecture. The main components of the library are:

1. **BrowsrClient**: The central component responsible for handling data fetching from the GitHub API. It uses URLSession to perform network requests and fetches organizations and their avatar images.

2. **Organization**: A model representing an organization retrieved from the GitHub API. It includes properties such as login, id, url, and avatarUrl for avatar image retrieval.

3. **ImageDownloader**: A component responsible for downloading and caching images from the specified URLs.

4. **CacheManager**: A cache manager to store and retrieve image data in memory for efficient image loading and presentation.

5. **BrowsrError**: An enum representing the different types of errors that can occur during data fetching and processing.


## Usage

### Fetching Organizations

To fetch a list of organizations from the GitHub API, use the `fetchOrganizations` method of the `BrowsrClient`:

```swift
let client = BrowsrClient()
client.fetchOrganizations { (organizations, error) in
if let error = error {
print("Error: \(error)")
} else if let organizations = organizations {
print("Fetched \(organizations.count) organizations.")
}
}
```

### Fetching and Storing Avatar Pictures

To fetch and store the avatar picture for a specific organization, use the `fetchAndStoreAvatarPicture` method of the `BrowsrClient`:

```swift
let organization = Organization(login: "testorg", id: 123, url: "https://api.github.com/orgs/testorg", avatarUrl: "https://example.com/avatar.png")
client.fetchAndStoreAvatarPicture(for: organization) { (data, error) in
if let error = error {
print("Error: \(error)")
} else if let imageData = data {
print("Successfully fetched and stored the avatar picture.")
// Use the image data to display the avatar picture.
}
}
```

## Error Handling

BrowsrLib uses Swift's Error Handling mechanism to propagate errors throughout the library's API. The `BrowsrError` enum defines the various error cases that can occur, such as invalid URLs, network errors, and decoding errors.
