/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, {useEffect} from 'react';
import type {Node} from 'react';
import {
  NativeModules,
  SafeAreaView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  NativeEventEmitter,
} from 'react-native';

const Share: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  useEffect(() => {
    const {ShareOutsideModule} = NativeModules;
    const eventEmitter = new NativeEventEmitter(ShareOutsideModule);
    const eventListener = eventEmitter.addListener('ShareEvent', event => {
      console.log('got share event');
      console.log(event);
      console.log(event.eventProperty); // "someValue"
    });
    // setTimeout(() => {
    //   ShareOutsideModule.startApp();
    // }, 3000);
    console.log(ShareOutsideModule);
    return () => eventListener.remove();
  }, []);
  return (
    <SafeAreaView>
      <StatusBar barStyle={'dark-content'} />
      <Text style={[styles.header]}>Hello World</Text>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  header: {
    fontFamily: 'Helvetica',
    fontSize: 50,
    color: 'black',
    fontWeight: '600',
  },
});

export default Share;
