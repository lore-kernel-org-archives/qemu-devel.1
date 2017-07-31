Received: from eggs.gnu.org ([2001:4830:134:3::10]:57507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcBMS-00005e-Cq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcBMR-0006ZB-JX
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:07:56 -0400
Date: Mon, 31 Jul 2017 16:07:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170731140741.GB12064@localhost.localdomain>
References: <20170731125111.28052-1-kwolf@redhat.com>
	<0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
	<2f7e54a4-3a99-2506-a3ec-e9df6272a30c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <2f7e54a4-3a99-2506-a3ec-e9df6272a30c@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block/qapi: Remove
 redundat NULL check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.07.2017 um 16:00 hat Eric Blake geschrieben:
> On 07/31/2017 08:06 AM, Eric Blake wrote:
> > On 07/31/2017 07:51 AM, Kevin Wolf wrote:
>=20
> In the subject line, s/redundat/redundant/

Thanks, I'll fix this.

Kevin

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZfzmtAAoJEH8JsnLIjy/WwKEP/3oSqWIJzVwZCwR5txpu8493
bA7zwF3VyYazoPgVeT2UH/gmYdW0yeQxUyG+8RiFAlAyLoh1arl4u2+PpVBTj+Ng
wMR7syi4DeJC0M12lzOdpj4hY1odnkHiD7Sp5dsjRomu5T2RqtacoCOfnHKN/jDT
zNR0Sa78YfvLLQurBcx5dzBjSk9X1WnQDysXiR0q7xYH9iWZnI7BjGntaLQqDoKY
QWVE77VCvMwUJJrllNxJjArdqCWFLTod2J6SNzlrTgwN5mPSiDWMzlPG9N5mUab4
or9MmPlvOHCUcaokgBD53Dn75sGILlZKEouFQA9lBuzHJBpGCzm3yC/hHH/NMznq
2isw7FordrVw/oh3el3wcJYjW+dT9Yxrjut8pemdvsBaWlcvk13wCfEM5cCpftXF
xZumYGA45CrGo0A1z9Hc9GhlzO6/k0auRGzF6BG475d7YAOwovGVJQgy2flPmMtL
P/mIPLXyDPU5G+4AjOj4DlgH7+KnXgt3eVYgiPRgkGZwOmaURCdpCcpq1ecpCF+6
/8zR982/QuwiVIe0FObLflays/M7cqWZbmIPhLKC4+gfJpNaYZE6jdL3+mryuqB6
oztuNodiiY/orbX/UwrLhdnikEUSHWnXT1F1yIREVtoGwwJFta3q3rjeJQNzTDbv
92Il6/7l6IXFrHO8Xz/T
=uIFO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
