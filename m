Received: from eggs.gnu.org ([2001:4830:134:3::10]:34594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jvX-0008M9-O4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jvS-0008LU-BD
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:02:19 -0400
Date: Wed, 4 Apr 2018 16:02:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404150210.GW4467@stefanha-x1.localdomain>
References: <20180403140314.8795-1-stefanha@redhat.com>
	<a8c52de6-14a4-a5c4-4186-3c49c9a0b6b9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KRJ4yArSHF8vY7I3"
Content-Disposition: inline
In-Reply-To: <a8c52de6-14a4-a5c4-4186-3c49c9a0b6b9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: update 185
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--KRJ4yArSHF8vY7I3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 02:59:14PM +0800, QingFeng Hao wrote:
> =E5=9C=A8 2018/4/3 22:03, Stefan Hajnoczi =E5=86=99=E9=81=93:
> Need we add the comment in 185.out that this change is to make the test p=
ass for the superfluous block job iteration?

Thanks, I have sent v2.

Stefan

--KRJ4yArSHF8vY7I3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxOjyAAoJEJykq7OBq3PIRegIAKXZUgeQJBaS0RHTbmE5Gfj+
0Wsv8eTtQ7T5l9MS6LhcohDDau7vsm2qJZBYlHfDv7ltYZbhTmDvyKaK+Oi8VO9e
xZYqe94Ww1WnX0SEForXgfC+EQk2MNwaZVHbRSJ9okEOSQ5ZltthirBW8Kj2QlSE
2jorE3Frf5ifpFBhereFhvvt/klm3sKV6+gVNnX4Ys/PmkR+zBOug6geJIH2joxh
ViAeiUn+tRw515nthKFLoDcGeEe3PwAWW4BzPlfuo9fHGexYXnVdWmaSMWxBMQ7X
GY23DQ7yMDTa4Mi4GxvrfKOqBaatacyf6J317+hczHcJmEKSsdGW/Qn1kfqfd/Y=
=hSpO
-----END PGP SIGNATURE-----

--KRJ4yArSHF8vY7I3--
