Received: from eggs.gnu.org ([2001:4830:134:3::10]:41474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhKia-0000OW-4J
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 15:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhKiW-0002T4-W3
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 15:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhKiW-0002SV-MR
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 15:08:00 -0400
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
	<223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
	<20170814140003.GF8506@redhat.com>
	<EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
	<b4268987-e25d-02fc-3931-7b9576969cc5@redhat.com>
	<05CBF3D0-1FBE-4139-B968-9ED138206FFC@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36a10c9c-a074-7785-e09f-3372455fff34@redhat.com>
Date: Mon, 14 Aug 2017 14:07:55 -0500
MIME-Version: 1.0
In-Reply-To: <05CBF3D0-1FBE-4139-B968-9ED138206FFC@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pH7jmiGcaod2teFA6K2FlE80GRj8WRmVl"
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pH7jmiGcaod2teFA6K2FlE80GRj8WRmVl
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <36a10c9c-a074-7785-e09f-3372455fff34@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
 <223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
 <20170814140003.GF8506@redhat.com>
 <EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
 <b4268987-e25d-02fc-3931-7b9576969cc5@redhat.com>
 <05CBF3D0-1FBE-4139-B968-9ED138206FFC@gmail.com>
In-Reply-To: <05CBF3D0-1FBE-4139-B968-9ED138206FFC@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2017 01:49 PM, Programmingkid wrote:
>=20
>> On Aug 14, 2017, at 2:20 PM, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 08/14/2017 12:20 PM, Programmingkid wrote:
>>>> These are based against git master, just save the series and then 'g=
it am'
>>>> the lot in one go.
>>>

>=20
> Thank you for the information. Can this be down when receiving emails a=
s a digest,

Presumably yes, and probably more likely if you selected MIME digests
(rather than plain text) on the list subscription page:
https://lists.gnu.org/mailman/options/qemu-devel

However, I personally don't use digest mail, so I can't really say what
git would do in that situation. You may get better answers by asking on
freenode's #git IRC channel (as there are more git experts there that
can quickly tell you what git can do).

If nothing else, you can always use:
https://lists.gnu.org/archive/html/qemu-devel/
to get at mbox formatted files for all patches within the entire month,
and use 'git am -i' to pick and choose which ones you want (may be
tedious if you can't figure out how to prune it, first).

(In situations like this, if you can't figure out how to make your
mailer properly save mbox-formatted mails for easy feeding to git, you
may want to reconsider whether you are using the best mailer on your end
- I know many developers on this list use mutt or thunderbird, but when
you start to get to other mail programs, you'll get better answers on a
git forum than you will here.  It doesn't help that your current choice
of mailer has a propensity to botch mail threading, by posting your
replies as top-level threads rather than in-reply-to the message you are
following up on)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pH7jmiGcaod2teFA6K2FlE80GRj8WRmVl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmR9QsACgkQp6FrSiUn
Q2qYvgf/cf8irLahvEF1vNjVV4zmKgflwKvfcG0uiCBBW5zM5pA+3xSUGapgG/8w
QfaWEhR1vxs3DZ/0ZMkcco5JT5PMGJMxfxtZ2i0gjttUz8rdQQNmvtA+S1uUSrv+
6eYoaLMEP8r6KjVTMgrQLRWcYw1QtlfmdGewoMgi7AhjRmyMHuusXzqPgjkMtGPA
4ZeXoN6P/93e82ldlLNeaxuhWKg87aJc5EGFLwLfnBphKe0spXk5dS3ozvv3GprQ
3OK9C7sySpG2/KDzhj0el37xbzSszgwCnFukho86uWDI5EjypoEGEf+j0MMDwrBo
anBAtdw/PyFz3rL0XJndaNDVJnN0Cg==
=yCZ6
-----END PGP SIGNATURE-----

--pH7jmiGcaod2teFA6K2FlE80GRj8WRmVl--
