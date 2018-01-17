Received: from eggs.gnu.org ([2001:4830:134:3::10]:35479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpEw-0001gY-I0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpEs-0001ih-Gy
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:02:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebpEs-0001fb-B7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:02:54 -0500
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
Date: Wed, 17 Jan 2018 09:02:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180117144756.31049-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="31Kd0WFcfCHKgf0AOEijXE3fxgkTYvUqe"
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31Kd0WFcfCHKgf0AOEijXE3fxgkTYvUqe
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180117144756.31049-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 08:47 AM, Marc-Andr=C3=A9 Lureau wrote:
> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7a=
da7c:
>=20
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' int=
o staging (2018-01-16 17:36:39 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>=20
> for you to fetch changes up to 48fb74965a8d8f2916da30d9c5b9945df25142af=
:
>=20
>   dump-guest-memory.py: fix python 2 support (2018-01-17 15:47:14 +0100=
)
>=20

The commit says it works with python 2.7, but we still require support
for python 2.6.  Is this pull request premature?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--31Kd0WFcfCHKgf0AOEijXE3fxgkTYvUqe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfZZIACgkQp6FrSiUn
Q2rOIgf/emKuTY+YqqpQ5IT72NlOVpQ6y6CHwwZD314+0vc0JxJk5pT6r5mShpep
q72+goHAE8BbsFJ31YBMPCWsdNuOoXfWYEP3QNNV+A0fGpgCvbTu+Qwd/ymNIAg/
0yWoeFOR5rpzx1OGib51Hq8ceUHP8wLWHryTWlFeUPTUjEDz9oVvULlFKsOk/r8F
uE+5LbESweWgMaqg7m5I80E32qBQGZ4UWv9np2W+0O9ew2w1HNgIXF6dfGtt/yWU
sSfpQz3SXaG5kv9xIlLSGFIo2a0a+F3FrcU43VXiXBNduE+XxucKA3caI0Vnux2a
vLE3dZndTvFDxQ1mqmQr3a5yQPJB4g==
=0ER+
-----END PGP SIGNATURE-----

--31Kd0WFcfCHKgf0AOEijXE3fxgkTYvUqe--
