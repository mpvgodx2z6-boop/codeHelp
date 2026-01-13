# 公共提示词库

本文档记录项目开发过程中的常见问题、最佳实践和需要注意的事项，帮助避免重复犯错。

## 数据库设计

### ✅ 标准字段
**提示词**: "所有数据表都需要包含标准字段"

**说明**: 除特殊的中间表外，所有数据表必须包含：
- `createdAt`: 创建时间
- `updatedAt`: 更新时间  
- `createdBy`: 创建人ID
- `updatedBy`: 更新人ID

**示例**:
```prisma
model Example {
  id        String   @id @default(cuid())
  name      String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  createdBy String?
  updatedBy String?
}
```

### ✅ SQLite JSON 类型限制
**提示词**: "SQLite 不支持原生 JSON 类型"

**说明**: 在使用 Prisma + SQLite 时，JSON 字段必须使用 String 类型存储。

**错误示例**:
```prisma
architectureJson Json?  // ❌ SQLite 不支持
```

**正确示例**:
```prisma
architectureJson String?  // ✅ 使用 String 存储 JSON
```

### ✅ 外键索引
**提示词**: "外键字段必须添加索引"

**说明**: 所有外键字段都应该添加索引以提升查询性能。

**示例**:
```prisma
model MicroserviceModule {
  projectId String
  project   Project @relation(fields: [projectId], references: [id])
  
  @@index([projectId])  // ✅ 外键索引
}
```

## AdminJS 配置

### ✅ 正确的模型注册方式
**提示词**: "使用 getModelByName 注册 Prisma 模型"

**说明**: AdminJS Prisma 适配器提供 `getModelByName()` 辅助函数，应该使用它而不是直接访问 _dmmf。

**错误示例**:
```typescript
// ❌ 直接访问内部属性
resource: { model: prisma._dmmf.modelMap.Project, client: prisma }
```

**正确示例**:
```typescript
// ✅ 使用辅助函数
import { getModelByName } from '@adminjs/prisma'
resource: { model: getModelByName('Project'), client: prisma }
```

### ✅ Markdown 和 JSON 字段配置
**提示词**: "Markdown 和 JSON 字段使用 textarea"

**说明**: 大文本字段应配置为 textarea 以提供更好的编辑体验。

**示例**:
```typescript
options: {
  properties: {
    architectureMd: { type: 'textarea' },
    architectureJson: { type: 'textarea' },
    descriptionMd: { type: 'textarea' }
  }
}
```

## Node.js 模块系统

### ✅ AdminJS v7 需要 ESM
**提示词**: "AdminJS v7 要求使用 ESM 模块"

**说明**: 
- package.json 必须设置 `"type": "module"`
- tsconfig.json 使用 `"module": "ESNext"` 和 `"moduleResolution": "bundler"`

**package.json**:
```json
{
  "type": "module"
}
```

**tsconfig.json**:
```json
{
  "compilerOptions": {
    "module": "ESNext",
    "moduleResolution": "bundler"
  }
}
```

## Git 工作流

### ✅ 提交前本地测试
**提示词**: "代码提交前必须完成本地测试"

**检查清单**:
1. ✅ 功能正常运行
2. ✅ 代码构建成功 (`npm run build`)
3. ✅ 开发服务器启动正常 (`npm run dev`)
4. ✅ 数据库迁移应用成功
5. ✅ AdminJS UI 正常显示
6. ✅ 相关文档已更新

## 常见错误

### ❌ 数据库文件路径错误
**问题**: DATABASE_URL 路径不正确导致数据库文件位置错误

**解决方案**: 
```env
# ✅ 正确 - 相对于 schema.prisma
DATABASE_URL="file:./dev.db"

# ❌ 错误 - 会在错误位置创建数据库
DATABASE_URL="file:./prisma/dev.db"
```

### ❌ TypeScript 编译错误
**问题**: 模块解析设置不匹配导致编译失败

**解决方案**: 使用 bundler 模块解析策略
```json
{
  "compilerOptions": {
    "moduleResolution": "bundler"
  }
}
```

### ❌ 忘记更新文档
**问题**: 代码变更后忘记更新相关文档

**解决方案**: 每次变更后检查并更新：
- CHANGELOG.md
- README.md
- 相关功能文档

## 最佳实践

### ✅ 软删除而非硬删除
**提示词**: "使用 isDeleted 标记实现软删除"

**说明**: 保留数据记录，使用 `isDeleted` 字段标记删除状态。

**示例**:
```prisma
model Project {
  isDeleted Boolean @default(false)
}
```

### ✅ 默认值设置
**提示词**: "为常用字段设置合理的默认值"

**示例**:
```prisma
status    String   @default("active")
isDeleted Boolean  @default(false)
createdAt DateTime @default(now())
```

### ✅ 命名一致性
**提示词**: "字段命名保持一致性"

**规则**:
- Markdown 字段使用 `*Md` 后缀
- JSON 字段使用 `*Json` 后缀
- 时间字段使用 `*At` 后缀
- 用户ID字段使用 `*By` 后缀

## 强化学习要点

### 修改前必查
每次修改功能前，必须查询以下内容：
1. ✅ 相关的数据模型定义
2. ✅ 相关的字段和类型
3. ✅ 相关的 API 方法
4. ✅ 前后端架构设计
5. ✅ 已有的类似功能实现
6. ✅ 历史变更记录

### 代码查询命令
```bash
# 查找相关文件
git log --all --full-history -- "**/路径/文件名*"

# 搜索相关代码
git grep "关键词" $(git rev-list --all)

# 查看提交历史
git log --oneline --grep="关键词"
```

---

**最后更新**: 2026-01-13
**维护要求**: 每次发现新问题或总结新经验时更新此文档
