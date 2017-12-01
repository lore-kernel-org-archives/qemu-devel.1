Received: from eggs.gnu.org ([2001:4830:134:3::10]:36094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnR4-0003Lt-WC
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnQ8-0006k1-6f
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:41:06 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:32924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eKnQ7-0006fo-MR
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:40:07 -0500
Received: by mail-wr0-x22a.google.com with SMTP id v22so10557508wrb.0
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 07:40:07 -0800 (PST)
Date: Fri, 1 Dec 2017 12:54:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201125415.GM23501@stefanha-x1.localdomain>
References: <96af8d77-c40a-01ea-a91e-0de5d0a48b04@etrix.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Content-Disposition: inline
In-Reply-To: <96af8d77-c40a-01ea-a91e-0de5d0a48b04@etrix.com.au>
Subject: Re: [Qemu-devel] Apple hyphervisor.framework availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Brendan Simon (eTRIX)" <brendan.simon@etrix.com.au>
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2017 at 08:14:49PM +1100, Brendan Simon (eTRIX) wrote:
> Hi QEMU devs,
>=20
> Just wondering when the accelerator for Apple's hypervisor.framework
> (hvf) will hit the git repos to build and try out?
>=20
> I get the impression that patches have been submitted, but I can't see
> anything in the repos.=A0 Is there a special branch or fork where these
> patches reside?

Hi Brendan,
I have CCed Sergio (patch series author) and Paolo.  qemu-devel is a
high-traffic mailing list and most people do not read every email.  It
helps to CC the people involved.

Stefan

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIVD3AAoJEJykq7OBq3PIoEQH/2As9iDEn3ZjIWyrS+7JOQK7
8RV44aM0d8YGBOlveIfTW9FbpfqxuQgw+HuhsPpmk9te9H6GM8DH60TiZdGE5l/8
45+5HS2TL3BR00QvE9uxpjSWjyBV91KIx4ttOdVxCHdlIDVu/D39hZwta8qsQHXq
CwXNmPZN9iRsEm/R4ov7SZPb+87jxk5OomBp6GkqKjx5qvicj3px2EAlrTj45MRL
JBcp+Pk8bSl0QSWRInXyeWyB04s2Dnmy+x7grb+2NxpZmb01FnJFq374AGDymaz2
bsiq9S5u57DAx8Uhkb7ALjNzhXJIeAOS41WltzwPN5tasuqArpVVFU3WLUxICvQ=
=wY42
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--
