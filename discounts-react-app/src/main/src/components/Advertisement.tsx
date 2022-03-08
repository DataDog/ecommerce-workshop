import React, { useState, useEffect } from 'react';
import { datadogRum } from '@datadog/browser-rum';

export type AdvertisementState = {
  img: string;
  url: string;
};

const Advertisement = () => {
  const [ad, setAd] = useState<AdvertisementState | null>(null);

  useEffect(() => {
    getAd();
  }, []);

  const getAd = async () => {
    try {
      const response = await fetch(
        `${import.meta.env.REACT_APP_DD_ADS_URL}/ads`
      );
      const data = await response.json();
      const { url, path } = data[Math.floor(Math.random() * data.length)];
      const bannerAdRes = await fetch(
        `${import.meta.env.REACT_APP_DD_ADS_URL}/banners/${path}`
      );
      if (!bannerAdRes.ok) {
        throw new Error('Error fetching banner ad');
      }
      const bannerAd = await bannerAdRes.blob();
      setAd({ img: URL.createObjectURL(bannerAd), url });
    } catch (err) {
      console.error(err);
    }
  };

  const handleUserGetAd = async () => {
    const response = await fetch(`${import.meta.env.REACT_APP_DD_ADS_URL}/ads`);
    const data = await response.json();
    const { url, path, name, id } =
      data[Math.floor(Math.random() * data.length)];
    const bannerAdRes = await fetch(
      `${import.meta.env.REACT_APP_DD_ADS_URL}/banners/${path}`
    );
    if (!bannerAdRes.ok) {
      throw new Error('Issue fetching banner ad');
    }
    const bannerAd = await bannerAdRes.blob();
    setAd({ img: URL.createObjectURL(bannerAd), url });

    datadogRum.addAction('Changed Ad', {
      advertisement: {
        id,
        name,
        url,
        path,
      },
    });
  };

  return (
    <div className='my-3 mx-auto' style={{ minHeight: 96 }}>
      <div className='flex flex-col'>
        <button className='text-underline' onClick={handleUserGetAd}>
          Get New Ad
        </button>
        {ad && (
          <a href={`${import.meta.env.REACT_APP_STOREDOG_URL}${ad.url}`}>
            <img src={ad.img} alt='' />
          </a>
        )}
      </div>
    </div>
  );
};

export default Advertisement;
