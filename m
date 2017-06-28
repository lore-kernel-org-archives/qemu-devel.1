Received: from eggs.gnu.org ([2001:4830:134:3::10]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dQ4SZ-0003KH-IA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dQ4SU-0000Sq-Lj
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:20:11 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dQ4SU-0000QW-Dh
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:20:06 -0400
Received: by mail-pg0-x244.google.com with SMTP id j186so6665278pge.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 21:20:04 -0700 (PDT)
References: <20170614063607.47863-1-aik@ozlabs.ru>
	<20170614063607.47863-3-aik@ozlabs.ru>
	<653b598c-d838-ee69-5848-ae7ea85f5376@ozlabs.ru>
	<20170621072641.GB12089@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9a8d908e-f0da-5b60-f5a6-65a27159e3bb@ozlabs.ru>
Date: Wed, 28 Jun 2017 14:19:57 +1000
MIME-Version: 1.0
In-Reply-To: <20170621072641.GB12089@umbus>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4xjqpp8wW9X6SSn2Nwj8j9e62do4wRJ0d"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4xjqpp8wW9X6SSn2Nwj8j9e62do4wRJ0d
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>
Message-ID: <9a8d908e-f0da-5b60-f5a6-65a27159e3bb@ozlabs.ru>
Subject: Re: [PATCH qemu v8 2/2] memory/iommu: introduce
 IOMMUMemoryRegionClass
References: <20170614063607.47863-1-aik@ozlabs.ru>
 <20170614063607.47863-3-aik@ozlabs.ru>
 <653b598c-d838-ee69-5848-ae7ea85f5376@ozlabs.ru>
 <20170621072641.GB12089@umbus>
In-Reply-To: <20170621072641.GB12089@umbus>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 21/06/17 17:26, David Gibson wrote:
> On Wed, Jun 21, 2017 at 12:05:08PM +1000, Alexey Kardashevskiy wrote:
>> On 14/06/17 16:36, Alexey Kardashevskiy wrote:
>>> This finishes QOM'fication of IOMMUMemoryRegion by introducing
>>> a IOMMUMemoryRegionClass. This also provides a fastpath analog for
>>> IOMMU_MEMORY_REGION_GET_CLASS().
>>
>>
>> Ping?
>=20
> Busy.. sick.. busy & sick..
>=20
> I'll get to it eventually.
>=20

Well, if would be nice to hear from anyone...


--=20
Alexey


--4xjqpp8wW9X6SSn2Nwj8j9e62do4wRJ0d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZUy5uDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5I6oP/2TO
oOBZdWgMskxmIPKOh8AOb8748nGExB2gzfRNyKHsbSZV+pTUHI/6zTEIzx+jyVtn
nod1Z0gdobSNH0lKH6cbFucagUk6sYIZ73nUNldJMhKnFI9ljhSz17PzwW0Z51pz
sOg14JaatG05m7LiLws7DzQjIE/BGjh+K8gPr1USam3x08KW9YIb+Vd15HNzotFc
dy5A93HIDhRxhfDuQ6J4wOVNa9q+wQG9rEAuCLMMh3Am9Tygh5+sBlbwu1HkM44V
yLlIVh+f76lSSHeBgqFMVIz52KxzS6AGVv9cJwCh079DkTRoAfsZtqLMVZ80w+v5
DARMFOQTXmAxzGo9YK8fB1Veg6PUiPqaQItiS636oKEiv/L5Is528sf7djGOl5Xj
hCQk5AGeYcECTlRYWo5mpq7Z8DWYQwU2En1s4B8bQzgpmX6t0J2HldRLeKMqad3q
oPiIZ3dM2IqxxkzGtvji1gyxLxPiXvjdbajLwUkBy3sWCnP06tk4IEvkPBnOt/Yv
MJ5sdOUiPBkm/k08KZuNcOlEb2+2fvxD8zPwhwiimxrQCBcSgV/fFZrcpGPQouRx
V/A8Z9pFTbWw8JLUf8HtdMRA/clcQF15H7ORvQno/ptr5fu8fvDD7P3lVkOvcUMh
KCjzWfKjPVT9++QfXy+xDJjQgKQyTNKRKTr2BbKD
=ux1o
-----END PGP SIGNATURE-----

--4xjqpp8wW9X6SSn2Nwj8j9e62do4wRJ0d--
