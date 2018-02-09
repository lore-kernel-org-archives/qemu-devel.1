Received: from eggs.gnu.org ([2001:4830:134:3::10]:57961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ek5hp-00010p-HW
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ek5hj-0000JJ-Ti
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:14:57 -0500
Date: Fri, 9 Feb 2018 10:14:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180209101435.GA30827@stefanha-x1.localdomain>
References: <20180209052915.12855-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20180209052915.12855-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 01:29:12PM +0800, Fam Zheng wrote:
> v7: Tweak wording again "allowing concurrent writers" -> "allowing other =
QEMU
>     processes to open it in write mode". [Eric, Stefan, Kevin]
>     Add patch to document share-rw. [Stefan]
>=20
> v6: Tweak wording ("concurrent writers"). [Max]
>=20
> Fam Zheng (3):
>   qemu-img.texi: Clean up parameter list
>   qemu-img: Document --force-share / -U
>   docs: Document share-rw property more thoroughly
>=20
>  docs/qemu-block-drivers.texi | 10 ++++++
>  qemu-img.texi                | 74 ++++++++++++++++++++++++++++----------=
------
>  2 files changed, 57 insertions(+), 27 deletions(-)

Nice, thanks for being persistent!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJafXSLAAoJEJykq7OBq3PIuPQIAJUGkL8H/KVzNjNMT7ZFqyGG
U0/Zz+lWekLAGyafryE/6txGKMXDoJuIpMjofJGNcnlMxOvRaAEAokXZtXybvbWN
4PdurJPSI0nNjK/Z7exD4ep0n+CCg3gbGtYKtXwWJU81YcuLgy2Dhrc5q5TR4lRO
ZVYIImPctoDV27yAshToZTiRhaIQERT6Ln7aI1QCih7NeFAd4ZM2lKaCvRFbR77t
d2aH3lLhbdqvzefh4IwiPw7EzGYr2Sj9n8D3Cr4xu9IkEu9+Lj+/ETWk5C/0hXrp
gzyKXtrpXKFo269xkYyVuFuViuMFPdKhxQjFoQEMwxhqQjz+W/Ij/+QHgl/azq8=
=8uLr
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
