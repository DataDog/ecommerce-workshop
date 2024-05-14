const puppeteer = require('puppeteer');

const startUrl = process.env.STOREDOG_URL;

if (!startUrl) {
  console.log('No start URL provided');
  process.exit(1);
}

const getNewBrowser = async () => {
  const browser = await puppeteer.launch({
    defaultViewport: null,
    timeout: 30000,
    slowMo: 1000,
    args: [
      // Required for Docker version of Puppeteer
      '--no-sandbox',
      '--disable-setuid-sandbox',
      // This will write shared memory files into /tmp instead of /dev/shm,
      // because Docker’s default for /dev/shm is 64MB
      '--disable-dev-shm-usage',
    ],
  });
  const browserVersion = await browser.version();
  console.log(`Started ${browserVersion}`);
  return browser;
};

const choosePhone = () => {
  const deviceNames = [
    'Pixel 2 XL',
    'Pixel 2',
    'Nokia N9',
    'Nokia Lumia 520',
    'Nexus 7',
    'Nexus 6P',
    'LG Optimus L70',
    'Galaxy S5',
    'iPhone 11 Pro Max',
    'iPhone 11',
    'iPhone XR',
    'iPhone X',
    'iPhone SE',
    'iPhone 8 Plus',
    'iPhone 6',
    'iPad Pro',
    'iPad Mini',
  ];

  const deviceIndex = Math.floor(Math.random() * deviceNames.length);
  const device = deviceNames[deviceIndex];
  return puppeteer.devices[device];
};

const randomlyCloseSession = async (browser, page, skipSessionClose) => {
  console.log('In randomlyCloseSession');

  if (skipSessionClose) {
    console.log('Skipping session close');
    return false;
  }

  const random = Math.floor(Math.random() * 7) + 1;
  if (random === 1) {
    console.log('Closing browser...');
    await page.close();
    await browser.close();
    return true;
  } else {
    return false;
  }
};

const goToBags = async (page) => {
  console.log('In goToBags on page', await page.title());
  let selector =
    'div > #taxonomies > .mt-4 > .list-group > .list-group-item:nth-child(1)';
  await Promise.all([page.waitForNavigation(), page.click(selector)]);
  console.log('navigated pages');
  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const goToProduct = async (page) => {
  console.log('In goToProduct on page', await page.title());
  let selector = '#product_1 a';
  await Promise.all([page.waitForNavigation(), page.click(selector)]);
  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const addToCart = async (page) => {
  console.log('In addToCart on page', await page.title());
  let selector = '#add-to-cart-button';
  await Promise.all([page.waitForNavigation(), page.click(selector)]);
  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const goToCheckout = async (page) => {
  console.log('In goToCheckout on page', await page.title());
  let selector = '#checkout-link';
  await Promise.all([page.waitForNavigation(), page.click(selector)]);
  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const checkoutGuest = async (page) => {
  // enter email address for guest checkout
  let selector = '#guest_checkout input#order_email';
  await page.type(selector, 'john@storedog.com');
  await page.waitForTimeout(250);
  // go to checkout page
  selector = '#guest_checkout input[type="submit"]';
  await Promise.all([page.waitForNavigation(), page.click(selector)]);

  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const fillAddress = async (page) => {
  console.log('In fillAddress on page', await page.title());
  // enter shipping address
  let selector = '#order_bill_address_attributes_firstname';
  await page.waitForSelector(selector);
  await page.type(selector, 'John');
  console.log('entered first name');
  // ---
  selector = '#order_bill_address_attributes_lastname';
  await page.type(selector, 'Doe');
  console.log('entered last name');
  // ---
  selector = '#order_bill_address_attributes_address1';
  await page.type(selector, '123 Main St');
  console.log('entered address');
  // ---
  selector = '#order_bill_address_attributes_city';
  await page.type(selector, 'Anytown');
  console.log('entered city');
  // ---
  selector = '#order_bill_address_attributes_state_id';
  await page.select(selector, '3340');
  console.log('entered state');
  // ---
  selector = '#order_bill_address_attributes_zipcode';
  await page.type(selector, '12345');
  console.log('entered zipcode');
  // ---
  // selector = '#order_bill_address_attributes_country_id';
  // await page.select(selector, '233');
  // console.log('entered country');
  // ---
  selector = '#order_bill_address_attributes_phone';
  await page.type(selector, '1234567890');
  console.log('entered phone');
  // ---
  selector = '.form-buttons > .card-body > input[type="submit"]';

  await Promise.all([page.waitForNavigation(), page.click(selector)]);

  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const setShippingMethod = async (page) => {
  console.log('In setShippingMethod on page', await page.title());
  let selector = '#checkout_form_delivery input[type="submit"]';
  await page.waitForSelector(selector);
  await Promise.all([page.waitForNavigation(), page.click(selector)]);

  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const setPaymentMethod = async (page) => {
  console.log('In setPaymentMethod on page', await page.title());
  let selector = '#name_on_card_2';
  await page.waitForSelector(selector);
  await page.type(selector, 'John Doe');
  console.log('entered name on card');
  // ---
  selector = '#card_number';
  await page.type(selector, '5555555555555555');
  console.log('entered card number');
  // ---
  selector = '#card_expiry';
  await page.type(selector, '1225');
  console.log('entered card expiry');
  // ---
  selector = '#card_code';
  await page.type(selector, '123');
  console.log('entered card code');
  // ---
  selector = '#checkout_form_payment input[type="submit"]';
  await Promise.all([page.waitForNavigation(), page.click(selector)]);
  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const placeOrder = async (page) => {
  console.log('In placeOrder on page', await page.title());
  let selector = '#checkout_form_confirm input[type="submit"]';
  await page.waitForSelector(selector);
  await Promise.all([page.waitForNavigation(), page.click(selector)]);
  let pageTitle = await page.title();
  console.log(`"${pageTitle}" loaded`);
  return;
};

const mainSession = async () => {
  const browser = await getNewBrowser();
  const skipSessionClose =
    process.env.SKIP_SESSION_CLOSE || Math.floor(Math.random() * 3) === 0;

  try {
    const page = await browser.newPage();
    if (Math.floor(Math.random() * 3) === 0) {
      await page.emulate(choosePhone());
    }

    await page.setDefaultNavigationTimeout(
      process.env.PUPPETEER_TIMEOUT || 40000
    );

    // go to home page
    await page.goto(startUrl, { waitUntil: 'domcontentloaded' });

    let pageTitle = await page.title();
    console.log(`"${pageTitle}" loaded`);

    let didUserLeave = await randomlyCloseSession(
      browser,
      page,
      skipSessionClose
    );
    if (didUserLeave) {
      return;
    }

    await goToBags(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await goToProduct(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await addToCart(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await goToCheckout(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await checkoutGuest(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await fillAddress(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await setShippingMethod(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await setPaymentMethod(page);

    didUserLeave = await randomlyCloseSession(browser, page, skipSessionClose);
    if (didUserLeave) {
      return;
    }

    await placeOrder(page);
    await page.close();
  } catch (err) {
    console.log(`Session failed: ${err}`);
  } finally {
    await browser.close();
  }
};

// Session 1
// Home
// Bags
// Datadog Tote
// Add to Cart
// Checkout
// Fill in details to complete checkout/place order
(async () => mainSession())();
(async () => mainSession())();
(async () => mainSession())();
(async () => mainSession())();
