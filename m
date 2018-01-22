Received: from eggs.gnu.org ([2001:4830:134:3::10]:32922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ediq3-0007EY-Np
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ediq2-0007ha-Ra
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:37:07 -0500
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
	<20180112090122.1702-2-klim.kireev@virtuozzo.com>
	<a562774e-a8d8-d864-c639-6edb6f58df4a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b387283-6203-ebae-0631-2f6f6ff2fe0a@redhat.com>
Date: Mon, 22 Jan 2018 14:36:55 -0600
MIME-Version: 1.0
In-Reply-To: <a562774e-a8d8-d864-c639-6edb6f58df4a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ci8J3dzrqyUN65Hz8Hrv6vfEVwT1qXs29"
Subject: Re: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, qemu-block@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ci8J3dzrqyUN65Hz8Hrv6vfEVwT1qXs29
From: Eric Blake <eblake@redhat.com>
To: Klim Kireev <klim.kireev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, qemu-block@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Message-ID: <1b387283-6203-ebae-0631-2f6f6ff2fe0a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
 <20180112090122.1702-2-klim.kireev@virtuozzo.com>
 <a562774e-a8d8-d864-c639-6edb6f58df4a@redhat.com>
In-Reply-To: <a562774e-a8d8-d864-c639-6edb6f58df4a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 02:32 PM, Eric Blake wrote:
> On 01/12/2018 03:01 AM, Klim Kireev wrote:
>> This patch adds main information about Parallels Disk
>> format, which consists of DiskDescriptor.xml and other files.
>>
>> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  docs/interop/prl-xml.txt | 158 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 158 insertions(+)
>>  create mode 100644 docs/interop/prl-xml.txt
>>
>> diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
>> new file mode 100644
>> index 0000000000..7031f8752c
>> --- /dev/null
>> +++ b/docs/interop/prl-xml.txt
>> @@ -0,0 +1,158 @@
>> +=3D License =3D
>> +
>> +Copyright (c) 2015-2017, Virtuozzo, Inc.
>=20
> Want to claim 2018 as well?

Oh, and I see that the pull request has already been sent, so these
cleanups can be a followup patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ci8J3dzrqyUN65Hz8Hrv6vfEVwT1qXs29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmS2cACgkQp6FrSiUn
Q2q7Awf/bFQF/z4itVqW8zQ4pwfct9UO167xu1lVkQFEgpTjItRS43UGxZW3fMO0
8ZDutRIE7YMwNj3MuEfHML/WkEU6MI6y+a9P3KcNFunPPnxpxgRo6tzVT60FsgnA
dskgcxIdvjyqYBtAlNaYB55KdGWjydGoeCDmqQbDZupnxDkL2TMvjOAlXburBkXR
9Ka0Y+uUSzjC9RjG8QhdzQLEyaO9By2ANJuSKdXa6/nqtPqaNVrQw1FMVh6FBv48
K5Ckjlkfdc49JNwN71Q4UByXb1hBub3fzsUAisKVOsBh1WTshSMq5M3hRHMagGDp
KHS6zOLl8oK9Irj7+jl0v/m5tNWPNw==
=cmcF
-----END PGP SIGNATURE-----

--Ci8J3dzrqyUN65Hz8Hrv6vfEVwT1qXs29--
