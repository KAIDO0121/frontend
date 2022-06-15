import React, { useState, useEffect } from "react";
import { ethers } from 'ethers'

export const BlockchainContext = React.createContext({
    currentAccount: null,
    provider: null
});


const BlockchainContextProvider = ({ children }) => {
    const [currentAccount, setCurrentAccount] = useState(null)
    const [provider, setProvider] = useState(null)



    useEffect(() => {
        const updateCurrentAccounts = accounts => {
            console.log(accounts)
            const [_account] = accounts;
            setCurrentAccount(_account);
        }

        window.ethereum.request({ method: 'eth_requestAccounts' }).then(updateCurrentAccounts);

        window.ethereum.on("accountsChanged", updateCurrentAccounts);


        const getChainId = async res => {

            if (res.chainId && res.chainId !== '0x4') {

                window.ethereum.request({ method: 'wallet_switchEthereumChain', params: [{ chainId: '0x4' }] })
                    .then(res => alert("Switch chain to localhost has been requested"))
                    .catch(err => console.error(err))
            } else {

            }
        }

        window.ethereum.on("connect", getChainId)


        window.ethereum.on('chainChanged', (chainId) => {

            if (chainId && chainId !== "0x4") {

                window.ethereum.request({ method: 'wallet_switchEthereumChain', params: [{ chainId: '0x4' }] })
                    .then(res => alert("Switch chain to localhost has been requested"))
                    .catch(err => console.error(err))
            } else {
                const _provider = new ethers.providers.Web3Provider(window.ethereum);
                setProvider(_provider)
            }
        });

    }, []);

    useEffect(() => {

        const _provider = new ethers.providers.Web3Provider(window.ethereum);

        setProvider(_provider)

    }, []);

    return (
        <BlockchainContext.Provider value={{ currentAccount, provider }}>
            {children}
        </BlockchainContext.Provider>
    );
};

export default BlockchainContextProvider;