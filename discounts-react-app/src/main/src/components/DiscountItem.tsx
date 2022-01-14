import React from 'react';
import type { DiscountType } from './DiscountList';

const DiscountItem = ({
  id,
  name,
  code,
  value,
  saved,
  handleSave,
}: DiscountType) => {
  return (
    <tr>
      <td className='px-3 py-2 whitespace-nowrap'>
        <div className='flex items-center'>
          <div className='ml-4'>
            <div className='text-normal font-medium text-gray-900'>{name}</div>
          </div>
        </div>
      </td>
      <td className='px-3 py-2 whitespace-nowrap'>
        <span className='px-4 py-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800'>
          {code}
        </span>
      </td>
      <td className='px-3 py-2 whitespace-nowrap text-normal text-gray-500'>
        ${value}
      </td>
      <td className='px-3 py-2 whitespace-nowrap text-right text-sm font-medium'>
        <button
          className={`text-sm font-semibold bg-storedog text-white py-2 px-3 my-1 rounded-lg hover:bg-storedog-dark focus:outline-none focus-visible:ring-2 focus-visible:ring-gray-700 focus-visible:ring-offset-2 focus-visible:ring-offset-gray-900`}
          onClick={() => handleSave(id)}
        >
          {saved ? 'Remove' : 'Save'}
        </button>
      </td>
    </tr>
  );
};

export default DiscountItem;
