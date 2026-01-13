import AdminJS from 'adminjs'
import { Database, Resource } from '@adminjs/prisma'
import { PrismaClient } from '@prisma/client'

AdminJS.registerAdapter({ Database, Resource })

export function buildAdmin(prisma: PrismaClient) {
  const admin = new AdminJS({
    rootPath: '/admin',
    resources: [
      {
        resource: { model: (prisma as any)._dmmf.modelMap.Project, client: prisma },
        options: {
          navigation: { name: 'Catalog', icon: 'Folder' }
        }
      },
      {
        resource: { model: (prisma as any)._dmmf.modelMap.MicroserviceModule, client: prisma },
        options: {
          navigation: { name: 'Catalog', icon: 'Cube' }
        }
      },
      {
        resource: { model: (prisma as any)._dmmf.modelMap.CommonPrompt, client: prisma },
        options: {
          navigation: { name: 'Content', icon: 'Document' },
          properties: {
            content: { type: 'textarea' },
            tags: { type: 'string' }
          }
        }
      }
    ],
    branding: {
      companyName: 'CodeHelp Admin'
    }
  })

  return admin
}
