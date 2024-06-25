<h1>Flutter Gutenberg App</h1>
    <p>A mobile application built using Flutter to browse and manage books from the <a href="http://gutendex.com/">Gutenberg API</a>.</p>

<h2>Tech Stack</h2>

<h3>Platform and Primary Programming Language:</h3>
<ul>
    <li>Flutter - Latest stable release</li>
    <li>Dart - Programming language</li>
</ul>

<h3>State Management and Dependency Injection:</h3>
<ul>
    <li>Bloc (from flutter_bloc) - State management for managing complex state and business logic</li>
    <li>get_it - Dependency Injection for managing dependencies</li>
</ul>

<h3>Networking and Data Storage:</h3>
<ul>
    <li>HTTP - Network requests</li>
    <li>shared_preferences - Persistent storage using shared preferences</li>
    <li>flutter_secure_storage - Secure storage for sensitive data</li>
</ul>

<h3>UI Libraries and Additional Functionality:</h3>
<ul>
    <li>font_awesome_flutter - Adds Font Awesome Icons font for iOS style icons</li>
    <li>equatable - Simplifies equality comparisons for complex classes</li>
    <li>dartz - Functional programming library for Dart</li>
    <li>internet_connection_checker - Checks for internet connectivity status</li>
    <li>oktoast - Displays toast notifications</li>
    <li>flutter_snake_navigationbar - Customizable bottom navigation bar with animations</li>
    <li>shimmer - Creates shimmering effect loading placeholders</li>
    <li>cached_network_image - Caches network images to improve performance</li>
    <li>carousel_slider - Allows implementation of image carousels</li>
    <li>smooth_page_indicator - Adds smooth page indicators for PageView</li>
    <li>flutter_easyloading - Provides a customizable loading indicator</li>
</ul>

<h2>Architecture</h2>
<p>The app follows a structured architecture:</p>
<ul>
    <li><strong>BLoC Pattern (Business Logic Component)</strong>: Manages state and business logic in a centralized manner using streams.</li>
    <li><strong>GetIt</strong>: Handles dependency injection for managing dependencies across the application.</li>
    <li><strong>Repository Pattern</strong>: Abstracts data sources, including API calls and local storage operations.</li>
</ul>

<h2>Layout on Figma</h2>
<ul>
    <li><a href="">Figma Design</a></li>
</ul>

<h2>How to Run Flutter App Locally</h2>
<p>To run the app on your local machine:</p>
<ol>
    <li>Clone the repository:</li>
    <code>git clone https://github.com/ara-apps-dev/flutter-gutenberg-app.git</code>
    <li>Navigate into the project directory:</li>
    <code>cd flutter-gutenberg-app</code>
    <li>Install dependencies:</li>
    <code>flutter pub get</code>
    <li>Connect a device or start an emulator/simulator.</li>
    <li>Run the app:</li>
    <code>flutter run</code>
</ol>

<h2>How to Run TDD (Test-Driven Development)</h2>
<p>To run tests using Test-Driven Development:</p>
<ol>
    <li>Ensure Flutter is set up and dependencies are installed.</li>
    <li>Run the tests using the command:</li>
    <code>flutter test</code>
</ol>

<h2>How to Run Automation Testing</h2>
<p>For automated testing, follow these steps:</p>
<ol>
    <li>Prepare your test scripts using Flutter's testing framework (e.g., Flutter Driver).</li>
    <li>Connect a device or start an emulator/simulator.</li>
    <li>Run the automation tests using:</li>
    <code>flutter drive --target=test_driver/app.dart</code>
</ol>

<h3>Todo List</h3>
<ul>
    <li>Create UI/UX design using Figma: In Progress 🚧</li>
    <li>Set up Flutter project structure</li>
    <li>Implement state management using BLoC and GetIt</li>
    <li>Design and implement task list screen</li>
    <li>Implement CRUD functionality for tasks</li>
    <li>Persist data using SQLite</li>
    <li>Add task completion feature</li>
    <li>Implement search functionality</li>
    <li>Write unit and widget tests</li>
    <li>Implement automation tests (integration and end-to-end tests using Maestro)</li>
    <li>Prepare documentation</li>
    <li>Implement GitHub Actions for Android deployment to Firebase</li>
    <li>Deploy to Firebase for Android</li>
</ul>
