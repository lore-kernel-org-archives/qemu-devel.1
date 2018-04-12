Received: from eggs.gnu.org ([2001:4830:134:3::10]:41475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6eVE-0004rZ-Uc
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6eVB-0006XU-CK
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:51:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6eVB-0006XI-6B
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:51:09 -0400
References: <1523340210-9070-1-git-send-email-yulei.zhang@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7c6c2ae-c938-f7cf-3a6a-9219eeee6ace@redhat.com>
Date: Thu, 12 Apr 2018 10:51:04 -0500
MIME-Version: 1.0
In-Reply-To: <1523340210-9070-1-git-send-email-yulei.zhang@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MDbS7dSRTixHDE6UlB3cLLViRMr7RMU15"
Subject: Re: [Qemu-devel] [RFC PATCH V4 4/4] vifo: introduce new VFIO ioctl
 VFIO_IOMMU_GET_DIRTY_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, quintela@redhat.com, joonas.lahtinen@linux.intel.com, kwankhede@nvidia.com, zhenyuw@linux.intel.com, dgilbert@redhat.com, alex.williamson@redhat.com, zhi.a.wang@intel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MDbS7dSRTixHDE6UlB3cLLViRMr7RMU15
From: Eric Blake <eblake@redhat.com>
To: Yulei Zhang <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, quintela@redhat.com,
 joonas.lahtinen@linux.intel.com, kwankhede@nvidia.com,
 zhenyuw@linux.intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 zhi.a.wang@intel.com
Message-ID: <c7c6c2ae-c938-f7cf-3a6a-9219eeee6ace@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH V4 4/4] vifo: introduce new VFIO ioctl
 VFIO_IOMMU_GET_DIRTY_BITMAP
References: <1523340210-9070-1-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1523340210-9070-1-git-send-email-yulei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 01:03 AM, Yulei Zhang wrote:
> New VFIO ioctl VFIO_IOMMU_GET_DIRTY_BITMAP is used to fetch the
> bitmap of pinned memory in iommu container, we need copy those
> memory to the target during the migration as they are dirtied by
> mdev devices.

[meta-comment]

This patch, and the other 3 in the series, were sent with no
'In-Reply-To:' or 'References:' headers; as such, they were not threaded
to the 0/4 cover letter ('Message-Id:
<1523340124-8881-1-git-send-email-yulei.zhang@intel.com>').  In the
future, you'll want to make sure that proper threading is preserved in
the mail messages, as it makes it a lot easier when each message in the
series is not a new top-level thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MDbS7dSRTixHDE6UlB3cLLViRMr7RMU15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPgGgACgkQp6FrSiUn
Q2pF2gf/WeiB5vpA5fooikbDaySSIRFlDYHiDSHSAwv7MlwysOs6JztUNduJL52n
DJOODT0hhFmGEqZOeZ87IN8lUKwKATo0dCaFfIf4cjcmlNLOyMKCLtKSNBDZLFTi
2LlZFQNkzYlKi+hrAc99d68kB6NTs8e38ImMzAyNQy106sWXlQD5nchICbeXTiHJ
zuqC9juIPreVNUssFLI32pPRuDNCgYSTz3a0vQ8vP8Tdwve7sW+soVt3dbAAlI+4
XaKjENuYH3v9mVDYKph0lugdIWAcr5Lvq7XvbNLaAMXKBM2q2RV9Cct7dHuaLAX2
Sc6ATpOyP6AfKvye3n7AeDFAZbBd8A==
=kqu0
-----END PGP SIGNATURE-----

--MDbS7dSRTixHDE6UlB3cLLViRMr7RMU15--
