Received: from eggs.gnu.org ([2001:4830:134:3::10]:52957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLYs-0008WQ-3O
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLYr-00085Q-51
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:57:18 -0500
Date: Wed, 10 Jan 2018 18:56:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110185652.GH24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 6/9] qemu-img: Map bench buffer
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


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2018 at 05:18:43PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVmH0AAoJEJykq7OBq3PIdecH/34tQYaFJv8i/HT6KLE22sF/
bBysEyhnXxGTD46anG7EcK8+yM3z6PLeHGUkKIHkMUN3SG4wnBMtVqVwodc7uD18
O8PGoSmmf7XMZh1n4lpzMmCgETjAO0F7aDTiqvoM26Bq9XKSR0p6UYFi9BCv48+f
dbcKTrYujNXwhIRUM1+msQxEMeUO6vBJyycQhTOP1Ez1jBHhGyaMyIH4vLmNno+F
uE2fMgBuL7Lf47z3MSxWA8Dm9jVTiOomVFwEgxS+1zkzUhC70lOVLxZ1Utnr205L
eAGC0MwUU2RhVBHDIPtZYDZsOMRAyQeTaGk52TbxPGiun6Hz5w6RzI3LDWNse50=
=pyrY
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
