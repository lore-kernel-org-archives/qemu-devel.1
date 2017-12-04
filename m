Received: from eggs.gnu.org ([2001:4830:134:3::10]:36263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLt1l-0001s8-UJ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLt1l-0004oO-6r
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:51:30 -0500
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fa45711a-9203-423f-b9a9-e2006847f6f4@redhat.com>
Date: Mon, 4 Dec 2017 16:51:18 +0100
MIME-Version: 1.0
In-Reply-To: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S7uETFX67lh9cVKxsGN7PexPPPBeCU3W4"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S7uETFX67lh9cVKxsGN7PexPPPBeCU3W4
From: Max Reitz <mreitz@redhat.com>
To: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Qemu-block <qemu-block@nongnu.org>
Message-ID: <fa45711a-9203-423f-b9a9-e2006847f6f4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
In-Reply-To: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-02 23:37, Shravan Rajinikanth wrote:
> Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 68b375f..bea9268 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck *chec=
k, bool quiet)
>          if (check->leaks) {
>              qprintf(quiet,
>                      "\n%" PRId64 " leaked clusters were found on the i=
mage.\n"
> -                    "This means waste of disk space, but no harm to da=
ta.\n",
> +                    "This means disk space is wasted, but data is safe=
=2E\n",
>                      check->leaks);
>          }

How exactly is this a grammatical error?  (I'm not a native English
speaker, but it always seemed perfectly OK to me)

Max


--S7uETFX67lh9cVKxsGN7PexPPPBeCU3W4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolbvYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiKkH/24nN0RnTDKLE98nMoIdfEqASjqxU8QF
mfXsyJqht+s/AM4GyEw4xv10YZAcUzB6wWAcYmlLKV+zU/LUdSG6P1amp8eJV50X
3fTyEUPzpGaEszd+xHmmPgv326phQjKy5cJMWG7IMf9eR+z6kUMW3GS+ULjG2oaU
cokXFLqNXa8n8SW+emxBM8P2e6rYpHRRV4gsUKTmMGZ9ku0NkwCQJ+xmdFFThKjD
pkAqR8aJ/iVGSkgMsX8s5QrEOxqbtCWYP2Z40LjUbPZ7ZEkJjd0gFMt16CT06459
a4DM+4WakBZT/quKg3vyZISAlcB859IV1sxI0nmjCcF2/NRfzUsK8cA=
=lc/h
-----END PGP SIGNATURE-----

--S7uETFX67lh9cVKxsGN7PexPPPBeCU3W4--
