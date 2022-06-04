/**
 * @format
 */

import React from 'react';
import {AppRegistry} from 'react-native';
import {Provider} from 'react-redux';
import {PersistGate} from 'redux-persist/integration/react';

import App from './App';
import Share from './Share';
import {name as appName} from './app.json';
import createStore from './src/store';

const {store, persistor} = createStore();

const persistedComponent = Component => () =>
  (
    <Provider store={store}>
      <PersistGate loading={null} persistor={persistor}>
        <Component />
      </PersistGate>
    </Provider>
  );
const loadedApp = persistedComponent(App);

AppRegistry.registerComponent(appName, () => loadedApp);

AppRegistry.registerComponent('ShareActivity', () => Share);
