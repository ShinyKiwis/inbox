// String helpers
export function truncate(str) {
  const truncateLimit = 25;
  const dots = '...';
  const truncatedStringLength = truncateLimit - dots.length;
  return str.length >= truncateLimit ? 
    str.substring(0, truncatedStringLength) + dots : 
    str
}
