Received: from eggs.gnu.org ([2001:4830:134:3::10]:38235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1fVLDs-0008Lh-Lq
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1fVLDo-0000P0-NK
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:19:20 -0400
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <954ee98f-125f-2471-46e4-9e7a484e00e4@redhat.com>
Date: Tue, 19 Jun 2018 14:19:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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

On 06/18/2018 09:41 PM, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.11.2:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
>=20
> The release is planned for 2018-06-22:
>=20
>   https://wiki.qemu.org/Planning/2.11
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20
> Thanks!
>=20

Extra patches we are carrying in Fedora 28:

commit f7a5376d4b667cf6c83c1d640e32d22456d7b5ee
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Tue Jan 16 13:42:10 2018 +0000

    qapi: ensure stable sort ordering when checking QAPI entities

commit 057ad0b46992e3ec4ce29b9103162aa3c683f347
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Wed Feb 28 14:04:38 2018 +0000

    crypto: ensure we use a predictable TLS priority setting


Thanks,
Cole
