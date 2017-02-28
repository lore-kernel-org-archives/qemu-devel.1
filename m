Received: from eggs.gnu.org ([2001:4830:134:3::10]:52235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cicFq-0006O0-Ik
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cicFn-00079d-Fg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:31:26 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:39555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cicFn-000794-8o
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:31:23 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 96BF7A9191
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 08:31:21 +0100 (CET)
Date: Tue, 28 Feb 2017 08:31:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170228083118.799a4356@bahia.lan>
In-Reply-To: <7945b8f4-8bcb-f9c7-cbc8-a4c0e0596e22@msgid.tls.msk.ru>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
	<20170228013721.242076f0@bahia.lan>
	<7945b8f4-8bcb-f9c7-cbc8-a4c0e0596e22@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oQOd65FeHrt2U3wcKfHA5g9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 00/31] 9p patches 2017-02-27 for 2.9 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org

--Sig_/oQOd65FeHrt2U3wcKfHA5g9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2017 08:58:55 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> Greg, can you please send a separate pull request
> just for the symlink attack issue, so it can be
> easily picked up by downstreams if needed?
>=20

It makes sense indeed. I'll do that.

Cheers.

--
Greg

> Thanks,
>=20
> /mjt


--Sig_/oQOd65FeHrt2U3wcKfHA5g9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli1J0YACgkQAvw66wEB28IpqgCeIKDY8N/BSGpLzDjqsVUL6OTI
rbYAoJhreYGw+w6VyHiIvbliQUt/tDa8
=/2vb
-----END PGP SIGNATURE-----

--Sig_/oQOd65FeHrt2U3wcKfHA5g9--
