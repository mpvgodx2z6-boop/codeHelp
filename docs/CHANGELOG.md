# 变更日志

本文档记录项目的所有重要变更，包括功能新增、修改、数据库变更等。

## [v0.2.0] - 2026-01-13

### 新增
- **数据库标准字段**: 为所有模型添加 `createdBy` 和 `updatedBy` 字段
  - Project 模型新增创建人和更新人字段
  - MicroserviceModule 模型新增创建人和更新人字段
  - CommonPrompt 模型新增创建人和更新人字段

### 文档
- 创建 `/docs/CODING_STANDARDS.md` - 代码规范与开发标准文档
- 创建 `/docs/CHANGELOG.md` - 变更日志文档
- 创建 `/docs/PROMPT_LIBRARY.md` - 公共提示词库

### 说明
根据项目规范要求，所有数据表都需要包含创建人和更新人字段，用于追踪数据的创建者和最后修改者。这些字段为可选字段（String?），在用户认证系统完成后将自动填充。

---

## [v0.1.0] - 2026-01-13

### 新增
- **Project 模型扩展**: 
  - 新增 `category`（项目类别）字段
  - 新增 `architectureJson`（技术架构JSON）字段
  - 新增 `architectureMd`（技术架构Markdown）字段
  - 新增 `forbiddenMistakes`（禁止错误列表JSON）字段
  - 新增 `modules`（模块清单JSON）字段
  - 新增 `descriptionMd`（项目说明Markdown）字段
  - 新增 `status`（状态，默认"active"）字段
  - 新增 `isDeleted`（软删除标记）字段

- **MicroserviceModule 模型扩展**:
  - 与 Project 相同的新增字段
  - 保持与 Project 的关联关系

- **CommonPrompt 模型重构**:
  - ✅ 移除 `moduleId` 外键，使其成为独立资源
  - 新增 `type`（提示词类型）字段
  - 将 `content` 重命名为 `contentMd`
  - 将 `tags` 从普通字符串改为JSON字符串数组
  - 新增 `isDeleted`（软删除标记）字段

### 修改
- **AdminJS 配置**:
  - 配置 Markdown 字段使用 textarea 输入
  - 配置 JSON 字段使用 textarea 输入
  - 使用 `getModelByName()` 辅助函数注册模型

- **模块系统**:
  - package.json 改为 ESM 模块 (`"type": "module"`)
  - tsconfig.json 使用 `moduleResolution: "bundler"`
  - 修正 @adminjs/prisma 版本为 ^5.0.0

- **配置文件**:
  - DATABASE_URL 路径修正为 `file:./dev.db`
  - .gitignore 添加 .adminjs/ 和数据库文件

### 数据库
- 创建迁移 `20260113023820_add_frd_fields`
- SQLite 不支持原生 JSON 类型，使用 String 存储

### 技术说明
- JSON 字段以字符串形式存储，需在应用层处理序列化/反序列化
- 软删除字段已添加但 AdminJS UI 过滤功能待实现
- CommonPrompt 现为独立资源，未来可通过中间表关联 Project/Module

---

## [v0.0.1] - 2026-01-13

### 初始化
- 创建基础项目结构
- 集成 AdminJS + Express + Prisma + SQLite
- 创建基础模型：Project、MicroserviceModule、CommonPrompt
- 配置开发环境和构建脚本

---

**文档维护**: 每次重要变更后必须更新此文档
**格式说明**: 使用语义化版本号 (MAJOR.MINOR.PATCH)
