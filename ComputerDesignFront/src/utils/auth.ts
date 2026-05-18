export function isAuthenticated(): boolean {
  const token = localStorage.getItem('token')
  if (!token) return false

  try {
    // 仅解析（不验证签名！）
    const payload = JSON.parse(atob(token.split('.')[1]))
    return payload.exp * 1000 > Date.now() // 检查过期时间
  } catch {
    return false
  }
}
