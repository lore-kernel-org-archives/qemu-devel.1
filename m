Received: from eggs.gnu.org ([2001:4830:134:3::10]:49218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEGx3-0006Rb-JO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEGx0-000266-FB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:47:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eEGx0-00025w-7i
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:47:06 -0500
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ab8ee91-3297-216f-f03d-65d91c6bf098@redhat.com>
Date: Mon, 13 Nov 2017 09:46:28 -0600
MIME-Version: 1.0
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AGK95BNIUJmp9BCQAFr6Hsxksuq7ODESa"
Subject: Re: [Qemu-devel] [PATCH v3] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGK95BNIUJmp9BCQAFr6Hsxksuq7ODESa
From: Eric Blake <eblake@redhat.com>
To: Jindrich Makovicka <makovick@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Cole Robinson <crobinso@redhat.com>
Message-ID: <6ab8ee91-3297-216f-f03d-65d91c6bf098@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] SDL2 various fixes
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
 <20171112193032.9724-1-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/12/2017 01:30 PM, Jindrich Makovicka wrote:
> Hi,
>=20
> here is an identical patchset with Signed-off-by.

No need to resend v4 just for this comment, but in general, we like new
revisions of a patchset to be a new standalone top-level thread, rather
than buried in-reply-to an earlier revision.

More patch submission hints at:
https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AGK95BNIUJmp9BCQAFr6Hsxksuq7ODESa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJvlQACgkQp6FrSiUn
Q2ongQf/ZLvviiLwuWy2sRCeFH0apCC9xjgvB+cmBCjhy5Rpfa3E1NnYHZIlDcEH
FppUMAuqkJWskJIx3YOYela6LDXVQrF3BXWg0QizlxSo5qVDgD0XCFrVCfe/wTox
BgMCCG2sHmqsuBTz/eF3vHBdobEDUCL1FlPTvVFAQRYT/bUiZqdtvn/icr1+AGb0
1mbmvlCW9SVgApW7DJxFhfyt38dLik0b0cro7XJhEk5vQ1jqwc9qHbkiKom2o1BV
mAR7k4RwxkDUx6mTT1rU0NvoePde26sHw9XH7v8bK25ZOIreTQXbRiqaWT0DTIvp
pX/FUOSOVo3OSAMs+5hApD6sYEbNzQ==
=/ds8
-----END PGP SIGNATURE-----

--AGK95BNIUJmp9BCQAFr6Hsxksuq7ODESa--
