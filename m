Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZxzE-0007G1-Fg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZxzB-0008E3-9P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZxzA-0008Dm-W6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:26:45 -0400
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
	<deb984a7-3d71-9db0-f3fb-eaf12c13064e@redhat.com>
	<CAB3eZft4kBbxfR1L080p7SF5X3XJk1Bmr3Y6uw6z9X4U44tOfA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7c8fa3a-a2fb-45f5-5220-528e389ecb5a@redhat.com>
Date: Tue, 25 Jul 2017 06:26:42 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZft4kBbxfR1L080p7SF5X3XJk1Bmr3Y6uw6z9X4U44tOfA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OefKm7eNEheD2kSkI9MR5gcmNwsIUPPU0"
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OefKm7eNEheD2kSkI9MR5gcmNwsIUPPU0
From: Eric Blake <eblake@redhat.com>
To: lampahome <pahome.chen@mirlab.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <a7c8fa3a-a2fb-45f5-5220-528e389ecb5a@redhat.com>
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
 <deb984a7-3d71-9db0-f3fb-eaf12c13064e@redhat.com>
 <CAB3eZft4kBbxfR1L080p7SF5X3XJk1Bmr3Y6uw6z9X4U44tOfA@mail.gmail.com>
In-Reply-To: <CAB3eZft4kBbxfR1L080p7SF5X3XJk1Bmr3Y6uw6z9X4U44tOfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 11:26 PM, lampahome wrote:
> I thought 2.9.0 is the latest and check to the wrong commit.

You're still top-posting, even after being told not to:
http://www.caliburn.nl/topposting.html

> Now it supports encryption.
>=20
> My cmd is:
>=20
>> qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>>              --image-opts
>> driver=3Dqcow2,file.filename=3Ddemo.qcow2,encrypt.format=3Dluks,encryp=
t.key-secret=3Dsec0

This says to open an existing already-encrypted image...

>=20
> But it shows error message:
>=20
>> No encryption in image header, but options specified format 'luks'

=2E..and this says your image was not already encrypted.

>=20
> Something wrong?
>=20
> My procedure is below:
> 1. create a clean demo.qcow2 image(no compression, no encryption)
> 2. use the cmd above to encrypt the demo.qcow2 image

Indeed, if you want an encrypted image, you must create it encrypted up
front (you can't do an in-place encryption after the fact).  qemu-img
convert is probably the easiest way to copy a non-encrypted image to a
newly-created encrypted image.

>=20
> 2017-07-24 20:25 GMT+08:00 Eric Blake <eblake@redhat.com>:
>=20
>> On 07/23/2017 08:49 PM, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
>>> I check to the newest version of qemu.
>>
>> You're still top-posting, which makes it really hard to answer your
>> questions.

Here's where I previously asked you to avoid top-posting.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OefKm7eNEheD2kSkI9MR5gcmNwsIUPPU0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3KvIACgkQp6FrSiUn
Q2pD0Af/Tlxdh0d7dfysizsDlujuDGuS3cLll1Hp50h7LasBy4rq+cKyGMmleoFs
Tgpw2paJpMoOojhM3QmCQho4kI3Tmto/2ihKAcf+3ytZN4cNmz2EC2LiNB92cUZJ
EYf1LGogbtWQ4JqeES90/4ipoqmJo3rNnk+Ev29p0x1qM6HJESDCqkRpnXhr0DfX
oJC1cqgUBm7R3y0Imu7ZJEaG96lQF1/nfy2GUH0Euv8z8umMbiIOTILKmqdGTtWK
by6D2TFWkFxH31Vey4jVfEejBIrxJ35q70z4a1zhdlsYuPkv2JcYZTb45+3BJdpX
tk2H5vGB+UpIa4SfPdpf5OUMzardgQ==
=7hMV
-----END PGP SIGNATURE-----

--OefKm7eNEheD2kSkI9MR5gcmNwsIUPPU0--
