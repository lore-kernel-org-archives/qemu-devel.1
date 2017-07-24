Received: from eggs.gnu.org ([2001:4830:134:3::10]:45812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZeQr-0002n7-CU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZeQq-0000Dk-Kh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:34:01 -0400
Date: Mon, 24 Jul 2017 16:33:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724143347.GH4630@noname.str.redhat.com>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.07.2017 um 16:28 hat Eric Blake geschrieben:
> On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
> > There is not much getting started documentation for qemu-iotests.  This
> > patch explains how to create a new test and covers the overall testing
> > approach.
> >=20
> > +2. Create the test file
> > +
> > +Copy an existing test (one that most closely resembles what you wish t=
o test)
> > +to the new test number:
> > +
> > +  cp 001 <test-number>
>=20
> And mark it executable (chmod a+x <test-number>)

If you copy an existing test, it's already executable.

Kevin

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZdgVLAAoJEH8JsnLIjy/Wpi4QALRXxrTCYoHUY/51lxG04qsU
Jgu7mFkPJuET48OFMQIw56911w8nu3cikd+r1d9c3c91CpdUorbhDDh99Yz6v5Sj
hn4iDuY6STm84afTv3ItOuhTT8+NwuTRG4LjLEvD5NxPOeHSMRcaewUOkCbByZbu
tHOcoJediWCWzu/9POYm1qIpDe6dqQxjw2O9ocYCrqE/LUvrOBGptpEhnAdacdRZ
RbRxcd58t0Yd8Pl5j0ay7y/wAu42keX+9zbvthU+RKM2pOPw2cB9yoh6/3V78Qx1
LzRh6FhYfHShYkjb2YVrSmVygNuBoCW1UvGNghfaoknU8yD/hhXKyWBEnGUqDEwK
klHolWGcRbZQ6Jgx37sfqvOr40zfYPJL89CfcOlCfQCeuFYFPIylD9iUTCPBTOTD
pcrEd7EnKBF+YwPOta4Z7RWtAvmt5assWTenL64ZHpSPM0S2hTbSiTPEEPanqDuc
xxssiFwL3S52v4fIMDSeXQ7rYzr0AXkOCHAQpR/+Jwur0qtgt42Q4IVn2qfr76DW
op1P95P0OrVs/RG1vl08tCjZVwKbI4NTw6x68FL4L+14J5Ixvt6cEZfTQ1ZFVMCm
3RatxAeyo1nxB5GN8OElnj+K1FiblR0D28YUVPpC8zZHuTHWkqha7ghUDugrkObW
fuOxx4UuD8m7DdusAyQp
=/YmG
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
