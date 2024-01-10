from typing import Dict
import os
from fastapi import FastAPI

from fastapi_opa import OPAConfig
from fastapi_opa import OPAMiddleware
from fastapi_opa.auth import OIDCAuthentication
from fastapi_opa.auth import OIDCConfig

oidc_config = OIDCConfig(
    app_uri=os.getenv("APP_URI"),
    client_id=os.getenv("OIDC_CLIENT_ID"),
    client_secret=os.getenv("OIDC_CLIENT_SECRET"),
    well_known_endpoint=os.getenv("OIDC_WELL_KNOWN"),
)
oidc_auth = OIDCAuthentication(oidc_config)
opa_config = OPAConfig(authentication=oidc_auth, opa_host=os.getenv("OPA_HOST"))

app = FastAPI()
app.add_middleware(OPAMiddleware, config=opa_config)

@app.get("/{proposal}/{session}")
async def data(proposal: int, session: int) -> Dict:
    return {"msg": f"On Proposal {proposal}, Session {session} the collected data was {hash((proposal, session))}"}
