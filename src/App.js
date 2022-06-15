import React from 'react';
import './index.css';
import Home from './home'

import { jsonRpcProvider } from 'wagmi/providers/jsonRpc'
import {
  WagmiConfig,
  createClient,
  chain,
  configureChains,
} from "wagmi";

import { publicProvider } from "wagmi/providers/public";
import { MetaMaskConnector } from "wagmi/connectors/metaMask";

const App = () => {
  const { chains, provider, webSocketProvider } = configureChains(
    [chain.localhost],
    [
      jsonRpcProvider({
        rpc: (chain) => ({
          http: `http://localhost:8545`,
        }),
      }),
      publicProvider(),
    ],
  )

  const client = createClient({
    autoConnect: true,
    connectors: [
      new MetaMaskConnector({ chains }),
    ],
    provider,
    webSocketProvider,
  });

  return (

    <WagmiConfig client={client}>
      <Home />
    </WagmiConfig>

  );
}

export default App;
