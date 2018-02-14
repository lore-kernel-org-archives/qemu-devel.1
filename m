Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elx3w-00033M-VL
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elx3t-0000hp-QI
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:25:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1elx3t-0000hb-I8
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:25:25 -0500
Date: Wed, 14 Feb 2018 13:25:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180214132508.GA7545@stefanha-x1.localdomain>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180214004820.GA15103@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20180214004820.GA15103@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 08:48:20AM +0800, Fam Zheng wrote:
> On Tue, 02/13 17:34, Stefan Hajnoczi wrote:
> > The following changes since commit fb68096da3d35e64c88cd610c1fa42766c58=
e92a:
> >=20
> >   Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 +00=
00)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://github.com/stefanha/qemu.git tags/block-pull-request
> >=20
> > for you to fetch changes up to 64b01feca991e5b19a5d750ef77cdca92b68bdbb:
> >=20
> >   misc: fix spelling (2018-02-13 15:38:17 +0000)
>=20
> Did you mean "PULL" in the subject?

git-publish is just obeying your profile settings:

+[gitpublishprofile "default"]
+base =3D master
+prefix =3D PATCH
 ^---- :)

I used PULL myself in the past but am happy with using whatever we
decide the standard should be.

Shall we remove prefix from the profiles (it defaults to "PATCH" for
regular patches and "PULL" for pull requests)?

Stefan

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahDi0AAoJEJykq7OBq3PIP74IAIijkpX8IWQa0Ks1Ur/RDEPR
mCuYXc7h/z/oKBFJuNL4Obm4OB94LI7RHjnlOK7BM2cRfSl3HblDECp2lHDv4peb
bKhDDJ6F49yWVPU2AKm/J9It8gAzHELMgqPnxQ27hYZok51gMLPev7vFWQmEMJ7p
in0uYJqvJUNh6WZsuDCC54KofiJmDQgd0wRqbTjvSMNZ12sAsmwFlfB4p4Wr7kma
9/Be826Jhggpahld0/UUcQOjlBrD6BkhPFLIM05FZVT+fQquPLRy7bFOzVPh9swS
AL+CA4YB6g/fnzbhs531Z2CsA1Bvscyn1nZDmiTF3H5tOJmHjJ8ko0XAASHf7uA=
=reV3
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
