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

https://github.com/Alienjob/visiblity_data_manager/tree/main/is_visible

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

https://github.com/Alienjob/visiblity_data_manager/tree/main/num_of_visible

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

In manager Widget init store:

    class _NumOfVisibleState extends State<NumOfVisible> {
        final store = NumOfVisibleStore();

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
            onChange: onVisiblityChange,
            child: ListView(
                children: items,
            ),);
        }
    }

Wrap your Item with `VisiblityManageble`, use keys when creating items:

    void addItem() {
        final Key key = UniqueKey();
        items = List<Widget>.from([
          ...items,
          Card(
            child: VisiblityManageble(
            key: key,
            builder: () => Text(
                '$key ${store.numOfVisible}',
        ),),)]);
        setState(() {});
    }

## Depend on calculable data Scenario

https://github.com/Alienjob/visiblity_data_manager/tree/main/calculable_data

> 'value data' connected to manageble widgets. Manager updates 'calculable data' from 'value data' of visible widgets and notifies widgets with new 'calculable data'

Implement store for calculable data

    class MaxVisibleValueStore extends VisiblityCalculableDataStore<double, double> {
        double maxValue = 0;

        @override
        double? calculate(List<Key> keys) {
            maxValue = 0;
            for (var key in keys){
                maxValue = max(maxValue, registred[key]??0);
            }
            super.calculate(keys);
            return maxValue;
        }

        @override
        void update(double data) {
            if (maxValue != data) {
                maxValue = data;
                super.update(data);
            }
        }
    }

In manager Widget init store:

    class _NumOfVisibleState extends State<NumOfVisible> {
        final store = MaxVisibleValueStore();

Make `onVisiblityChange` function:

    void onVisiblityChange<TValue, TCommon>({
        VisiblityCalculableDataStore<TValue, TCommon>? dataStore,
        required VisiblityStore visiblyStore
        }) {
            if (dataStore is MaxVisibleValueStore) {
                final double? maxValue = (dataStore as MaxVisibleValueStore).calculate(visiblyStore.getVisibleKeys());
            store.update(maxValue??0);
            Future.delayed(Duration.zero, () async{ setState(() {});}); 
        }
    }

Wrap your ListView with `VisiblityManagerCalculableData.calculable<TValue, TCommon>`:

    @override
    Widget build(BuildContext context) {
        return VisiblityManagerCalculableData.calculable<double, double>(
          store: store,
          onChange: onVisiblityChange,
          child: ListView(
            children: items,
          ),);
        }
    }

Wrap your Items with `VisiblityManageble`, set `initValue` use keys when creating them:

    void addItem() {
        double value = Random().nextDouble();
        items = List<Widget>.from([
            ...items,
            VisiblityManageble(
                key: ValueKey(value),
                initValue: value,
                builder: () => Text('value: $value maxValue: ${store.maxValue}')
            )
        ]);
        setState(() {});
    }

## Stock exchange order book

Prparing to publish

## License

This project is licensed under the MIT License. Refer to the [LICENSE](./widget_visibility_checker/LICENSE) file for more details.