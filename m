Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSM4G-0000VE-CB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSM4C-0004We-EN
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:32:32 -0400
Date: Tue, 4 Jul 2017 21:06:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704110631.GF2180@umbus.fritz.box>
References: <20170614063607.47863-1-aik@ozlabs.ru>
	<20170614063607.47863-3-aik@ozlabs.ru>
	<653b598c-d838-ee69-5848-ae7ea85f5376@ozlabs.ru>
	<20170621072641.GB12089@umbus>
	<9a8d908e-f0da-5b60-f5a6-65a27159e3bb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <9a8d908e-f0da-5b60-f5a6-65a27159e3bb@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v8 2/2] memory/iommu: introduce
 IOMMUMemoryRegionClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 02:19:57PM +1000, Alexey Kardashevskiy wrote:
> On 21/06/17 17:26, David Gibson wrote:
> > On Wed, Jun 21, 2017 at 12:05:08PM +1000, Alexey Kardashevskiy wrote:
> >> On 14/06/17 16:36, Alexey Kardashevskiy wrote:
> >>> This finishes QOM'fication of IOMMUMemoryRegion by introducing
> >>> a IOMMUMemoryRegionClass. This also provides a fastpath analog for
> >>> IOMMU_MEMORY_REGION_GET_CLASS().
> >>
> >>
> >> Ping?
> >=20
> > Busy.. sick.. busy & sick..
> >=20
> > I'll get to it eventually.
>=20
> Well, if would be nice to hear from anyone...

Well, sure.

It would've been nice not to get an ear infection and stay stuck in a
hotel room in Beijing for a week, too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW3a3AAoJEGw4ysog2bOSTBIP/i4pTAPwksarzI9/xaZZIb2o
wPaGUqt1NTh2wk5H8lFImFgB+dnrX0yj1orlGZK0dc5j/eBDV9du0MIE+UZJt88H
owgsVQHKp3f7TEoJkqKUWupZoHuhC/tXGva+uuDfjK0HZ6nkkJdvt1QNBLtj60w3
DzBDUNOoK9+e3whErT/1QANVvHS17im75VKlDOn8vjakFvVWnY7iNn+6kHtGRYqf
7ZYaCL7oUSpNqvNmtDoroEGGOLv89/UTOTIZc2BZ9M/tFNqoG2EHswcqp+6g3v3d
uhAlaN3Uba77+qGZd7iCp3BLIUSwRy60D1gTTOIEkg5dOENFl6P59x1I2yIu9xGb
Oh3kSC0ag5Zj5bx15o3LLJoNvHal5KiEngXjUcnv2HsGbWXUnUr78aLCxnrKP9Kg
iCB0bZ7jk0p4Ev2K5FNYF2NLv5h+ZtP6Hcag6Ca048tkrGrY31bZ9FZxQGHBgiTi
JODwJnmmuWa7lKPWF5qDICGClYHx1foDXH8Uqybc235YYmlV5NzWWZBB+OpOxddT
f2Cea0GmrYZ/2ok9dDVYuzcNCJPUtTudl5RLHtl7UHPZZVnJEXeAUlAisZnXpeGV
BhEtXZGmp3s1Yc5mnthwZPhiMcLGWSM4oKwDJ8v0wFI6gTw4EgyTnib6elq2/w28
2yV3uvdf3UKz/e0u3lBK
=mNFV
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
