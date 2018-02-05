Received: from eggs.gnu.org ([2001:4830:134:3::10]:33790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eiixi-0006JB-Oi
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eiixe-00030Z-4U
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:45:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eiixd-0002yl-Pe
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:45:38 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-3-armbru@redhat.com>
	<CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab5c18b5-b42a-23f6-f893-3de0e64c1c7e@redhat.com>
Date: Mon, 5 Feb 2018 09:45:34 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q6LaZddU8oTlIswiR6rIqtD5voWAxiq93"
Subject: Re: [Qemu-devel] [PATCH RFC 02/21] qapi: Generate up-to-date
 copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q6LaZddU8oTlIswiR6rIqtD5voWAxiq93
From: Eric Blake <eblake@redhat.com>
To: Marc-Andre Lureau <mlureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 marcandre <marcandre.lureau@redhat.com>, mdroth@linux.vnet.ibm.com
Message-ID: <ab5c18b5-b42a-23f6-f893-3de0e64c1c7e@redhat.com>
Subject: Re: [PATCH RFC 02/21] qapi: Generate up-to-date copyright notice
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-3-armbru@redhat.com>
 <CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
In-Reply-To: <CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 07:44 AM, Marc-Andre Lureau wrote:
> Hi
>=20
> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> w=
rote:
>> Each generator carries a copyright notice for the generator itself,
>> and another one for the files it generates.  Only the former have been=

>> updated along the way, the latter have not, and are all out of date.
>>
>> Fix by copying the generator's copyright notice to the generated files=

>> instead.
>=20
> That makes sense, but we loose the Author lines in the generated
> files. Not a big deal I guess, but worth to point out, no?

I don't see too much use for author lines as long as you have a 'this
file is generated' line; you can use git history to learn the authors of
the generator code.  But yeah, a commit message blurb can't hurt.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--q6LaZddU8oTlIswiR6rIqtD5voWAxiq93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp4fB4ACgkQp6FrSiUn
Q2pZjQf9G6SmnI0vioJhxStxMBoFHdTWV/bpz6jhZiDKshIbMZYaxFVnQ3AnUVZ8
27qMRL5EcyA0nL9RRLD/7zTlVvnv+Y9hArTWqsbWstYDlxUiFbmCxxlwv5OKYfQA
RfSvnQX9ko1ohFHC6D6nCasaW5UHqArnnGALvRu9/LlKr4kxEJPije7nBt0u2Bix
Ijm5nPkBIcqT7KB3sot812CDYSRzU92spfH9ceKT5um91UmYhf+QGYs4x3dZj1BF
5kHaISSk8sUebWsnzuyVdZtYGD9vfRaRZRLrh9qRcbbda2lLHQPl0cOQMv1w0OAt
IWS/GAjgEULZMK5+d+qUAbxxqhS/Xg==
=Ppd8
-----END PGP SIGNATURE-----

--q6LaZddU8oTlIswiR6rIqtD5voWAxiq93--
