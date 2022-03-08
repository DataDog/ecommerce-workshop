import React from 'react';
import Nav from './components/Nav';
import Advertisement from './components/Advertisement';
import DiscountList from './components/DiscountList';

const App = () => {
  return (
    <div>
      <header className='w-full flex flex-col items-center bg-storedog text-white'>
        <Advertisement />
        <Nav />
      </header>
      <main>
        <p className='w-full mx-auto mb-4 p-6 border-b-2 border-storedog-dark bg-coolGray-200 text-storedog text-center text-lg font-bold'>
          Browse the list of discounts currently offered at Storedog and save
          them for later!
        </p>
        <DiscountList />
      </main>
      <footer className='w-full flex flex-col items-center'>
        <Advertisement />
      </footer>
    </div>
  );
};

export default App;
