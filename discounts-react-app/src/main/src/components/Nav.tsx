import React from 'react';

const Nav = () => {
  return (
    <div className='w-full p-3 bg-storedog-dark'>
      <nav className='w-10/12 mx-auto flex flex-wrap items-center'>
        <a
          className='block w-1/4 '
          href={`${import.meta.env.REACT_APP_STOREDOG_URL}`}
        >
          <img
            className='h-logo'
            src='/assets/images/logo_nobg.png'
            alt='logo'
          />
        </a>
        <div className='md:ml-auto mt-3 md:mt-0'>
          <h1 className=' text-2xl font-medium'>Storedog Discount List</h1>
        </div>
      </nav>
    </div>
  );
};

export default Nav;
