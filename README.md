# SwiftNews-ReactiveSwift

### Objective

- [x] ReactiveSwift
- [x] Moya
- [x] Realm
- [x] Starscream
- [ ] Anchorage

### Project Progress

- [v1.3 - Starscream Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.3)
  - Implement **`chat`** functionality using Starscream for WebSocket communication.
- [v1.2 - Realm Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.2)
  - Implement encrypted Realm integration in **`Reminder`** list view.
- [v1.1 - Moya Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.1)
  - Implemented Moya framework to establish connection with **`SampleAPI`**, allowing retrieval of `now` and `randomInteger`.
- [v1.0 - ReactiveSwift Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.0)
  - Incorporated ReactiveSwift for asynchronously fetching top headline news articles.
  
### WebSocket Server

This script sets up a simple WebSocket server using the 'ws' library.
It listens for incoming connections, logs messages received from clients, and
sends a response back to the clients. The server also logs when a client disconnects.

```js
const WebSocket = require('ws');

// Create a WebSocket server listening on port 8080
const server = new WebSocket.Server({ port: 8080 });

// On a new connection, log that a client has connected
server.on('connection', (socket) => {
	console.log('Client connected');

	// On receiving a message from the client, log the message and send a response back
	socket.on('message', (message) => {
		console.log(`Received message: ${message}`);
		socket.send(`You sent: ${message}`);
	});

	// On closing the connection, log that the client has disconnected
	socket.on('close', () => {
		console.log('Client disconnected');
	});
});
```
  
## Screeshots

### [v1.3 - Starscream Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.3)

<img width="331" src="https://user-images.githubusercontent.com/42887325/226850336-6f190c71-89ca-4125-97a8-94aa76a0dec5.gif">

### [v1.2 - Realm Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.2)

<img width="331" src="https://user-images.githubusercontent.com/42887325/226818079-8890501f-5a4f-4d7f-84d0-8d273d87ebce.gif">
  
### [v1.1 - Moya Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.1)

<img width="331" src="https://user-images.githubusercontent.com/42887325/226618100-9ea566a3-4e50-49c4-8eea-97cecac78277.gif">

### [v1.0 - ReactiveSwift Integration](https://github.com/chatsopond/QuickNews-ReactiveSwift/tree/v1.0)

<img width="331" alt="Screenshot 2023-03-21 at 20 16 21" src="https://user-images.githubusercontent.com/42887325/226617393-cc410976-9ebe-4563-83ba-03747295aa26.png">

