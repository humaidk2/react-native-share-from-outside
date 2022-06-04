// file: store.ts
import {configureStore} from '@reduxjs/toolkit';
import {combineReducers} from 'redux';
import createSagaMiddleware from 'redux-saga';
// We'll use redux-logger just as an example of adding another middleware
import logger from 'redux-logger';

// And use redux-batch as an example of adding enhancers
import MMKV, {MMKVLoader} from 'react-native-mmkv-storage';
import {
  persistStore,
  persistReducer,
  FLUSH,
  REHYDRATE,
  PAUSE,
  PERSIST,
  PURGE,
  REGISTER,
} from 'redux-persist';

const storage = new MMKVLoader()
  .withInstanceID('storage')
  .setProcessingMode(MMKV.MODES.MULTI_PROCESS)
  .initialize();
const persistConfig = {
  key: 'root',
  storage,
};

import counterReducer from './slices';

import mySaga from './sagas';
// create the saga middleware
const sagaMiddleware = createSagaMiddleware();

const persistedReducer = persistReducer(
  persistConfig,
  combineReducers({
    counter: counterReducer,
  }),
);

// then run the saga

export default () => {
  const store = configureStore({
    reducer: persistedReducer,
    middleware: getDefaultMiddleware =>
      getDefaultMiddleware({
        serializableCheck: {
          ignoredActions: [FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER],
        },
      }),
    // middleware: getDefaultMiddleware =>
    //   getDefaultMiddleware().concat(logger).concat(sagaMiddleware),
    // devTools: process.env.NODE_ENV !== 'production',
  });
  console.log('store configured');

  // sagaMiddleware.run(mySaga);

  const persistor = persistStore(store);
  return {store, persistor};
};
