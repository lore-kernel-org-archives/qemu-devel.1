Received: from eggs.gnu.org ([2001:4830:134:3::10]:42479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciU1d-0001H1-A3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciU1Z-0005MP-EZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:44:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciU1Z-0005KR-6K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:44:09 -0500
References: <1487990764-27397-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
From: Eric Blake <eblake@redhat.com>
Message-ID: <257647af-303a-68b7-8b67-1290c0eee399@redhat.com>
Date: Mon, 27 Feb 2017 16:44:06 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CUgOOciXEkEwNcsjBQTIUxIOL3EmGMEEE"
Subject: Re: [Qemu-devel] [PATCH V10 0/2] Add new qmp commands to suppurt
 Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CUgOOciXEkEwNcsjBQTIUxIOL3EmGMEEE
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong"
 <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>
Message-ID: <257647af-303a-68b7-8b67-1290c0eee399@redhat.com>
Subject: Re: [PATCH V10 0/2] Add new qmp commands to suppurt Xen COLO
References: <1487990764-27397-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 04:31 PM, Stefano Stabellini wrote:
> Eric, are you OK with this series going upstream? If so, do you want me=

> to send the pull request for it or are you going to handle it?

Both patches have my R-b, but MAINTAINERS suggests the pull request
should go through COLO Framework (zhanghailiang) or maybe Xen (you).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CUgOOciXEkEwNcsjBQTIUxIOL3EmGMEEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtKu2AAoJEKeha0olJ0Nq7tgH+QHQb69emGlQ8cltSJXzkE7a
LQPBe6zLfvA+27So+NQuhsmjf2u1RRBMeeGxK6m8dSumrSDinDHHaju8AjzIPeHF
a4PfnQQBbplSOf+VUsJAMGhDMMd93fsBm9C43QPWUGSFaOHzxgJS3beQZ+hL0riz
GVTVVpQMlxJDYhnxM6h2asmHdkdPWZn6YhujkLJ19Y5WnBi3WNAnmv5jc+T0iwqS
cWCt6imWktPLMqEvWWCtHinpoatyVqrV041/M8XjfqCcSFak7CXqgLI7NNHmSIMZ
M9tYjin9KF171C+N4TVfDnYr3rasnk/w2Na/rDUa3MS6QhCZTrO6ZzEd0KiESVA=
=r5P+
-----END PGP SIGNATURE-----

--CUgOOciXEkEwNcsjBQTIUxIOL3EmGMEEE--
