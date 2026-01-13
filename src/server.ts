import 'dotenv/config'
import express from 'express'
import AdminJS from 'adminjs'
import AdminJSExpress from '@adminjs/express'
import { PrismaClient } from '@prisma/client'
import { buildAdmin } from './admin'

const prisma = new PrismaClient()

async function main() {
  const app = express()

  const admin = buildAdmin(prisma)

  const adminRouter = AdminJSExpress.buildRouter(admin)
  app.use(admin.options.rootPath, adminRouter)

  app.get('/health', (_req, res) => {
    res.json({ ok: true })
  })

  const port = Number(process.env.PORT || 3000)
  app.listen(port, () => {
    // eslint-disable-next-line no-console
    console.log(`AdminJS running at http://localhost:${port}${admin.options.rootPath}`)
  })
}

main().catch(async (err) => {
  // eslint-disable-next-line no-console
  console.error(err)
  await prisma.$disconnect()
  process.exit(1)
})
