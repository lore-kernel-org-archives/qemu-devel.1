Received: from eggs.gnu.org ([2001:4830:134:3::10]:55867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9iP-0001MO-Od
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9iL-0003P7-RB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dc9iL-0003OS-IU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72E12C044DA0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:22:24 +0000 (UTC)
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-4-eblake@redhat.com>
	<87y3r8jtu5.fsf@dusky.pond.sub.org>
	<fed09f84-2112-73e2-5541-603a77fe746d@redhat.com>
	<87wp6p9fws.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63e68e8d-495a-f53b-8601-803575f47ee4@redhat.com>
Date: Mon, 31 Jul 2017 07:22:21 -0500
MIME-Version: 1.0
In-Reply-To: <87wp6p9fws.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IRbn3xS7bokWKA8lurKR1AX5cMSfmoJp9"
Subject: Re: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling
 conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IRbn3xS7bokWKA8lurKR1AX5cMSfmoJp9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <63e68e8d-495a-f53b-8601-803575f47ee4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling conventions
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-4-eblake@redhat.com> <87y3r8jtu5.fsf@dusky.pond.sub.org>
 <fed09f84-2112-73e2-5541-603a77fe746d@redhat.com>
 <87wp6p9fws.fsf@dusky.pond.sub.org>
In-Reply-To: <87wp6p9fws.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 03:20 AM, Markus Armbruster wrote:
>>> It's not "worse", it's just different :)
>>>
>>> Suggest:
<snip>

>>
>> "Mikey likes it" (no idea if that pop culture reference from my
>> childhood has broader range than the US)
>=20
> 'fraid I'm out of range :)

It's not fair of me to leave you hanging.
https://en.wikipedia.org/wiki/Little_Mikey

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IRbn3xS7bokWKA8lurKR1AX5cMSfmoJp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/IP0ACgkQp6FrSiUn
Q2q6fAf/exMshIAzNRbq2CKkrwG+0t+quAQAc9zUSL5rQcUqeGZpIoIgO2/l3w9j
0V4tFAVBlIv8mZOn1Vn8ycCyKjL3bjh0oOocGtidlSBIjcT6fNQQXUJdn2o1V7pV
LfFHeRr29wR4Gtq15EDqzedWsyxgvJ0QDdpLqK5p7t1vlITLytdRvUKdFZXGXRl4
fS150toB7+tgB8aiPt0UmXQvQIXacS2/13wacbvj61psdBj38IiEI0pQc0jHfXgB
Xc4BWc9CkpvvwQ2XRjR4JzwZQKDFtWq1kQ0I8F/hgum5m30gWH3HN8JCn/PifZAw
AJ/R9YpMp9G1o0eDLRpGmGJ36yCWIw==
=GV2g
-----END PGP SIGNATURE-----

--IRbn3xS7bokWKA8lurKR1AX5cMSfmoJp9--
