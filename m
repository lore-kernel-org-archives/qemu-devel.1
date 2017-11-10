Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHdr-0008Vm-7z
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHdm-0007xL-KM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:19:15 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f762373d-b800-1146-d535-374d7175e0af@redhat.com>
Date: Fri, 10 Nov 2017 16:19:06 -0600
MIME-Version: 1.0
In-Reply-To: <20171110221329.24176-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D7jNGMSDNNe0ljTk45cm9XcMMvHKRqPRo"
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D7jNGMSDNNe0ljTk45cm9XcMMvHKRqPRo
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <f762373d-b800-1146-d535-374d7175e0af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-2-mreitz@redhat.com>
In-Reply-To: <20171110221329.24176-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 04:13 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qdict.h |  1 +
>  qobject/qdict.c          | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D7jNGMSDNNe0ljTk45cm9XcMMvHKRqPRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGJdoACgkQp6FrSiUn
Q2rsbQf/VZ84dl4Ix47R9MewBV23C00WYEwTSgS5+1jeG0s7xr/z5+VS1a+j0Eah
WY4kZp3BVK/JYi9fNGfValbjSGBVmBegj+lKwUcBZ+sSqrWawl6eQMqBwujitrzl
q2zKSiVi6Lgt54RNjG9EzcS1H/Gibufr88MdM/bTNVGdECU2G+a2SAuRVsD0Yjji
flq/dYfLbRHNgX5P4jMODOHZKMy4W0NQbzmmh7Ad/vA83pDeb8IhTINOuJR1/OP5
l1AsfOInzVL2Hy5yA2IQu7yrpQSTT2MsH/56C2tsm0m4f3Vg+wLwsSiIsBByGvT5
zp05Lfa/uK/mopUdZYFwF9avElbbgA==
=uuBh
-----END PGP SIGNATURE-----

--D7jNGMSDNNe0ljTk45cm9XcMMvHKRqPRo--
