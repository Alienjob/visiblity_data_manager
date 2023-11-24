`
  
  

# Visibility Data Manager

Management data of visible widgets.

  

## Overview

This guide highlights the capabilities of the `visibility_data_manager` library, offering insights into its efficient use for monitoring widget visibility and managing data, related to the visible widgets. It demonstrates how to utilize the library effectively when users interact with scroll widgets within their respective parent widgets.

  

## Key Features

  

-  **Visibility Monitoring:** Easily track the visibility state of widgets within scrollable containers.

-  **Track common data:** Common data can depends of visible widgets.

-  **Depend on common data:** Manageble widgets can depend of common data changes.

-  **Stock exchange order book:** Real using of 'Depend on common data' scenario (in development).

  

# Scenarios

  

The showcase covers various scenarios, including:

-  [Basic Scenario](#basic-scenario)
Widget tracks own visiblity status
  

- [Track common data](#track-common-data-scenario)
Widgets notify visiblity manager of its visiblity and manager tracks common data
  

- [Depend on common data](#depend-on-common-data-scenario)
'Widget data' connected to manageble widgets. Manager updates common data from data of visible widgets and notifies widgets with new common data
  

- [Stock exchange order book](#depend-on-common-data-scenario)
Real using of 'Depend on common data' scenario (in developmet)
  
  

## Basic Scenario

> Widget tracks own visiblity status.

The library provides State mixin that provides to widget `currentVisible` status and `changeVisible` stream.
Just wrap your ListView with `VisiblityManagerIsVisible.isVisible`:

    class IsVisiblePage StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return VisiblityManagerIsVisible.isVisible(
                child: ListView(
                    children: [
                        ItemWidget()
                    ],),);
        }
    }
Then use `IsVisible` mixin in your items:

    class ItemWidget extends StatefulWidget {
        @override
        State<ItemWidget> createState() => _ItemWidgetState();
    }
    class _ItemWidgetState extends State<ItemWidget> with IsVisible{
        @override
        Widget build(BuildContext context) {
            return Card(
                child: Text(
                currentVisible?'visible':'invisible',
                style: TextStyle(color: currentVisible?Colors.black:Colors.grey),
            ),);
        }
    }

## Track common data Scenario

> Widgets notify visiblity manager of its visiblity and manager tracks common data

Implement store for common data

    class NumOfVisibleStore extends VisiblityCommonDataStore<int> {
        int numOfVisible = 0;

        @override
        void update(int num) {
            if (numOfVisible != num) {
                numOfVisible = num;
                super.update(num);
            }
        }
    }

In manager Widget:

    class _NumOfVisibleState extends State<NumOfVisible> {

Make `onVisiblityChange` function:

    void onVisiblityChange<TCommon>(
        {VisiblityCommonDataStore<TCommon>? dataStore,
        required VisiblityStore visiblyStore}) {
        if (dataStore is NumOfVisibleStore) {
        (dataStore as NumOfVisibleStore)
            .update(visiblyStore.getVisibleKeys().length);
        }
    }

Wrap your ListView with `VisiblityManagerCommonData.commonData<TCommon>`:

    @override
    Widget build(BuildContext context) {
        return VisiblityManagerCommonData.commonData<int>(
            store: store,
            onChange: onChange,
            child: ListView(
                children: items,
            ),);
        }
    }

Wrap your Items with `VisiblityManageble`, use keys when creating them:

  void addItem() {
    final Key key = UniqueKey();
    items = List<Widget>.from([
      ...items,
      Card(
        child: VisiblityManageble(
          key: key,
          builder: () => Text(
            '$key ${store.numOfVisible}',
          ),
        ),
      )
    ]);
    setState(() {});
  }
  
## Real World Scenario

  

> Extends the functionality by introducing a `CustomScrollView` with support for multiple `SliverAppBar` widgets.

  

[Static Demo (Video)](./widget_visibility_checker/doc/3.webm)

  

[Interactive Demo (Preview Only)](https://z91e06f291f0.zapp.page)

  

[Interactive Demo (Preview and Edit)](https://zapp.run/edit/flutter-z91e06f291f0)

  

[Getting Started](./showcase/lib/second_entry.dart)

  

Building upon the visibility monitoring concept, this scenario introduces a multi-zone `SliverAppBar` layout. Leveraging the `multi_sliver_appbar_helper`, the application seamlessly transitions between zones, each characterized by its `SliverAppBar`, `SliverList`, or `SliverGrid`. The transition between zones is smooth and is triggered by the visibility states of specific widgets.

  

## License

  

This project is licensed under the MIT License. Refer to the [LICENSE](./widget_visibility_checker/LICENSE) file for more details.