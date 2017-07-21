Received: from eggs.gnu.org ([2001:4830:134:3::10]:57896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYlJ-0006Nr-87
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYlE-0006hi-Uy
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYYlE-0006gs-LH
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:18:32 -0400
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
From: Eric Blake <eblake@redhat.com>
Message-ID: <81f2f144-896a-d16e-83da-1fae313ccfff@redhat.com>
Date: Fri, 21 Jul 2017 09:18:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170721140631.GS17693@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5swPvef9471RWsfAi3Xc1Jnt9Id4cUwRI"
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5swPvef9471RWsfAi3Xc1Jnt9Id4cUwRI
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <81f2f144-896a-d16e-83da-1fae313ccfff@redhat.com>
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
In-Reply-To: <20170721140631.GS17693@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 09:06 AM, Daniel P. Berrange wrote:
>> Oops, looks like 'git send-email' doesn't know how to auto-cc
>> 'Reported-by:' tags.
>=20
> That's something that's bugged me too - someone should write a patch fo=
r
> git :-)

Attempted:
http://marc.info/?l=3Dgit&m=3D150064653516706&w=3D2

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5swPvef9471RWsfAi3Xc1Jnt9Id4cUwRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyDTUACgkQp6FrSiUn
Q2o0RQf/ftZfrd6JPHUdwdgvqDiylGMmeNlG2Q+fKL1RdEEbgOCBuZalpPtc7XRN
fjDJV/RLtcCNtDrPsbPU0ElUqdpOnbVjMqmNu3qLSl+XOUGFhrfVNdeFRHMzMKMm
thwFWzOrpfyN9wvnBD2ynEEWsy1RDKkMJGhZEIkPntD0xh4M1xil4L/ZyZe8pklZ
e/Ja1Jv21oQNfBkAq9O5k6bNk2YWYfSZpQgXc4+aOySyFgsBPzxy4GE/IAODgdQ1
/qx8AdUGgos7oEiVj0YRMCqQkdetvdFpk3x2z96aR+hjvFOpsUHLxU9r9eivLkG+
aePRV1GZEihcIj1JhKBciuw4F1as/A==
=ITX4
-----END PGP SIGNATURE-----

--5swPvef9471RWsfAi3Xc1Jnt9Id4cUwRI--
