import { lazy } from 'react';
import GlobalLayout from './pages/_layout'

const Index = lazy(() => import('./pages/index'));
const CartIndex = lazy(() => import('./pages/cart/index'));
const PaymentIndex = lazy(() => import('./pages/payment/index'));
const ProductsIndex = lazy(() => import('./pages/products/index'));
const ProductId = lazy(() => import('./pages/products/[id]'));
const AdminIndex = lazy(() => import('./pages/admin/index'));

export const routes = [
  {
    path: '/',
    element: <GlobalLayout />,
    children: [
      { path: '/', element: <Index />, index: true},
      { path: '/cart', element: <CartIndex />, index: true},
      { path: '/payment', element: <PaymentIndex />, index: true},
      { path: '/products', element: <ProductsIndex />, index: true},
      { path: '/products/:id', element: <ProductId />, },
      { path: '/admin', element: <AdminIndex />, index: true},
    ]
  }
]

export const pages = [
  { route: '/' },
  { route: '/cart' },
  { route: '/payment' },
  { route: '/products' },
  { route: '/products/:id' },
  { route: '/admin' },
]
