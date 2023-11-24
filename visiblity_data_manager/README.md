

# Visibility Data Manager
Management data of visible widgets.

## Overview
This guide highlights the capabilities of the `visibility_data_manager` library, offering insights into its efficient use for monitoring widget visibility and managin data, related to the visible widgets. It demonstrates how to utilize the library effectively when users interact with scroll widgets within their respective parent widgets.

## Key Features

-  **Visibility Monitoring:** Easily track the visibility state of widgets within scrollable containers.
-  **Track common data:** Common data can depends of visible widgets.
-  **Depend on common data:** Manageble widgets can depend of common data changes.
-  **Stock exchange order book:** Real using of 'Depend on common data' scenario (in developmet).

# Scenarios

The showcase covers various scenarios, including:
- Basic Scenario
[Widget tracks own visiblity status](#basic-scenario)

- Track common data
[Widgets notify visiblity manager of its visiblity and manager tracks common data](#track-common-data-scenario)

- Depend on common data
['Widget data' connected to manageble widgets. Manager updates common data from data of visible widgets and notifies widgets with new common data](#depend-on-common-data-scenario)

- Stock exchange order book
[Real using of 'Depend on common data' scenario (in developmet)](#depend-on-common-data-scenario)


## Basic Scenario
> Widget tracks own visiblity status.

[Static Demo (Video)](./widget_visibility_checker/doc/1.webm)

[Interactive Demo (Preview Only)](https://zxiy061gxiz0.zapp.page)

[Interactive Demo (Preview and Edit)](https://zapp.run/edit/flutter-zxiy061gxiz0)

[Getting Started](./showcase/lib/first_entry.dart)

The library provides State mixin granular insights into widget positioning relative to their parent scroll views, categorizing them based on their location in the scrollable space. For both main-axis and cross-axis, widgets may be labeled as:


This detailed visibility information empowers developers to make informed decisions about UI elements, ensuring a responsive and user-friendly experience across various scrolling scenarios.

## Advanced Scenario
> Detect and log metric changes for target widgets during scrolling.

[Static Demo (Video)](./widget_visibility_checker/doc/2.webm)

[Interactive Demo (Preview Only)](https://zxiy061gxiz0.zapp.page)

[Interactive Demo (Preview and Edit)](https://zapp.run/edit/flutter-zxiy061gxiz0)

[Getting Started](./showcase/lib/first_entry.dart)

As users scroll through the interface, the system track and record various metrics associated with specific widgets. This includes detailed information such as the distances to the viewport edges. The logged metrics provide valuable insights into the dynamic behavior of widgets within different scrollable contexts. This feature is particularly useful for scenarios where precise monitoring of widget metrics is essential for responsive and data-driven user interfaces.

## Real World Scenario

> Extends the functionality by introducing a `CustomScrollView` with support for multiple `SliverAppBar` widgets.

[Static Demo (Video)](./widget_visibility_checker/doc/3.webm)

[Interactive Demo (Preview Only)](https://z91e06f291f0.zapp.page)

[Interactive Demo (Preview and Edit)](https://zapp.run/edit/flutter-z91e06f291f0)

[Getting Started](./showcase/lib/second_entry.dart)

Building upon the visibility monitoring concept, this scenario introduces a multi-zone `SliverAppBar` layout. Leveraging the `multi_sliver_appbar_helper`, the application seamlessly transitions between zones, each characterized by its `SliverAppBar`, `SliverList`, or `SliverGrid`.  The transition between zones is smooth and is triggered by the visibility states of specific widgets.

## License

This project is licensed under the MIT License. Refer to the [LICENSE](./widget_visibility_checker/LICENSE) file for more details.