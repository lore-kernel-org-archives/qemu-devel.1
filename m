Received: from eggs.gnu.org ([2001:4830:134:3::10]:59351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f5hVo-0007jv-Sd
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f5hVk-0001am-CL
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:51:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f5hVk-0001aA-70
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:51:48 -0400
Date: Tue, 10 Apr 2018 10:51:34 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180410105134.2b274724@umbus.fritz.box>
In-Reply-To: <8d16e553-d0ae-81ac-26f9-95fd1619f8a2@redhat.com>
References: <20180327164141.19075-1-famz@redhat.com>
	<b00ba0ab-538f-a6f1-3b99-1a0d9adb6eab@redhat.com>
	<20180409110844.0a5188af@umbus.fritz.box>
	<8d16e553-d0ae-81ac-26f9-95fd1619f8a2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/K_RPaNfvaep2CvSmJMq6NcT";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, danielhb@linux.vnet.ibm.com, eblake@redhat.com

--Sig_/K_RPaNfvaep2CvSmJMq6NcT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Apr 2018 11:28:16 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 09/04/2018 03:08, David Gibson wrote:
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>=20
> Hi David,
>=20
> it's already included in my pull request from Friday.

And I see it in master now.  Thanks!

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/K_RPaNfvaep2CvSmJMq6NcT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrMCpYACgkQbDjKyiDZ
s5LKRA//VOHnjKiLqY7BePMH9Mr1tkKiLyWSnPgkVzG5mxE3P8AVRjS6Sdibbwx8
JUCSwdSn1fijCG1JlHYz/G4FRZednG8gr1X8lh9+T+o87z/WuUE4wj5y+y6i9p7T
rfRk99XZpkj0oy2ydbD4TFNV3lHRtZj+OwDGNwf/5meau2v2UxpSyQZPmCHworKw
A4jehBYMIB/2SHyYwFnkRMDDgvzGrUD0LcDpuEsvkZWTOQoDg/gpuM/TV0X71Gzm
0195y+tv8teLj6+ZDutAiRQLMDpxcI4IfnjmM76bTg5l0gkLpMCMRxptkSAJGeB9
nWil1QIL9eTQFunbmgHO4DNJS3KRg7n30HZuf2Y9mFjsPg2PKC/AvfiMUST/9p8f
DhnMTuJAKpHJnU2cBu7BAKQ3Rw814oWB+pl5ge1UITCIEuWIwqGhTQXdfJBsNrNi
ecJnqaiQSsrw4Xq1YEgjt2oLpLTjVn1DQwnGT6YZo1e85CJxduj2MrMxG8m3fXR4
fuYgZcv+eZt7FHqv+TLf0i5pxLnlWeXt/8tIb/7Coaw03yCEVdW4QO8J+q00P+4i
PLibUm3r2WXQLKsmDrY8a/Gusz6gzKT8zBBuUPXXM3O860b5P+RKrXwPYN9P7k2e
AYfie/yCVBtWpdmkd2KOjl+QrbCLoB1JymmERU5sH8uDMH5RoKc=
=G6Kh
-----END PGP SIGNATURE-----

--Sig_/K_RPaNfvaep2CvSmJMq6NcT--
