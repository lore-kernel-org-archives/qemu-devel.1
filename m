Received: from eggs.gnu.org ([2001:4830:134:3::10]:45979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO2ln-0005zA-IR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO2lk-0007VY-FK
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:12:11 -0400
Date: Wed, 30 May 2018 16:12:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530151202.GC5973@stefanha-x1.localdomain>
References: <20180528054055.21153-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20180528054055.21153-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] trace: Sort trace-events-subdirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 02:40:55AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Having these entries sorted helps to add new ones.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  Makefile.objs | 82 +++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDr9CAAoJEJykq7OBq3PI4mgH/j3TGhejFypF5yDLmbNSyVq1
mu/YrHjj3l3LM3pyfZbf730ne6b4fvWzaqb4sykoErgYpXWOBCBPFMuWOpwhIXGj
8ezGElD08pYjkhG5qJpjicmZcYDxniMDgWgRiUS55Mg5o1WXgT1bBWmGWO5FQJ+n
hCfq6sVtCYMeYNfiDj0XoJwXzBhIDIybKUiw/OkUBVNN8yexF+gsceNJ760YA/kl
N7RzmPnayzR2Qs+IuTvIhlkoco5IHlUhbZbWPWXpWamtsLV76c4nDaeg1O/gjgSF
qYSmjfYIkJAOXjv8eBvGC3+XgyczCTUCcvz2GKV897fz8A5w9oA6aGZ9looM28g=
=LvGB
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
