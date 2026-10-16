declare module "react-usa-map" {
  import { FC, MouseEvent } from "react";

  export interface StateCustomConfig {
    fill?: string;
    clickHandler?: (event: MouseEvent<SVGPathElement>) => void;
  }

  export interface USAMapProps {
    title?: string;
    width?: number;
    height?: number;
    defaultFill?: string;
    customize?: Record<string, StateCustomConfig>;
    onClick?: (event: MouseEvent<SVGPathElement>) => void;
  }

  const USAMap: FC<USAMapProps>;
  export default USAMap;
}
