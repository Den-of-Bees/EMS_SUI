
import '@mysten/dapp-kit/dist/index.css';
import './App.css'
import { ConnectButton } from '@mysten/dapp-kit';
import NavBar from './components/NavBar';

function App() {
  

  return (
    
      <div className='flex flex-col justify-start  h-screen'>
        <NavBar/>
       
      <div className='flex flex-col items-center'><p>Hello World</p> <ConnectButton/></div>
      </div>
      
    
  )
}

export default App
