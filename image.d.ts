/// <reference types="react" />

declare module "*.png" {
  import type { ImageSourcePropType } from "react-native";

  const source: ImageSourcePropType;
  export default source;
}

// Side-effect CSS imports are how NativeWind v4 loads Tailwind styles.
declare module "*.css";

