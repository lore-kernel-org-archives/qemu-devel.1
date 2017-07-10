Received: from eggs.gnu.org ([2001:4830:134:3::10]:52575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZ8v-0002ii-7z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZ8u-00073y-Aj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:54:29 -0400
References: <1499678755-5633-1-git-send-email-gengdongjiu@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df74267a-3f6f-b6f5-432f-40f8c04ab1f1@redhat.com>
Date: Mon, 10 Jul 2017 08:54:07 -0500
MIME-Version: 1.0
In-Reply-To: <1499678755-5633-1-git-send-email-gengdongjiu@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nSRXmSWLuCdkvscAGtpPira2xBW0Wgg3L"
Subject: Re: [Qemu-devel] [PATCH v4 1/3] ACPI: Add new ACPI structures and
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhihui.gao@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nSRXmSWLuCdkvscAGtpPira2xBW0Wgg3L
From: Eric Blake <eblake@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>, lersek@redhat.com, mst@redhat.com,
 imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com,
 zhihui.gao@huawei.com
Message-ID: <df74267a-3f6f-b6f5-432f-40f8c04ab1f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] ACPI: Add new ACPI structures and
 macros
References: <1499678755-5633-1-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1499678755-5633-1-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 04:25 AM, Dongjiu Geng wrote:
> (1) Add related APEI/HEST table structures and  macros, these
>     definition refer to ACPI 6.1 and UEFI 2.6 spec.

Your mail is missing In-Reply-To: and References: headers, which makes
it appear as a new top-level thread for each patch.  You'll want to
figure out why you didn't properly link back to your 0/3 cover letter
with Message-ID: <1499678736-5244-1-git-send-email-gengdongjiu@huawei.com=
>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nSRXmSWLuCdkvscAGtpPira2xBW0Wgg3L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY4b/AAoJEKeha0olJ0NqWPIH/2JbCVFv1B+pecf/vB2+xpoU
/zckPX5LTHmCqyy9Q6ygPLuBZvwNZAS0c8vOxOQzM2a/lRVrU5gd1edik8QZctUH
PGN7yulnpA0TpdB7XwV5WjjRJ5OqizGvso1wSsBED9hTtmpr5BcN4lcm4KsqQlxK
vrHk08en3vxysN60+lgxE/EmnNEMlpp3IOzpWOzVokskBpVGvsjFIym5UzXgfJB8
XW6QqmcYomVKvUjd6VOALjJqIqCvV88Ip/2qjJtasN56aYv8+OCvGbMBPHwrAa9s
1qYu2VHUKgL6EQtPPidLwokWNDtLNboF2izi2dbG9fu8k1aNtWg37pk9bDoCnTY=
=z3js
-----END PGP SIGNATURE-----

--nSRXmSWLuCdkvscAGtpPira2xBW0Wgg3L--
