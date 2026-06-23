# Deployment

How and where this application runs in production, and how deployments happen.

---

## Deployment Architecture

Three independent services, each deployed via native GitHub integration -
no custom deployment scripts or CI-driven deployment pipeline required.

| Component | Platform | Trigger |
|---|---|---|
| Frontend | Vercel | Push to main (auto-deploy via GitHub integration) |
| Backend | Render | Push to main (auto-deploy via GitHub integration) |
| Database | Supabase | Provisioned once; not redeployed on push |

This split is intentional - see DECISIONS.md for the reasoning behind each
platform choice. The deployment model is deliberately simple: each platform
watches the repository and deploys automatically, so there is no custom
deployment automation to build or maintain.

---

## Frontend (Vercel)

1. Connect the GitHub repository to a new Vercel project.
2. Set the root directory to frontend/.
3. Configure environment variables in the Vercel dashboard (the backend API
   URL the deployed frontend should call).
4. Every push to main triggers an automatic build and deploy.

Live URL: to be added once first deployed.

---

## Backend (Render)

1. Create a new Web Service on Render, connected to this repository.
2. Set the root directory to backend/.
3. Set the build command and start command (to be finalized once
   requirements.txt and the app entrypoint exist - expected to be
   "pip install -r requirements.txt" and
   "uvicorn app.main:app --host 0.0.0.0 --port $PORT").
4. Configure environment variables in the Render dashboard - see
   .env.example for the full list. Never commit real values to the repo.
5. Every push to main triggers an automatic build and deploy.

Live URL: to be added once first deployed.

---

## Database (Supabase)

1. Create a new Supabase project.
2. Enable the pgvector extension (Database -> Extensions -> enable "vector").
3. Copy the connection string into DATABASE_URL in both local .env and
   the Render dashboard environment variables.
4. Database schema/migrations: approach to be documented once
   backend/app/db/models.py is implemented.

---

## Environment Variables in Production

All variables listed in .env.example must be set directly in each platform's
dashboard (Vercel and Render). They are never committed to the repository.
See PROJECT_CHARTER.md and DECISIONS.md for the reasoning behind keeping
secret management this simple rather than introducing a dedicated secrets
manager - this project's scale does not warrant that added complexity.

---

## Deployment Checklist (for first deploy)

- [ ] Supabase project created, pgvector extension enabled
- [ ] Backend deployed to Render, environment variables set, health check passing
- [ ] Frontend deployed to Vercel, pointing at the live backend URL
- [ ] CORS configured on the backend to allow the deployed frontend origin
- [ ] End-to-end smoke test: ask a question through the live frontend and
      confirm a grounded answer with citations is returned
- [ ] Live URLs added to README.md and this document

---

## Status of This Document

This describes the intended deployment process. Specific build/start commands
and migration steps will be finalized and corrected here once backend and
frontend implementation is complete enough to actually deploy.