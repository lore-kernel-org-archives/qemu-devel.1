Received: from eggs.gnu.org ([2001:4830:134:3::10]:60658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZvuQ-00012u-RG
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZvuP-00016T-TR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:45:58 -0500
Date: Fri, 12 Jan 2018 09:45:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112094544.GB7356@stefanha-x1.localdomain>
References: <20180112085555.14447-1-famz@redhat.com>
	<20180112085555.14447-9-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20180112085555.14447-9-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 8/9] docs: Add section for NVMe VFIO
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 04:55:54PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Message-Id: <20180110091846.10699-9-famz@redhat.com>
> ---
>  docs/qemu-block-drivers.texi | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWIPIAAoJEJykq7OBq3PIsQgH/0Ps493e7yfsPKC03Sa9aUR6
bZ2IGJ05SvpJ/Z5b95bT8NoS36c13o3YAxsBM+GgAt0tmSG/BINBFCXBFNGCTgqN
PJ58mVaWCBae3BW9nWpVJPMV8KFy9O4z3cS22uzxRBWf8xB+hAE7//C0Z7tbXY+d
88A/aa6OPjFLZ/nof/z7S43/DM8a4v5fUwVPHNOo9cIjv1GAYoP7bU2kLgLdk5uq
EpTS1xz7xsvNwieKEjKfiNQraUeHoDPgpe8fTQsWxAWIEUzhFwd5uPGZRWI3DlkM
Rg6pDA63RcAXHL2ADcbHt+2gdSpQL45A5Hi++l12AB+mn7u7/otvNNod9Kvx6q8=
=W4fv
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
