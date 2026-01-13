import AdminJS from 'adminjs'
import { Database, Resource, getModelByName } from '@adminjs/prisma'
import { PrismaClient } from '@prisma/client'

AdminJS.registerAdapter({ Database, Resource })

export function buildAdmin(prisma: PrismaClient) {
  const admin = new AdminJS({
    rootPath: '/admin',
    resources: [
      {
        resource: { model: getModelByName('Project'), client: prisma },
        options: {
          navigation: { name: 'Catalog', icon: 'Folder' },
          properties: {
            architectureMd: { type: 'textarea' },
            descriptionMd: { type: 'textarea' },
            architectureJson: { type: 'textarea' },
            forbiddenMistakes: { type: 'textarea' },
            modules: { type: 'textarea' },
          }
        }
      },
      {
        resource: { model: getModelByName('MicroserviceModule'), client: prisma },
        options: {
          navigation: { name: 'Catalog', icon: 'Cube' },
          properties: {
            architectureMd: { type: 'textarea' },
            descriptionMd: { type: 'textarea' },
            architectureJson: { type: 'textarea' },
            forbiddenMistakes: { type: 'textarea' },
            modules: { type: 'textarea' },
          }
        }
      },
      {
        resource: { model: getModelByName('CommonPrompt'), client: prisma },
        options: {
          navigation: { name: 'Content', icon: 'Document' },
          properties: {
            contentMd: { type: 'textarea' },
            tags: { type: 'textarea' }
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
