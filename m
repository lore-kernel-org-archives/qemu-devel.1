Received: from eggs.gnu.org ([2001:4830:134:3::10]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZvq-0007zm-24
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZvl-0006Cm-Sg
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dUZvl-0006CW-IS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:44:57 -0400
References: <20170710121434.5047-1-eblake@redhat.com>
	<CAFEAcA955Ddjp=TMLPdf2jSiCymNcrmbG9cZXg8HoUKogg3Rhw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63f50fe4-9f8b-5d34-dae9-11b35420fb63@redhat.com>
Date: Mon, 10 Jul 2017 09:44:55 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA955Ddjp=TMLPdf2jSiCymNcrmbG9cZXg8HoUKogg3Rhw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6tnB2xQ9bcOpR3ix4oS7LxuIlpndb6KpO"
Subject: Re: [Qemu-devel] [PULL 00/11] NBD patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6tnB2xQ9bcOpR3ix4oS7LxuIlpndb6KpO
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <63f50fe4-9f8b-5d34-dae9-11b35420fb63@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/11] NBD patches
References: <20170710121434.5047-1-eblake@redhat.com>
 <CAFEAcA955Ddjp=TMLPdf2jSiCymNcrmbG9cZXg8HoUKogg3Rhw@mail.gmail.com>
In-Reply-To: <CAFEAcA955Ddjp=TMLPdf2jSiCymNcrmbG9cZXg8HoUKogg3Rhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 09:24 AM, Peter Maydell wrote:
> On 10 July 2017 at 13:14, Eric Blake <eblake@redhat.com> wrote:
>> The following changes since commit 77d472291812cf04f97974dadbda767e59e=
31fde:
>>
>>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170707-=
tag' into staging (2017-07-10 10:29:11 +0100)
>>
>> are available in the git repository at:
>>
>>   ericb@repo.or.cz:/srv/git/qemu/ericb.git tags/pull-nbd-2017-07-10
>=20
> This doesn't look like a valid public-facing git repo URL...

Indeed not. It shows it's my first attempt. I'll repost in a moment,
once I fix my config.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6tnB2xQ9bcOpR3ix4oS7LxuIlpndb6KpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY5LnAAoJEKeha0olJ0NqVgoIAJSvC831dHVeaAHKMpshHXYf
hmH2Iim605792tuDaQotCoV4MZ/GJEu4Wl/99Ap3JiQWuVu/jd/L71xFCHCPkQuI
hVg3PT/Q18e8LQtVSdGyxEYrPzu+MeKrtt5rEo/6rnxUnYoa3a+iH+N5seZMSvJG
Bz5QS1jvYtj52U42YjGzpdUrSHPOHo05x4aUv/DG/1a/5GWmVa6C5/4+dgkuALN3
3A5pJB7B2Jki4ToHHzA0Va/wj8TbBToJNaBqA0dTICcLnrVid3vYKuhg/bWf7sL7
x7sV6ysKJ7jExwiYgbfZJyeZY5i6vor1MAxY/7EjR1MExyTyHfyrmPEWn2r/gno=
=FdHw
-----END PGP SIGNATURE-----

--6tnB2xQ9bcOpR3ix4oS7LxuIlpndb6KpO--
