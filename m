Received: from eggs.gnu.org ([2001:4830:134:3::10]:41210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2ix-00061p-3S
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2iw-00040y-9Y
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:33:39 -0400
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d44946fb-ee4f-51ed-28ae-1b41a5562565@redhat.com>
Date: Mon, 2 Oct 2017 10:33:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-6-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IBN1lJFOid9PLsLE7koQ7Gl3DbpIWf7St"
Subject: Re: [Qemu-devel] [PATCH 5/8] qemu-options: Add missing -iscsi
 Texinfo documentation
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IBN1lJFOid9PLsLE7koQ7Gl3DbpIWf7St
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <d44946fb-ee4f-51ed-28ae-1b41a5562565@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] qemu-options: Add missing -iscsi Texinfo
 documentation
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-6-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/qemu-options.hx b/qemu-options.hx
> index c647fdde62..8568ee388c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1180,6 +1180,12 @@ DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
>      "                iSCSI session parameters\n", QEMU_ARCH_ALL)
> =20
>  STEXI
> +@item -iscsi
> +@findex -iscsi
> +Configure iSCSI session parameters.
> +ETEXI
> +
> +STEXI
>  @end table
>  ETEXI
>  DEFHEADING()
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IBN1lJFOid9PLsLE7koQ7Gl3DbpIWf7St
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXEYACgkQp6FrSiUn
Q2oc8gf8Dgxqsh9M8V3RGlTXYxkMnojHuzasghZDEbYYWLLuMTO2WwJ2sUdCH/Mc
/qigqU9LmZIcgdqX7J2xFbojYvl2zDEpF152G+E1DY4K6MdtgDArwvz+0vGAajAm
C6tVBCKs6lMnFhzD95+NnP3Dgzi+P6TctSCmWRjfxWX9Eg4QkP+WCcCjKKYcJEqr
bmrm1T+jtHdEBNBrP0nYg1/AYZjxCTqY8WLsBac8/z0vdSE9Jld1O5aOwqTtS3/d
Ow9bLdicQjx0ZAIQdGBjA+oUveYraILTya84oCFJmSq1ap2fMdKRcOjxuB3Rd88a
UKpm9SvQru52o3phUZRiigNwGPmdOw==
=hKEs
-----END PGP SIGNATURE-----

--IBN1lJFOid9PLsLE7koQ7Gl3DbpIWf7St--
