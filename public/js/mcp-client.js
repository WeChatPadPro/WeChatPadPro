// ... existing code ...
const eventSource = new EventSource('http://localhost:8080/sse');

eventSource.onmessage = function(event) {
    const mcpData = JSON.parse(event.data);
    // 处理MCP协议更新
    updateUI(mcpData);
};

eventSource.onerror = function(err) {
    console.error('SSE连接异常:', err);
};
