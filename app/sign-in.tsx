import React, { useState } from "react";
import {
  ActivityIndicator,
  Image,
  Pressable,
  Text,
  TextInput,
  View,
} from "react-native";
import { Redirect } from "expo-router";
import { SafeAreaView } from "react-native-safe-area-context";
import { KeyboardAwareScrollView } from "react-native-keyboard-controller";

import { login, signUp } from "@/lib/supabase";
import { useGlobalContext } from "@/lib/global-provider";
import images from "@/constants/images";

interface FormErrors {
  name?: string;
  email?: string;
  password?: string;
  server?: string;
}

const EMAIL_PATTERN = /^\S+@\S+\.\S+$/;

export default function SignIn() {
  const { isLogged, loading: authLoading } = useGlobalContext();

  const [isSignUp, setIsSignUp] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [errors, setErrors] = useState<FormErrors>({});

  if (authLoading) {
    return null;
  }

  if (isLogged) {
    return <Redirect href="/" />;
  }

  const clearFieldError = (field: keyof FormErrors) => {
    setErrors((prev) => (prev[field] ? { ...prev, [field]: undefined } : prev));
  };

  const validateForm = (): FormErrors => {
    const nextErrors: FormErrors = {};

    if (isSignUp && !name.trim()) {
      nextErrors.name = "Please enter your name.";
    }

    if (!email.trim()) {
      nextErrors.email = "Please enter your email.";
    } else if (!EMAIL_PATTERN.test(email.trim())) {
      nextErrors.email = "That doesn't look like a valid email.";
    }

    if (!password) {
      nextErrors.password = "Please enter your password.";
    } else if (password.length < 6) {
      nextErrors.password = "Password must be at least 6 characters.";
    }

    return nextErrors;
  }

  const toggleMode = () => {
    setIsSignUp((prev) => !prev);
    setErrors({});
  };

  const handleSubmit = async () => {
    const nextErrors = validateForm();

    if (Object.keys(nextErrors).length > 0) {
      setErrors(nextErrors);
      return;
    }

    setSubmitting(true);

    try {
      if (isSignUp) {
        await signUp({ name: name.trim(), email: email.trim(), password });
      } else {
        await login({ email: email.trim(), password });
      }
    } catch (err) {
      setErrors({
        server:
          err instanceof Error ? err.message : "Something went wrong. Try again.",
      });
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <SafeAreaView className="h-full bg-white">
      <KeyboardAwareScrollView
        bottomOffset={24}
        bounces={false}
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ flexGrow: 1 }}
      >
          <Image
            source={images.onboarding}
            className="w-full h-[300px]"
            resizeMode="contain"
          />

          <View className="flex-1 justify-end px-8 pb-10">
            <Text className="text-3xl font-rubik-bold text-black-300 text-center">
              {isSignUp ? "Create your account" : "Welcome back"}
            </Text>

            <Text className="text-base font-rubik text-black-200 text-center mt-2">
              {isSignUp
                ? "Join ReState and start finding your dream home."
                : "Sign in to continue looking for your dream home."}
            </Text>

            <View className="gap-3 mt-8">
              {isSignUp && (
                <View>
                  <TextInput
                    value={name}
                    onChangeText={(value) => {
                      setName(value);
                      clearFieldError("name");
                    }}
                    placeholder="Full name"
                    placeholderTextColor="#8C8E98"
                    autoCapitalize="words"
                    className="rounded-xl bg-accent-100 px-5 py-4 font-rubik text-base text-black-300"
                  />
                  {errors.name ? (
                    <Text className="mt-1 ml-1 font-rubik text-sm text-danger">
                      {errors.name}
                    </Text>
                  ) : null}
                </View>
              )}

              <View>
                <TextInput
                  value={email}
                  onChangeText={(value) => {
                    setEmail(value);
                    clearFieldError("email");
                  }}
                  placeholder="Email address"
                  placeholderTextColor="#8C8E98"
                  keyboardType="email-address"
                  autoCapitalize="none"
                  autoComplete="email"
                  className="rounded-xl bg-accent-100 px-5 py-4 font-rubik text-base text-black-300"
                />
                {errors.email ? (
                  <Text className="mt-1 ml-1 font-rubik text-sm text-danger">
                    {errors.email}
                  </Text>
                ) : null}
              </View>

              <View>
                <TextInput
                  value={password}
                  onChangeText={(value) => {
                    setPassword(value);
                    clearFieldError("password");
                  }}
                  placeholder="Password"
                  placeholderTextColor="#8C8E98"
                  secureTextEntry
                  autoComplete={isSignUp ? "new-password" : "current-password"}
                  className="rounded-xl bg-accent-100 px-5 py-4 font-rubik text-base text-black-300"
                />
                {errors.password ? (
                  <Text className="mt-1 ml-1 font-rubik text-sm text-danger">
                    {errors.password}
                  </Text>
                ) : null}
              </View>
            </View>

            {errors.server ? (
              <View className="mt-4 rounded-xl bg-danger/10 px-4 py-3">
                <Text className="font-rubik-medium text-sm text-danger">
                  {errors.server}
                </Text>
              </View>
            ) : null}

            <Pressable
              onPress={handleSubmit}
              disabled={submitting}
              className="mt-6 flex-row items-center justify-center rounded-full bg-primary-300 py-4 active:opacity-80"
            >
              {submitting ? (
                <ActivityIndicator color="#FFFFFF" />
              ) : (
                <Text className="font-rubik-bold text-lg text-white">
                  {isSignUp ? "Create account" : "Sign in"}
                </Text>
              )}
            </Pressable>

            <Pressable
              onPress={toggleMode}
              className="mt-5 items-center py-2 active:opacity-60"
            >
              <Text className="font-rubik-medium text-base text-primary-300">
                {isSignUp
                  ? "Already have an account? Sign in"
                  : "New to ReState? Create an account"}
              </Text>
            </Pressable>
          </View>
      </KeyboardAwareScrollView>
    </SafeAreaView>
  );
}
