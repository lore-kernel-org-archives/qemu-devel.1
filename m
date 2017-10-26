Received: from eggs.gnu.org ([2001:4830:134:3::10]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e7pYj-0007h6-LI
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e7pYg-0004c7-Ha
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:19:25 -0400
Date: Thu, 26 Oct 2017 23:12:00 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171026211200.GA3181@umbus>
References: <20170630183736.13222-1-rth@twiddle.net>
	<1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2017 at 02:22:57PM +0200, Thomas Huth wrote:
> On 30.06.2017 20:37, Richard Henderson wrote:
> > Cc: qemu-ppc@nongnu.org
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/ppc/translate.c | 23 ++++++++---------------
> >  1 file changed, 8 insertions(+), 15 deletions(-)
>=20
> *ping*
>=20
> Richard, David, any chance that we can still get this in for 2.11? I
> think this would be quite a nice performance improvement for PPC TCG...

Uh.. sorry, I don't even remember this patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnyT50ACgkQbDjKyiDZ
s5KWqg/7BC2qKw48kiq7kqW4VhdJhrOSjfJInYCxC77+Wx4eIV8ZaHGjfaEdWot0
49iK1pNQqGph8lTNSPreMkZNGRCVTDM4OBecXV8OaCBS8vZ3vwJhHos6XB1eJttj
k6nhaWswaUcFyVXwrUpMyyx+Fy4vWI5oUZuMXiHyg5cgK2JaM8HXRyOOXvp3Pk5V
UcQ2i38y4OXaue8wXHItL4/H0XOHhblDFVf3W/WxZrXpTnZBY5ytRJOfg8Lq9JbF
mAygq3M4i+VBGPj8V6JSxiOCgoeWDqUJuEZDd95eGHWsHTbJDNpgDvxXUja7ElJB
bKb+KdJp1KxKBSHcVFRNXGySXUIpYs9VEhi3ziyIUWHdaiCnNWAnWmNJ0io5oVY1
29eBxJ0oEFBd4Z27lQMHvMfkO8PZBvWNmDMpSHHYBFDYO/ynOEj4v9UIwZ7RU9RV
PCP+3jFHhlB3yYtVfUx0bUUXM+HmZjLxuzVnmBKfziOdL9o36FsJb6c/vRV3OQ9s
osIhUXXYs1ncPiwtB5UwqWB6X3b/malDNTMycbABOZvIp8YmxUYfUUZl8L8E9f5a
fFbKCCV20IEKeubxjcp/SBYxD58EoFLIaTWuERBfXVZ89kx7HDYqNVEWnFSBCf1T
q3TUhXBxTiWj26FvN73htUrJW/gIHfD+AiVGlB1d9NxZeaFRQYg=
=G/Eg
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
