Received: from eggs.gnu.org ([2001:4830:134:3::10]:42097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxeC-0002wc-RK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxe7-0002Ey-VG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:04:24 -0400
Date: Tue, 11 Jul 2017 17:04:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711160414.GF31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-11-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/35] vmdk: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:VMDK" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:21AM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/vmdk.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZPb+AAoJEJykq7OBq3PIgQAIALrp4gSKzAbVspjj5uc7a609
CL8i5ObxPHJf94kDV4WXXRfTDSSo+7rHrdfXNi2aBx2UF9QhYuhffIlvPXhpPjH6
dRO7tBW2gicZ5E/WfFgL6OgeuClJFkCnta0wUTznfxl0yB6kT5mU9UoWC3zQTsBL
C9goPIOqkX2of5mHVH+o2GLTsNkpe8kXudUyuH6YWQm/G2PJw0gIlissDB7xfRA/
0FPEifPFdxlCqieHouuLMDMVY7E6fKEq3TcxtoJ1ic54sf8n8UJLj5l94/soapPo
ijfHGyvYdbMjoDHUOL/810EtxKMb9jII7/TunIas91AUReHmTvjCQQxS/Ed+S38=
=kiKy
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
