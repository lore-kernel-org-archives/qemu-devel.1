Received: from eggs.gnu.org ([2001:4830:134:3::10]:46066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpEko-0008C3-8N
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpEke-0001WX-Jl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:23:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpEke-0001Ve-C8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:22:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B469C014182
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 14:22:51 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-3-eblake@redhat.com>
	<09983e6e-9506-ca02-a8ce-b1a1773d793c@redhat.com>
	<874lshzd2l.fsf@dusky.pond.sub.org> <20170905101003.GD311@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <658b73e4-86fd-e272-4032-b999c5f2a859@redhat.com>
Date: Tue, 5 Sep 2017 09:22:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170905101003.GD311@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ANlpHG4AGr4lOq7MN27JaUSv0HraXwllM"
Subject: Re: [Qemu-devel] [PATCH v6 02/29] tests: Sort .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ANlpHG4AGr4lOq7MN27JaUSv0HraXwllM
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Message-ID: <658b73e4-86fd-e272-4032-b999c5f2a859@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/29] tests: Sort .gitignore
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-3-eblake@redhat.com>
 <09983e6e-9506-ca02-a8ce-b1a1773d793c@redhat.com>
 <874lshzd2l.fsf@dusky.pond.sub.org> <20170905101003.GD311@redhat.com>
In-Reply-To: <20170905101003.GD311@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 05:10 AM, Daniel P. Berrange wrote:

> Fairly even split between 'test' as a prefix vs suffix. 'check' as a
> prefix should clearly be killed as a minority pattern. Any appetite
> for standardizing naming of everything else ?
>=20
> A further idea might be to actually have separate sub-directories for
> unit tests vs qtests. eg go for
>=20
>   tests
>     +- unit
>     +- qtest
>     +- iotests

I like the idea, but don't know if I want to be the one tackling it...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ANlpHG4AGr4lOq7MN27JaUSv0HraXwllM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmuszEACgkQp6FrSiUn
Q2pvxwgAifOSukUoaKvqC+Fp4ErIaEBD3BZSLiN9+iq51BP3/VqLfBQpfDGIMloW
E3jJ1erNsTM2u77bKYkIHRcbLSEkfh5Qxos3arsrXOKaJ3j3SdPoejO6BN9lWREq
6jvkzQ/ppDrNR3VJHrsA8p0WMPqHMGBDAeQhkFXhXe5f3ZJZDRdMHS4ZhOlCp1Ba
AMMKB8YxyWjsLoZrKQwuC4BIQj+7RZgEH/5jrLPbKbWtrioUsvdFMQrR8WdftQ8p
WoXxylockk2I5DzsqzDZmg3Jj+BxWtnWWtrxu70oZBh+En1Q+L8EmLi2VZrUL75s
GCJd6ap6IdRWCpo4O/6PlEykqX31/Q==
=hsRy
-----END PGP SIGNATURE-----

--ANlpHG4AGr4lOq7MN27JaUSv0HraXwllM--
