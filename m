Received: from eggs.gnu.org ([2001:4830:134:3::10]:45071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUeQ0-0004X0-HS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUePz-0002ht-4i
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:32:28 -0400
Received: from smtp1.ntua.gr ([147.102.222.183]:10348)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUePy-0002cm-N4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:32:27 -0400
Date: Mon, 10 Jul 2017 22:30:47 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170710193047.z2t6eww7nhckgg3z@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="un5miyfz4v3gquss"
Content-Disposition: inline
In-Reply-To: <1475246744-29302-16-git-send-email-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 15/21] qom: support non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, afaerber@suse.de, berrange@redhat.com


--un5miyfz4v3gquss
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is there a specific reason this patch wasn't finished? If I'm not wrong=20
using non-scalar properties with -object is still not possible, yet=20
would be a very useful feature for drivers with UserCreatable objects.

Archive link since this is an old patch:=20
https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08252.html

--un5miyfz4v3gquss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllj1ecACgkQc2J8L2kN
9xDiGw/9HrL8l00hfTpuC/t0n9V9qVOqBUCd/Bq4Iu6LOfXyshlFDC+ia/ohZbMS
eC5JcfpwTB7t9Z0RVCEKLxG3HfcmnMPOcGDTzaTBGz443E8aSzQ0aoYKNnku3f8r
DT6hPJtMC60tV6NX6TlPnjdMjUWrjcmCXjQwfvZ+u+ITGytwZW/I4iSnkCtuOvXb
NMzLa+tE2Eo0cYHhBTE5dqE4LsKPgC9Q1RrP2n5mHhVIocs+ujR6ASvjUt40COcP
YonJCI+iA0REgAXDiDSksboUEYwjDSvhtLRFQLNuGQujHAtYClPGKYsy95OtJElm
xuEaB92weqbLmkQXe9rYUEpCniNOdCiVUdwOjBiauW59clyHVO1J0VDDM96RIZrm
Za871tOhkz6uTUkGh/yE5NttKWoBHMQs3fy+TeBGgwZOeA+9uDxP0HU2rzcLol2I
3a7/zORDbA8EJwpMXaTvmQTbmQehg7TkiZ8VjJWIusuCsKLtINm+slVwAOVMRDCA
Gl98fdkwsS/0wFSpY8F+t205eM4Y0YqHvHlg7+CYSKrWJmvQ744QNOOW+/mY/GQn
EUfTSRzNw1e+YZDPCLKn1OY4iG/+BLRt0UaMVK9i4Z+G7GHfHdDC3WOr5UBeKyj0
Ocnc60374n+hJaQWZU9IeIVMoC7iAkqfXL7tZ06pfZWUdZBIE0s=
=GSDy
-----END PGP SIGNATURE-----

--un5miyfz4v3gquss--
