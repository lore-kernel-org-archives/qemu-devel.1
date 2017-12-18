Received: from eggs.gnu.org ([2001:4830:134:3::10]:35889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwQ5-0001EH-Oq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwQ5-00006Z-4V
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:29:29 -0500
Date: Mon, 18 Dec 2017 14:29:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218142919.GM16653@stefanha-x1.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-7-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-7-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] block/stream: use block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 07:59:52PM -0500, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN9C/AAoJEJykq7OBq3PI5AEH/jyi34WvRDiIqPcbWkZfZXd8
OBoxjiMHLC9pvA4DfhXungbcbNTzuOOLLh7XD3BuIC4PVvS9F8mDU8adnnJc3jW7
soIZWuNHgWt01pIlALTKQQ9KMoYxKxKN75IxHCCwUVLz6i1UrBqxqeYvpauLCgQk
vewuH4LL1ZuGY3c96dd7//a3f2p4LTXB0YiPks1aZlbW8eXzAAS9xrwWLxnBrhGd
oa4nGoOI302Vo4XnqaVySWLNLNpLwC9gyWl1ihTDtdOVAOe9ntL28ChsDNSfUdmk
bTAB6t37SX286cp2Z6nTHmxextjqEnba4ngO+xSFP86Pz4B8w4JCNhpODUXhKaE=
=uoKJ
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
