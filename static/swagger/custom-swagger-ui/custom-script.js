// API树形结构生成
function generateApiTree(spec) {
    const apiTree = document.querySelector('.api-tree');
    const paths = spec.paths;
    const tags = {};

    // 按标签分组API
    Object.keys(paths).forEach(path => {
        const methods = paths[path];
        Object.keys(methods).forEach(method => {
            const operation = methods[method];
            const tag = operation.tags[0] || '未分类';
            
            if (!tags[tag]) {
                tags[tag] = [];
            }
            
            tags[tag].push({
                path,
                method,
                summary: operation.summary || path
            });
        });
    });

    // 生成树形结构HTML
    Object.keys(tags).sort().forEach(tag => {
        const tagDiv = document.createElement('div');
        tagDiv.className = 'api-tag';
        
        const tagHeader = document.createElement('div');
        tagHeader.className = 'api-tag-header';
        tagHeader.innerHTML = `
            <span class="tag-name">${tag}</span>
            <span class="tag-count">${tags[tag].length}</span>
        `;
        
        const tagContent = document.createElement('div');
        tagContent.className = 'api-tag-content';
        
        tags[tag].forEach(api => {
            const apiItem = document.createElement('div');
            apiItem.className = 'api-item';
            apiItem.innerHTML = `
                <span class="api-method ${api.method}">${api.method.toUpperCase()}</span>
                <span class="api-path">${api.summary}</span>
            `;
            
            apiItem.addEventListener('click', () => {
                // 滚动到对应的API文档位置
                const selector = `[data-path="${api.path}"][data-method="${api.method}"]`;
                const element = document.querySelector(selector);
                if (element) {
                    element.scrollIntoView({ behavior: 'smooth' });
                }
            });
            
            tagContent.appendChild(apiItem);
        });
        
        tagDiv.appendChild(tagHeader);
        tagDiv.appendChild(tagContent);
        apiTree.appendChild(tagDiv);
    });
}

// 搜索功能
function setupSearch() {
    const searchInput = document.querySelector('.search-box input');
    const apiItems = document.querySelectorAll('.api-item');
    
    searchInput.addEventListener('input', (e) => {
        const searchTerm = e.target.value.toLowerCase();
        
        apiItems.forEach(item => {
            const text = item.textContent.toLowerCase();
            item.style.display = text.includes(searchTerm) ? 'flex' : 'none';
        });
    });
}

// 版本选择功能
function setupVersionSelector() {
    const versionSelect = document.getElementById('version-select');
    
    versionSelect.addEventListener('change', (e) => {
        const version = e.target.value;
        // 这里可以根据选择的版本加载不同的swagger.json
        if (version === 'history') {
            // 加载历史版本
            loadSwaggerSpec('../swagger-history.json');
        } else {
            // 加载当前版本
            loadSwaggerSpec('../swagger.json');
        }
    });
}

// 加载Swagger规范
async function loadSwaggerSpec(url) {
    try {
        const response = await fetch(url);
        const spec = await response.json();
        
        // 重新初始化UI
        window.ui.specActions.updateSpec(JSON.stringify(spec));
        
        // 重新生成API树
        const apiTree = document.querySelector('.api-tree');
        apiTree.innerHTML = '';
        generateApiTree(spec);
        
        // 重新设置搜索
        setupSearch();
    } catch (error) {
        console.error('加载Swagger规范失败:', error);
    }
}

// 设置导航切换
function setupNavigation() {
    const navLinks = document.querySelectorAll('.nav-links a');
    const swaggerUI = document.getElementById('swagger-ui');
    const websocketDocs = document.getElementById('websocket-docs');
    
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            
            // 更新激活状态
            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
            
            // 切换显示内容
            if (link.getAttribute('href') === '#websocket') {
                swaggerUI.style.display = 'none';
                websocketDocs.style.display = 'block';
            } else {
                swaggerUI.style.display = 'block';
                websocketDocs.style.display = 'none';
            }
        });
    });

    // 根据URL hash初始化显示
    const hash = window.location.hash || '#rest-api';
    const activeLink = document.querySelector(`.nav-links a[href="${hash}"]`);
    if (activeLink) {
        activeLink.click();
    }
}

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', () => {
    setupVersionSelector();
    setupNavigation();
    
    // 监听SwaggerUI完成加载
    const checkSwaggerUI = setInterval(() => {
        if (window.ui && window.ui.specSelectors) {
            clearInterval(checkSwaggerUI);
            const spec = window.ui.specSelectors.specJson().toJS();
            generateApiTree(spec);
            setupSearch();
        }
    }, 100);
}); 