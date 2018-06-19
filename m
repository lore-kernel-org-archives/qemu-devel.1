Received: from eggs.gnu.org ([2001:4830:134:3::10]:43586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fVOcg-0006Ks-Nh
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fVOcc-0002ze-Qv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:57:10 -0400
Message-Id: <5B297C2C020000480007E124@prv-mh.provo.novell.com>
Date: Tue, 19 Jun 2018 15:57:00 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH 00/113] Patch Round-up for stable 2.11.2,
 freeze on 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

>>> On 6/18/2018 at 7:41 PM, Michael Roth <mdroth@linux.vnet.ibm.com> =
wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.11.2:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.11-staging=20
>=20
> The release is planned for 2018-06-22:
>=20
>   https://wiki.qemu.org/Planning/2.11=20
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20

For openSUSE Leap 15's qemu package, based on v2.11.1, we
also add these patches:=20

commit bb223055b9b327ec66e1f6d2fbaebaee0b8f3dbe
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Mon Dec 11 13:21:46 2017 +0100

    s390-ccw-virtio: allow for systems larger that 7.999TB

commit 05b71fb207ab7f016e067bd2a40fc0804362eb74
Author: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Mon Jan 29 19:33:04 2018 +0100

    tpm: lookup cancel path under tpm device class

Bruce
