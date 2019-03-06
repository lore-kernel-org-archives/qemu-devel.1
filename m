Received: from eggs.gnu.org ([209.51.188.92]:54199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Ti0-00083W-F0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Thy-0007Ov-IR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:23:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:59207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1Thw-0007MN-D7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:23:30 -0500
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-2-stefanha@redhat.com>
	<20190214072629.GA18896@richard>
	<20190214081619.GB7652@stefanha-x1.localdomain>
	<20190301114006.043e20cc@redhat.com>
	<20190301164728.GE18260@stefanha-x1.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <478131e4-f22d-78fc-fce0-b1e2f2fc3b13@vivier.eu>
Date: Wed, 6 Mar 2019 11:23:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190301164728.GE18260@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VCPqWwTmU1M2Iwq8UXF62wpR0qUtxoih0"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VCPqWwTmU1M2Iwq8UXF62wpR0qUtxoih0
From: Laurent Vivier <laurent@vivier.eu>
To: Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <478131e4-f22d-78fc-fce0-b1e2f2fc3b13@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
References: <20190214031004.32522-1-stefanha@redhat.com>
 <20190214031004.32522-2-stefanha@redhat.com> <20190214072629.GA18896@richard>
 <20190214081619.GB7652@stefanha-x1.localdomain>
 <20190301114006.043e20cc@redhat.com>
 <20190301164728.GE18260@stefanha-x1.localdomain>
In-Reply-To: <20190301164728.GE18260@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2019 17:47, Stefan Hajnoczi wrote:
> On Fri, Mar 01, 2019 at 11:40:06AM +0100, Igor Mammedov wrote:
>> On Thu, 14 Feb 2019 16:16:19 +0800
>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>>> On Thu, Feb 14, 2019 at 03:26:29PM +0800, Wei Yang wrote:
>>>> Maybe change the title=20
>>>>
>>>>    s/hotmem/hostmem-file/
>>>>
>>>> would be more proper.
>>>>
>>>> I missed this in previous review. =20
>>>
>>> You're right.  This can be fixed when merging the patch.
>>>
>>> Stefan
>>
>> Did this patch fall through cracks?
>=20
> Eduardo has been away.  It wasn't urgent but I'd be happy if either you=

> or Eduardo picks up these patches.
>=20
> Thanks,
> Stefan
>=20

On Igor request, applied to my trivial-patches branch.

Thanks,
Laurent


--VCPqWwTmU1M2Iwq8UXF62wpR0qUtxoih0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlx/n5EACgkQ8ww4vT8v
vjxMeg/+Il+jsBCLANjPaUd0dSXkT5cHmPYUuWoiKYYa8ExE5ks23BzebASosxob
1zUFZkHFSjsjsBs8e/TLLE8w0nZqsmG0MXhe+iJDSOvXGMCsMXTdkBHr8UDU9Oz2
/7teg1FzOp0/56VGCFB2T0lExsJ7XeEhSOrTbH0IYA8IjElYugY0QBIvJ6s8VRMh
OWOR4Pj8GkhTnvNoe7OgsCE4Pt6631cvb73IWITaDcj07BUDSBQ/Bo5PvPE3Zjw5
Gt2eDpNupfc6MBeehUbvOoRv8cAZZrDtHgy/ewYBoxCIjnXs3PPZhtk3swzEPiv3
+1pEKjwi1haj1Zk2Xt1eKDw5qbVrsJdKvCZgD3blR5+c5iP8nD6yEfA2zwpQsWVs
ovPa2vfcHxd6ZTokVWnuY9rhhrKtYudS/RDkftybGD7wqpfapc+Z0NIwLP1/WEG+
v3mk5OfYmxGWxlTIUc9c9qaY6r+H0ik5q+5PDNobNL1hTD4WYqJhV8xLWO8SrvhH
2+474qh2n/wjFAe2t9dFFlK0qvaIB+fDbxNu/yRjgcEsblABd6Nyc61La/jOVHkq
aToOf4ART8NPY8znt7Qd69fo1ZSWQIkg3K3TLbmXH8lc9RlLvTz2f5mPCUgrdYbx
CfAEdKJ99bovMh4s16XQads5kKYeYX6vFW8lxfMdv7zyYJZXlYA=
=h9hU
-----END PGP SIGNATURE-----

--VCPqWwTmU1M2Iwq8UXF62wpR0qUtxoih0--
