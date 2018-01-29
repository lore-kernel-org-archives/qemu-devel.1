Received: from eggs.gnu.org ([2001:4830:134:3::10]:46380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAaA-0002q7-KN
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAa7-0008GZ-DL
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egAa7-0008G8-4k
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:38:47 -0500
References: <20180129033133.31288-1-famz@redhat.com>
	<20180129110426.GA20446@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3a60e11-3ce4-effe-b87f-b0112e03eaec@redhat.com>
Date: Mon, 29 Jan 2018 08:38:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180129110426.GA20446@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nGCmFziagSnS0kfLWwi1lV9z8qVZsKcNv"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nGCmFziagSnS0kfLWwi1lV9z8qVZsKcNv
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, f4bug@amsat.org
Message-ID: <e3a60e11-3ce4-effe-b87f-b0112e03eaec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
References: <20180129033133.31288-1-famz@redhat.com>
 <20180129110426.GA20446@stefanha-x1.localdomain>
In-Reply-To: <20180129110426.GA20446@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/29/2018 05:04 AM, Stefan Hajnoczi wrote:
> On Mon, Jan 29, 2018 at 11:31:33AM +0800, Fam Zheng wrote:
>=20
> Thanks for writing this!
>=20
> I have only reviewed some parts in detail.
>=20

>> +
>> +On top of libqtest, a higher level library, ``libqos``, was created t=
o
>> +encapsulate common tasks of device drivers, such as memory management=
 and
>> +communicating with system buses or devices. Many virtual device tests=
 use
>=20
> s/buses/busses/

That's one of those stupid English words where both spellings are valid,
and which one you get is a matter of preference (I can't even call it a
US-vs.-UK issue).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nGCmFziagSnS0kfLWwi1lV9z8qVZsKcNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpvMeUACgkQp6FrSiUn
Q2rA6QgAhI4dHCjvHdwij7ypARrze01xVrHVXhIM7vgKTbuaKY8CMjJqy+Z+S5i2
0RPx8jbV03nsDagGfYf+GXMoR4Tog0dRxDvNavLj3ozuYRj+9Lb5CbdnSCmLcKx8
ZXBWH05XPD9YE5J5lKrkHw4m/1G2IkJbdlW5MsNICTyn/VaRKas7JGSL1NIqFutk
BHgWdSNussl/rt3f1L9CcYE+6Ewbqb/VxtVb+rrdy0hEeKR+OJpYwub+5BC4JXdh
xdJpQDSPejqfzWoLVtu+MYOH2ruDxu9rlC1SpCxYfpz0EZiPtZrUmwSyfPSilMQ1
TL+knaaD8v7oG/pDLVTHwFfzxkW20Q==
=tfC5
-----END PGP SIGNATURE-----

--nGCmFziagSnS0kfLWwi1lV9z8qVZsKcNv--
