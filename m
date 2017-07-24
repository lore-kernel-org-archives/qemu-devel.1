Received: from eggs.gnu.org ([2001:4830:134:3::10]:44429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZcQl-0002r8-CA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZcQg-0005Ry-Hl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZcQf-0005Qp-Vq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:25:42 -0400
References: <20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
	<CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
	<20170721093433.GG17693@redhat.com>
	<CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
	<9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
	<18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
	<20170721140631.GS17693@redhat.com>
	<81f2f144-896a-d16e-83da-1fae313ccfff@redhat.com>
	<CAB3eZfsDUpcYDLogUuz4H-X-petqnc4+hXwkXjO3v1jrRB=r2w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <deb984a7-3d71-9db0-f3fb-eaf12c13064e@redhat.com>
Date: Mon, 24 Jul 2017 07:25:39 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfsDUpcYDLogUuz4H-X-petqnc4+hXwkXjO3v1jrRB=r2w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RthWmEM48mGPw0QNn2w2hXDmWVKDipIFP"
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RthWmEM48mGPw0QNn2w2hXDmWVKDipIFP
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <deb984a7-3d71-9db0-f3fb-eaf12c13064e@redhat.com>
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
References: <20170720085958.GC21566@redhat.com>
 <CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
 <20170720091224.GD21566@redhat.com>
 <CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
 <20170721083816.GC17693@redhat.com>
 <CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
 <20170721093433.GG17693@redhat.com>
 <CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
 <9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
 <18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
 <20170721140631.GS17693@redhat.com>
 <81f2f144-896a-d16e-83da-1fae313ccfff@redhat.com>
 <CAB3eZfsDUpcYDLogUuz4H-X-petqnc4+hXwkXjO3v1jrRB=r2w@mail.gmail.com>
In-Reply-To: <CAB3eZfsDUpcYDLogUuz4H-X-petqnc4+hXwkXjO3v1jrRB=r2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2017 08:49 PM, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> I check to the newest version of qemu.

You're still top-posting, which makes it really hard to answer your
questions.

>=20
> and do the cmds to install followed by the documents in github:
>=20
>> mkdir build
>> cd build
>> ../configure
>> make
>=20
>=20
> and it show nothing errors=E2=80=8B
> It's the version when I enter qemu-img --help:
>=20
> and I execute encrypt format(luks) to the qcow2 file:
>=20
> =E2=80=8B

Attaching inline images is a horrible waste of bandwidth, compared to
copying-and-pasting the terminal text directly.  Furthermore, your email
is illegible in a plain-text client (like what I prefer to use), and
requires that I switch to html view to even understand what you are askin=
g.

> always shows the error, how to solve it?=E2=80=8B

Transcribing one of your images:

> pahome@pahome-QW09:~/git/qemu/build$ ./qemu-img --help
> qemu-img version 2.9.0 (v2.9.0-dirty)

You aren't building the latest version of qemu.git.  If you were, you'd
be getting something like this:

$ ./qemu-img --help | head -n1
qemu-img version 2.9.50 (v2.9.0-2519-gb52f59694d)

Before you can complain that something recently added isn't working, you
first have to make sure you are building the right version.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RthWmEM48mGPw0QNn2w2hXDmWVKDipIFP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll150MACgkQp6FrSiUn
Q2reEgf+KuNl7/0J0BU+XfqZv/JovWItu5vsQAAxE5P2AcNsgEU1DZ1c4tQtjVA1
OVfvTA1Tp0F103vxj2XiWtwTeBVklvr14cR2K6/wsq/8/mcrOfiXZUhNTrY0zhWo
dieKELmOZc0mBGQJfMqk9Ud47OPh4n/Ci3cbKhnacHpHh1EXhuRn5GUew0GOpGDb
6boq3yBxx917szXKu8Ibi7T1OhTw/djhP/g4+k2U4l6S0RjsqqpJskpHGoe5sW1P
a4PTkBR4yxuCZAakFLuA+7+aKgYUZ7L6b9WjHEmOSYEmTMBSM6vInfu2BlyOb5n3
X3FJwdiGuKK2DfHOgAvIkZ1u41k/6A==
=Ayqn
-----END PGP SIGNATURE-----

--RthWmEM48mGPw0QNn2w2hXDmWVKDipIFP--
