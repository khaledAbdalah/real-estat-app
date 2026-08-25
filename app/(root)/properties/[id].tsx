import { View, Text } from "react-native";
import { useLocalSearchParams } from "expo-router";
import React from "react";

export default function PropertyDetails() {
  const { id } = useLocalSearchParams<{ id: string }>();

  return (
    <View className="flex-1 items-center justify-center bg-white">
      <Text className="font-rubik-bold text-lg text-black-300">
        Property details
      </Text>
      <Text className="mt-1 font-rubik text-sm text-black-100">{id}</Text>
    </View>
  );
}
