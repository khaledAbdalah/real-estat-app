import React, { useCallback } from "react";
import { View } from "react-native";
import { Redirect, Stack } from "expo-router";
import { StatusBar } from "expo-status-bar";
import * as SplashScreen from "expo-splash-screen";
import { useFonts } from "expo-font";

import GlobalProvider, { useGlobalContext } from "@/lib/global-provider";
import "./global.css";

SplashScreen.preventAutoHideAsync();

export default function RootLayout() {
  return (
    <GlobalProvider>
      <AppNavigator />
    </GlobalProvider>
  );
}

function AppNavigator() {
  const [fontsLoaded, fontError] = useFonts({
    "Rubik-Light": require("../assets/fonts/Rubik-Light.ttf"),
    "Rubik-Regular": require("../assets/fonts/Rubik-Regular.ttf"),
    "Rubik-Medium": require("../assets/fonts/Rubik-Medium.ttf"),
    "Rubik-SemiBold": require("../assets/fonts/Rubik-SemiBold.ttf"),
    "Rubik-Bold": require("../assets/fonts/Rubik-Bold.ttf"),
    "Rubik-ExtraBold": require("../assets/fonts/Rubik-ExtraBold.ttf"),
  });

  const { isLogged, loading: authLoading } = useGlobalContext();

  const onLayoutRootView = useCallback(async () => {
    if (fontsLoaded || fontError) {
      await SplashScreen.hideAsync();
    }
  }, [fontsLoaded, fontError]);

  if (!fontsLoaded && !fontError) {
    return null;
  }

  if (authLoading) {
    return null;
  }

  return (
    <View style={{ flex: 1 }} onLayout={onLayoutRootView}>
      <StatusBar hidden />
      <Stack screenOptions={{ headerShown: false }} />

      {!isLogged && <Redirect href="/sign-in" />}
    </View>
  );
}
