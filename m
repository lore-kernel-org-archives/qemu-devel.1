Received: from eggs.gnu.org ([2001:4830:134:3::10]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSDl-0004yh-TY
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSDk-0003gq-Rd
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:44:29 -0400
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9660e99-df83-8c82-5c1a-eb792b60c692@redhat.com>
Date: Wed, 9 Aug 2017 09:44:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170809140256.25584-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="emsqM32fkTw02IpcAU0jkIaq2QtMQmNIg"
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--emsqM32fkTw02IpcAU0jkIaq2QtMQmNIg
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>
Message-ID: <f9660e99-df83-8c82-5c1a-eb792b60c692@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: remove legacy I/O throttling
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
In-Reply-To: <20170809140256.25584-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 09:02 AM, Manos Pitsidianakis wrote:
> This series depends on my other series 'add throttle block driver filte=
r'
> currently on v4.

More precisely, for patchew:
Based-on: <20170809100734.17540-1-el13635@mail.ntua.gr>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--emsqM32fkTw02IpcAU0jkIaq2QtMQmNIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLH7sACgkQp6FrSiUn
Q2qdgwf+L+OiIMBW61tfPGgVlcsjQ6OURy+ZL+zoowNpnDFDSBmNqENTSEJSlCx6
0BwgnocWh0QJUjmZseJe5U/V7eJnRsVfRn9kDn7XnxMzwI7MWOl+GDmrK5ZWs6hj
NwRjHVrdkWbnUF1ilxN6dXe3jM9vfQrMbDQCpXx3krNcR5IcuWv5Bm/qYw0AjLlI
IVp+/OUMoOKO0DLzkTWIG5btqwcMxIxyFceeRjHjoi/DYsmeQ4wXq/jDTfOzwYPs
GcRmYzYSTFQ2Gk/ecDsZCEtVwacjcnSwwVOakSSeGRQIg6yaZsMqQir3Vt/VRHL7
ouWDAnY3eievUXsF4SREvJuXBLzo8A==
=SC3s
-----END PGP SIGNATURE-----

--emsqM32fkTw02IpcAU0jkIaq2QtMQmNIg--
