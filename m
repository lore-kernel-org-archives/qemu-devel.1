Received: from eggs.gnu.org ([2001:4830:134:3::10]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLhr-0007pJ-CH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLhq-0006z8-Kd
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:06:35 -0500
Date: Wed, 10 Jan 2018 19:06:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110190619.GK24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-10-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-10-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 9/9] qapi: Add NVMe driver options to
 the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2018 at 05:18:46PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qapi/block-core.json | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVmQrAAoJEJykq7OBq3PIghkIAINbco2lnVTKJQbY1Ut3nkgK
GwNYMoiFnDRlDDHUuZWIPu0gqolq2h76mF1ChFl1wGKcrPe4h0kFPARNj/Seo0J+
ylrvIFGMHUEIAuW/tBGwXz4tEZV4mLTDxF9ALi7zLNlRO6OTUHj1lf1sly6m76su
2fEmXA/HuTIGJTHYX6ACJ1wFtX4s7W+wnvXAImIQ3vUUiApSqUAFgkyrwvSFc90u
cf/dO8fMN3WeXLGLULTcRCXIJlnzj5RhsV4YVpd1EQiDauenHrNjrjWe84SFnZcZ
ZF1ifT2wSXQgoKwXPLONnEBptMtmXzgEAj/u25/B+urWrLjiK0JKi1VQzuvKUXk=
=HtlP
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
