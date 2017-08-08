Received: from eggs.gnu.org ([2001:4830:134:3::10]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Ry-0007h6-U8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Ru-0005Ik-Qk
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:09:22 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df1Ru-0005IK-K8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:09:18 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so3060080wmt.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:09:18 -0700 (PDT)
Date: Tue, 8 Aug 2017 11:09:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808100915.GD16801@stefanha-x1.localdomain>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20170804213625.3756-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/5] qmp-shell: Pass split cmdargs
 to __build_cmd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:36:22PM -0300, Eduardo Habkost wrote:
> This will allow us to implement a method to run a command that is
> already split in a list.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY3LAAoJEJykq7OBq3PIBusH/i4kG+87dG8oR856nLBNHw5p
skAGmpCrQtkgLDBqQ9MZDIp+IkyVXCoj/h6k/GeoPRIL1bslmb6xoRka40mgjHqq
RcsVWDYKZCha1BeEk5iwuG5RkMFgJBYBLUckJduKWy90+xmla+2tyNTNbZ3f74Kj
oSJjT7H5O5RmpsD1ueUzZcg0QIjfSc1kmvOMUWsMjdkSPvBSBM1W4EIstZAIxQNU
sjlF/BDX81bF9l42rOf7hHonfni7sg6/wpjy4K6dFPrVNXK0UVVS0P2/2vIDdD4J
b+offNw0AWp2/I/jlOm8Gio1pE8u2/OC4avQ9TbP2p6jAtRdhbux7DYU3KMJoPE=
=OtzJ
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
