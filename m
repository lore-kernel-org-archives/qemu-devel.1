Received: from eggs.gnu.org ([2001:4830:134:3::10]:54431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89ZB-0002eI-9f
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89Z8-0004DM-1K
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:08:57 -0400
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
	<20170508173031.GK22428@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec4c60eb-2c7d-6d5d-6a5e-2aef6883878a@redhat.com>
Date: Tue, 9 May 2017 13:08:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170508173031.GK22428@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lrn3JdvMjexatrauoL31tM7XRr147IrXb"
Subject: Re: [Qemu-devel] [PULL 00/23] Trivial patches for 2017-05-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lrn3JdvMjexatrauoL31tM7XRr147IrXb
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Message-ID: <ec4c60eb-2c7d-6d5d-6a5e-2aef6883878a@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/23] Trivial patches for 2017-05-07
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
 <20170508173031.GK22428@stefanha-x1.localdomain>
In-Reply-To: <20170508173031.GK22428@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 12:30 PM, Stefan Hajnoczi wrote:
> On Sun, May 07, 2017 at 10:02:03AM +0300, Michael Tokarev wrote:
>> The following changes since commit 12a95f320a36ef66f724a49bb05e4fb553a=
c5dbe:
>>
>>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging =
(2017-05-04 13:44:32 +0100)
>>
>> are available in the git repository at:
>>
>>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>>
>> for you to fetch changes up to 311875781e549af91a3216d34c6ef40420bab43=
5:
>>
>>   tests: Remove redundant assignment (2017-05-07 09:57:51 +0300)
>>
>> ----------------------------------------------------------------
>> trivial patches for 2017-05-07
>>

>> sochin.jiang fix wrong parameter comments in channel-file.h (1):
>>       channel-file: fix wrong parameter comments

See my question on 11/23

>=20
> Thanks, applied to my staging tree:
> https://github.com/stefanha/qemu/commits/staging

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Lrn3JdvMjexatrauoL31tM7XRr147IrXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEgWyAAoJEKeha0olJ0Nqk+MH/2mFYCXfDurHRon3C3SGpef9
uGgGE4HHYOCOkgiScFondStJZA/hWzHbnf0AGgEpfFuyOHANsSj+ZtkKIXsD3gkf
jhtGEYMViZVzCXIPtsXtEoWUaTrjT6lJ3lRtpLcayl91+oNw9qdGMcLY+rce0L0b
FaqQpWcYaqg6awcXiReWb+AlxpAqpASEVVruH53kI6pZQYemFntqbEsD8wqhBMl3
IUlEl64i+p3Xf+JiPxHZCsX5abZLAx+XEfD7Flxi/UUZNsCw093ynJqXuZW7gGSU
Y3XiJD+Axs/SovHpUs37bmK4ZjYpEsmCeF3b5MeoIaO3PL1kOpzwaqUxSQjNh/E=
=rrd4
-----END PGP SIGNATURE-----

--Lrn3JdvMjexatrauoL31tM7XRr147IrXb--
