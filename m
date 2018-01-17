Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebtfC-0003Dt-3V
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebtfB-0008CR-4s
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:46:22 -0500
References: <20180117165420.15946-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8893e453-81d0-f853-009a-7015c53faa34@redhat.com>
Date: Wed, 17 Jan 2018 20:46:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180117165420.15946-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zUKJMRi5THF4ml0pLKJQAKgqU4ZqQhllm"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests compat=0.10 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zUKJMRi5THF4ml0pLKJQAKgqU4ZqQhllm
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
Message-ID: <8893e453-81d0-f853-009a-7015c53faa34@redhat.com>
Subject: Re: [PATCH 0/2] iotests compat=0.10 fixes
References: <20180117165420.15946-1-eblake@redhat.com>
In-Reply-To: <20180117165420.15946-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-17 17:54, Eric Blake wrote:
> As requested here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03984.html
>=20
> Eric Blake (1):
>   iotests: Split 177 into two parts for compat=3D0.10
>=20
> Max Reitz (1):
>   iotests: Disable some tests for compat=3D0.10

Thanks!  Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--zUKJMRi5THF4ml0pLKJQAKgqU4ZqQhllm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpfp/gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6fQH/iqxjerDQsSEfJ5Yejt/1HkLxvqIm1T8
pZHhoXUvWgjtJ5FJ25h+D/ERzZxRGTHbePzrC4HI1ge/wJx51eiZLLMfOJA3/yVF
MNb/Tm2yuTLsVBXizkgluFEFRUwB7y8axW86kG0UtCre5Ctr0Jhpd7/nj7TuUcM3
wA2g13vsL77gMIVa9R+EBkrtSYQMaRgUbcDGoSen2JC/woMwcsiUodL4WkGjePh/
ksN1JfEM6R41HYXLMbFmc6JGHaU9PiHZtNRA1gVg7RjVjSiZw3nLA0tg5Kc+Oc+l
OYaK49fTO7xiBpn2Sh2T6c+h6gaVKf59qyPQ5b512GcjFvqf3mMO/fw=
=nbjn
-----END PGP SIGNATURE-----

--zUKJMRi5THF4ml0pLKJQAKgqU4ZqQhllm--
