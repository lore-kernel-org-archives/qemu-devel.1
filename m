Received: from eggs.gnu.org ([2001:4830:134:3::10]:40255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFiur-0002R4-Jm
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFiuo-000153-Gg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFiuo-00013J-7S
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:18:34 -0400
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-15-marcandre.lureau@redhat.com>
	<436727fa-d35c-cfa9-52b3-f59e58a92bb7@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a17ac0d-fd7f-8c50-4682-72ef205d80db@redhat.com>
Date: Tue, 30 May 2017 10:18:28 -0500
MIME-Version: 1.0
In-Reply-To: <436727fa-d35c-cfa9-52b3-f59e58a92bb7@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j6DXUQlRB96PoBOfhNnK5J0t8LIHKwS9k"
Subject: Re: [Qemu-devel] [PATCH v2 14/14] char: move char devices to
 chardev/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j6DXUQlRB96PoBOfhNnK5J0t8LIHKwS9k
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <9a17ac0d-fd7f-8c50-4682-72ef205d80db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/14] char: move char devices to chardev/
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
 <20170529084546.26500-15-marcandre.lureau@redhat.com>
 <436727fa-d35c-cfa9-52b3-f59e58a92bb7@amsat.org>
In-Reply-To: <436727fa-d35c-cfa9-52b3-f59e58a92bb7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/29/2017 04:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/29/2017 05:45 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Suggested by Paolo Bonizini during series review.
>=20
> Bonzini ;) "serie" singular

No, "serie" is not a word.  "series" is one of those weird English words
that is both singular and plural (another such word is "sheep").

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j6DXUQlRB96PoBOfhNnK5J0t8LIHKwS9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLY1EAAoJEKeha0olJ0NqVSQIAK5cjs836SyKXq8H6d3MTRM4
i4uIg61EBWCf/DMuvgm6s68hht92c7+cEH057JvKi1WlLqomotUTlEcVpHgn0y57
k6EEcMoOaPnBqAsV6jWyCKKku3Qf2IqCQpZMLTmJdBHvnBpj2g9y1uqnMAMwV+uC
b2+Rcnrm78lwp7nNfoXivRkn5DBiOQkOwXIQPCrzPhovjpOpGfTGaMcKdiT8DnMz
gTVXg3u69kFK0MzKKSjS3YBvg7qzQjkrLxFNvOttvvBawO4F1lz3iCC+xlvBNJu2
hd5gBqq22fbLadzNBtI9FVUds0ZPDfIkXgNs3ynQqtAXYJD0whN4BSL3RPI/OY8=
=UImd
-----END PGP SIGNATURE-----

--j6DXUQlRB96PoBOfhNnK5J0t8LIHKwS9k--
