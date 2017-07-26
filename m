Received: from eggs.gnu.org ([2001:4830:134:3::10]:59604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKE4-0001Zs-Ba
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKE0-0002Es-5U
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:11:36 -0400
References: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
Date: Wed, 26 Jul 2017 13:11:21 +0200
MIME-Version: 1.0
In-Reply-To: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hQSPQfOgwq21frGk8m9p4iNxn1MxIUBgj"
Subject: Re: [Qemu-devel] RFC: unified --help information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hQSPQfOgwq21frGk8m9p4iNxn1MxIUBgj
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>
Message-ID: <507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
Subject: Re: RFC: unified --help information
References: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
In-Reply-To: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/07/2017 12:53, Eric Blake wrote:
>=20
> GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
> Full documentation at: <http://www.gnu.org/software/coreutils/ls>
> or available locally via: info '(coreutils) ls invocation'
>=20
> or 'm4 --help | tail -n3':
> Report bugs to: bug-m4@gnu.org
> GNU M4 home page: <http://www.gnu.org/software/m4/>
> General help using GNU software: <http://www.gnu.org/gethelp/>
>=20
> In our executables, we are rather inconsistent with --help
>=20
> qemu-nbd mentions: Report bugs to <qemu-devel@nongnu.org>
> qemu-ga mentions: Report bugs to <mdroth@linux.vnet.ibm.com>
>=20
> while qemu-system-*, qemu-img, and qemu-io mention nothing at all.  Is
> it worth unifying these to all mention qemu-devel@nongnu.org as the
> primary bug-report site, and/or to add mention of <http://qemu.org> as =
a
> site for further information?

I think we should point to a more specific bugreport URL.

Currently it's http://wiki.qemu.org/Contribute/ReportABug.  If we want
an URL on qemu.org, we can either add a redirect from qemu.org to the
wiki, or move the contents to qemu.org (it's static enough that it
shouldn't be a big issue).  I've sent out a patch for the latter.

> Likewise, with --version, qemu-io and qemu-ga lack the git suffix
> present in qemu-system-* and just added in qemu-nbd.
>=20
> I can submit patches to make things consistent, and think it is 2.10
> material, but first want to get consensus on what the behavior should b=
e.

I agree it's better to be consistent.

Paolo


--hQSPQfOgwq21frGk8m9p4iNxn1MxIUBgj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAll4eNwACgkQv/vSX3jH
roMMogf9GED4NmvblB0tBkfbSd/iBodjDNLhmjIPCJ44yju5s6lPA/li0zogXxgF
XAR43OxOVHV/nbEJfLzf1dHyARUKIPetiPI1flk8ks4sBGSpr7hWycX6TcpfcwLX
DtwMqRHjExhmQZeaKDhrv1r0aXEmmk+DweG21RUKM9WF2a5hkQy0zcIJkRIXhTO5
Rtc3HkWeZ7RRC3/h/lTGdHlv6Rmd/IVSGZL5vxryekS3HbvLUQk7jgrFyGRqS+xZ
vN6HPVvG/FeKzvClt/aWF921Xb1l5tB4k1/FllQeXlxZtfihW5CMznfGBStVyWec
x3Iwwp26OmcQU4Z/MLBurki5myo/Kg==
=DINn
-----END PGP SIGNATURE-----

--hQSPQfOgwq21frGk8m9p4iNxn1MxIUBgj--
