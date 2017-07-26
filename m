Received: from eggs.gnu.org ([2001:4830:134:3::10]:46803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKcp-00039P-BD
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKcl-0001wv-99
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daKcl-0001wY-03
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01E8CC0467C4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:37:06 +0000 (UTC)
References: <20170726111049.18030-1-pbonzini@redhat.com>
	<759fddfb-8b23-db01-40c8-c4ab2d1756e6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53d6e223-f5e0-8a31-4b1b-02e912a07d6e@redhat.com>
Date: Wed, 26 Jul 2017 06:37:03 -0500
MIME-Version: 1.0
In-Reply-To: <759fddfb-8b23-db01-40c8-c4ab2d1756e6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XqhPpGHUaQcgVo34QgojWdjHQP3jFL1Ks"
Subject: Re: [Qemu-devel] [qemu-web PATCH] move bug reporting instructions
 from wiki to www
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XqhPpGHUaQcgVo34QgojWdjHQP3jFL1Ks
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <53d6e223-f5e0-8a31-4b1b-02e912a07d6e@redhat.com>
Subject: Re: [qemu-web PATCH] move bug reporting instructions from wiki to www
References: <20170726111049.18030-1-pbonzini@redhat.com>
 <759fddfb-8b23-db01-40c8-c4ab2d1756e6@redhat.com>
In-Reply-To: <759fddfb-8b23-db01-40c8-c4ab2d1756e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:32 AM, Thomas Huth wrote:
> On 26.07.2017 13:10, Paolo Bonzini wrote:
>> The bug reporting instructions are pretty static, and it is nicer if b=
ug
>> reporters stay within the familiar QEMU web site layout.  Move the pag=
e
>> to qemu.org.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---

>> +* Make sure you're reporting the bug against the [latest release](/do=
wnload/#source).  If possible, please try to reproduce with the latest de=
velopment tree too.
>=20
> Please add also (since it still happens way too often):
>=20
> * Please avoid to report bugs that you've found in the QEMU version

s/to report/reporting/

>   that ships with your Linux distribution. If you've got a problem with=

>   the QEMU from your Linux distribution, use the bug tracker from your
>   distro instead.
>=20

All of your suggestions look like useful additions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XqhPpGHUaQcgVo34QgojWdjHQP3jFL1Ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4fuAACgkQp6FrSiUn
Q2qLaAf+IUG0dfZrRnlEUaOJvZrR6ODMCDQEocbHdpiuIjqoaVMPvdRfudJ8wv2s
W1S5Q3Ihs2AKqrbEPVU9XAt2Bxpe5rN0fSdcKUUf7BTWIOU1lhrWaCAUdhsLnFW7
7u3qIJ6SukpH9DE1OGIWEQk194F0RutJ2pNw7W5XcfuEZ1x+q/02OEIycH5xJ1hP
V+HNZaEyf8I7wBtt3plN9TTKKOiLUDMidWCOQH+XMxNxOio2GUjcFk+xfZ5Lo1jD
UNiuViphz9fBMoTLioTKakw4Cdc6JfP3sYYBstcLsYzbaTGzHpV1CdxXruWVWBMy
tnQLrnbwnK4sobA9YCUQLGa2LrL2qg==
=XpV6
-----END PGP SIGNATURE-----

--XqhPpGHUaQcgVo34QgojWdjHQP3jFL1Ks--
