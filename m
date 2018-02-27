Received: from eggs.gnu.org ([2001:4830:134:3::10]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqj8j-0001vh-VU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqj8g-00025G-1d
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:34:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eqj8f-000257-Sq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:34:05 -0500
Date: Tue, 27 Feb 2018 17:34:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180227173403.GJ32480@stefanha-x1.localdomain>
References: <20180226030326.20219-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20180226030326.20219-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Add git-publish config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, f4bug@amsat.org, pbonzini@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 11:03:24AM +0800, Fam Zheng wrote:
> v4: Fix prefixes. [Stefan]
>     Keep rich profiles. [Paolo]
>=20
> v3: Fix trivial hunk placement. [Michael]
>     Fix PPC sub-list. [Michael]
>=20
> v2: Add README paragraph [Marc-Andr=E9, Stefan]
>     Fix 'trivial' profile [Marc-Andr=E9]
>     Rename profiles [Stefan]
>=20
> Fam Zheng (2):
>   Add a git-publish configuration file
>   README: Document 'git-publish' workflow
>=20
>  .gitpublish | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  README      | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 .gitpublish
>=20
> --=20
> 2.14.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalZaLAAoJEJykq7OBq3PIrJsIAL6zKeJhA6U7jtPs+69CHZcP
zFzolWG+VmfB3si0hXE8JbcJJFmr74IqolqRT93aAGWZ2Zic0nvsgPdZfzk6KkRk
xyN/tTqZYj1aGNbFiryiliB3llQvPsidPWtCY4xCUW0o+n4FbJTC+7iVckBXfQTT
L8LTCZTdiALC1Ui8QdVLaUY/OecFpJXC5xOTliRC1ykZuG/coMtQpyuxrTaez9DR
j+Ho0db4VChIh11x7566cLoJ6DVcSFUotatSUYVPuJPABHli84fzD7AJh4ELzHS6
4PI7Yh2kB4pfB6I5FytsKcQvZczwvnVhMVyY6tJ1qWZQSgwtMeykFHjSsAQB6bg=
=W9PV
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
