Received: from eggs.gnu.org ([2001:4830:134:3::10]:41411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2jc-0006XL-2W
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2jY-0004Kk-4E
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:34:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz2jX-0004KC-UT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:34:16 -0400
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd3b6756-f063-b8a6-6c31-2b9a13fe4ddc@redhat.com>
Date: Mon, 2 Oct 2017 10:34:12 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C4UbEiXIdcefhPTfwS41W6NBhLGLUTLcH"
Subject: Re: [Qemu-devel] [PATCH 6/8] qemu-options: Polish section "TPM
 device options"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C4UbEiXIdcefhPTfwS41W6NBhLGLUTLcH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Message-ID: <fd3b6756-f063-b8a6-6c31-2b9a13fe4ddc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] qemu-options: Polish section "TPM device
 options"
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-7-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C4UbEiXIdcefhPTfwS41W6NBhLGLUTLcH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXHQACgkQp6FrSiUn
Q2qtGQgAhJDUkH0RZU2TlfHl2zK2YGLZ0m5qnIczqkuue8jaMQfzCB4swCCgpodj
9ag3pey/MRZ7QBE96FRaxhgx2R4Oxr766TiVD3eZmKCToFIXrxm8Vn1Pi/7A9Pb5
+dN4IpS5SyPr08tWxlvUHhW2OCwxCe69SPXaq0WnCUGmGrKttqvBK82PnbVXQ39g
HjMv733IvrGu2JdcISAyKUS9gU1TzazFjRD6UsaprrwkqUEjkggoksYDJxcV4/Mz
U6KxAlqAnvSYVvBAlk1I/RUbuk65C73rgW3ECWZMJACQTTDGQHzrdfB5ceVHRv4k
6UClDTHXd63KiC9aLzsGxknGTEshoQ==
=cCX6
-----END PGP SIGNATURE-----

--C4UbEiXIdcefhPTfwS41W6NBhLGLUTLcH--
