Received: from eggs.gnu.org ([2001:4830:134:3::10]:50446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fASCf-0002lF-AU
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fASCc-0000jK-5m
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:31:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fASCc-0000iI-11
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:31:42 -0400
References: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
Date: Mon, 23 Apr 2018 05:31:28 +0200
MIME-Version: 1.0
In-Reply-To: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PuQOiqy0SfyXHbdnYGFyaZ9a1YU0qouLe"
Subject: Re: [Qemu-devel] unknown keycodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike R <picnet@me.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PuQOiqy0SfyXHbdnYGFyaZ9a1YU0qouLe
From: Thomas Huth <thuth@redhat.com>
To: Mike R <picnet@me.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
Subject: Re: [Qemu-devel] unknown keycodes
References: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
In-Reply-To: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.04.2018 11:27, Mike R wrote:
> (qemu) unknown keycodes `empty+aliases(qwerty)=E2=80=99, please report =
to qemu-devel@nongnu.org
>=20
> reported.

Well, please also report:

- Which version of QEMU are you using?

- Which keyboard layout do you have on your physical keyboard?

- Which key did you press to get that message?

- Which user interface of QEMU are you using (GTK, SDL1.2, SDL2 or VNC)?

 Thanks,
  Thomas


--PuQOiqy0SfyXHbdnYGFyaZ9a1YU0qouLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJa3VOXAAoJEC7Z13T+cC21HnIP/RuwxbOmiZOQ2tAyIORavWZz
2TZuolhv8JYyMYomrVrkcCX7OALqIQ5HKor/s9fzHZ9fiNFvETEZ5/X4jscLX18y
aNgh5TVexpY4kTdtzUZJ5d+RqJ5U/xPZdg1qcbZL3PrfTWOSDXPrsjBr/NopUhOX
ifbV0CiuepiGxhAjKgx1Qt+hZcg014koIN4mc3d715ci6mn/bppNN65RqCZgqem4
QwflT1moLcAW99l7nCzLFIe8t16taT6Fwxd0MdTBa/004ky3lMrIC1D78GTmNlB3
I4fuasiRQMbdEwraJW3Vssu4Yirffc4eTcWfRU347pAXezRhdRb4dXzu9KB6QVRz
NpWqJyBsSjCwvvXI88fiZsj2LhhRS350ZcA3y3IK+Z1NvEs9byvWPtg/Gxr7JDdS
lPZsWl6MjMi1Y1a+J2B5T8vzkOg55qIEy1INzed1L4sqqAOo78XS1G98nDS3RUSv
uUE8Lu2Zys1rC23bSkeBDHVa33Nvt/PzKI6kiatRPARuuq1Tz3NrerYIwZ1JWgjg
qnmldEJ53IO7Pn4ar7gCJS++ClQ6ow72EThLeV4K9JnkqqmPzfSvTjDlHR5kK/0S
wX+8ttwF4/J1fsu79vpjdKKSrR1Bc85Q0e/fGVh9Ivfmc/b//aSvJWjKvbjpGzbY
9E4IvdkRQUK+IGriy3Mw
=45sp
-----END PGP SIGNATURE-----

--PuQOiqy0SfyXHbdnYGFyaZ9a1YU0qouLe--
