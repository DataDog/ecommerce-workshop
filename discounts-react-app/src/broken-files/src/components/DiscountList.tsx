import React, { useState, useEffect } from 'react';
import DiscountItem from './DiscountItem';

export type DiscountType = {
  id: number;
  code: string;
  name: string;
  value: number;
  saved: boolean;
  handleSave: (id: number) => void;
};

type DiscountKey = keyof DiscountType;

const DiscountList = () => {
  const [discounts, setDiscounts] = useState<DiscountType[]>([]);
  const [showSaved, setShowSaved] = useState<boolean>(false);
  const [sortBy, setSortBy] = useState<DiscountKey | null>(null);
  const [sortDirection, setSortDirection] = useState<'asc' | 'desc' | null>(
    null
  );

  useEffect(() => {
    getDiscounts();
  }, []);

  const getDiscounts = async (): Promise<void> => {
    try {
      const response = await fetch(
        `${import.meta.env.REACT_APP_DD_DISCOUNTS_URL}`
      );
      const data = await response.json();

      const savedDiscounts = localStorage.getItem('savedDiscounts');

      const savedDiscountsArray = savedDiscounts
        ? JSON.parse(savedDiscounts)
        : [];

      const discounts = data.map((discount: DiscountType) => {
        const isSaved = savedDiscountsArray.includes(discount.id);
        return {
          ...discount,
          saved: isSaved,
        };
      });

      setDiscounts(discounts);
    } catch (error) {
      console.error(error);
    }
  };

  const sortDiscounts = (columnName: DiscountKey): void => {
    const sortedDiscounts: DiscountType[] = discounts.sort((a: any, b: any) => {
      if (columnName !== sortBy) {
        return a[columnName] > b[columnName] ? 1 : -1;
      }

      if (sortDirection === 'asc') {
        return a[columnName] < b[columnName] ? 1 : -1;
      } else if (sortDirection === 'desc') {
        return a[columnName] > b[columnName] ? 1 : -1;
      } else {
        return 0;
      }
    });
    setDiscounts(sortedDiscounts);
    setSortBy(columnName);
    if (columnName !== sortBy) {
      setSortDirection('asc');
    } else {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    }
  };

  const toggleDiscountSave = (id: number): void => {
    const savedDiscounts = localStorage.getItem('savedDiscounts');
    const savedDiscountsArray = savedDiscounts
      ? JSON.parse(savedDiscounts)
      : [];

    const isSaved = savedDiscountsArray.includes(id);

    if (isSaved) {
      const index = savedDiscountsArray.indexOf(id);
      savedDiscountsArray.splice(index, 1);
    } else {
      savedDiscountsArray.push(id);
    }

    localStorage.setItem('savedDiscounts', JSON.stringify(savedDiscountsArray));

    const updatedDiscounts = discounts.map((discount: DiscountType) => {
      if (discount.id === id) {
        return {
          ...discount,
          saved: !discount.saved,
        };
      }
      return discount;
    });

    setDiscounts(updatedDiscounts);
  };

  return (
    <div className='w-10/12 mx-auto my-5 flex flex-col'>
      <div className='-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8'>
        <div className='py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8'>
          <button
            className='text-sm font-semibold bg-storedog text-white py-3 px-4 my-3 rounded-lg hover:bg-storedog-dark focus:outline-none focus-visible:ring-2 focus-visible:ring-gray-700 focus-visible:ring-offset-2 focus-visible:ring-offset-gray-900'
            onClick={() => setShowSaved(!showSaved)}
          >
            Show {showSaved ? 'All' : 'Saved'} Discounts
          </button>
          <div className='shadow-md overflow-hidden border-2 border-storedog sm:rounded-lg'>
            <table className='min-w-full divide-y-2 divide-storedog'>
              <thead className='bg-storedog'>
                <tr>
                  <th
                    scope='col'
                    className={`px-3 py-3 text-left text-m font-medium text-white uppercase tracking-wider cursor-pointer ${
                      sortBy === 'name' ? 'bg-storedog-dark' : ''
                    }`}
                    onClick={() => sortDiscounts('name')}
                  >
                    Discount Name
                    <span
                      role='img'
                      aria-label='sort-direction'
                      className='text-sm p-2'
                    >
                      {sortBy === 'name' &&
                        (sortDirection === 'asc' ? '▼' : '▲')}
                    </span>
                  </th>
                  <th
                    scope='col'
                    className={`px-3 py-3 text-left text-m font-medium text-white uppercase tracking-wider cursor-pointer ${
                      sortBy === 'code' ? 'bg-storedog-dark' : ''
                    }`}
                    onClick={() => sortDiscounts('code')}
                  >
                    Code
                    <span
                      role='img'
                      aria-label='sort-direction'
                      className='text-sm p-2'
                    >
                      {sortBy === 'code' &&
                        (sortDirection === 'asc' ? '▼' : '▲')}
                    </span>
                  </th>
                  <th
                    scope='col'
                    className={`px-3 py-3 text-left text-m font-medium text-white uppercase tracking-wider cursor-pointer ${
                      sortBy === 'value' ? 'bg-storedog-dark' : ''
                    }`}
                    onClick={() => sortDiscounts('value')}
                  >
                    Discount Value ($)
                    <span
                      role='img'
                      aria-label='sort-direction'
                      className='text-sm p-2'
                    >
                      {sortBy === 'value' &&
                        (sortDirection === 'asc' ? '▼' : '▲')}
                    </span>
                  </th>
                  <th
                    scope='col'
                    className='py-3 text-left text-m font-medium text-white uppercase tracking-wider bg-storedog'
                  >
                    <span className='sr-only'>Save</span>
                  </th>
                </tr>
              </thead>

              <tbody className='bg-white divide-y divide-gray-200'>
                {discounts.length ? (
                  discounts
                    .filter((discount) => (showSaved ? discount.saved : true))
                    .map((discount) => (
                      <DiscountItem
                        key={discount.id}
                        id={discount.id}
                        code={discount.code}
                        name={discount.name}
                        value={discount.value}
                        saved={discount.saved}
                        handleSave={toggleDiscountSave}
                      />
                    ))
                ) : (
                  <tr>
                    <td className='px-6 py-4 whitespace-nowrap'>
                      Loading discounts...
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default DiscountList;
