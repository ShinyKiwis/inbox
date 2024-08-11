// String helpers
export function truncate(str) {
  const truncateLimit = 25;
  const dots = '...';
  const truncatedStringLength = truncateLimit - dots.length;
  return str.length >= truncateLimit ? 
    str.substring(0, truncatedStringLength) + dots : 
    str
}

// Asynchronous
export function debounce(func, delay){
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => { func.apply(this, args); }, delay);
  };
}
