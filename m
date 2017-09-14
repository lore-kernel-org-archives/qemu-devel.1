Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOp8-0001Lo-LY
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOp5-0000Iu-HN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:44:34 -0400
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <b8342522-fa37-3d56-65d8-c61a8e42ba25@msgid.tls.msk.ru>
Date: Thu, 14 Sep 2017 10:44:28 +0300
MIME-Version: 1.0
In-Reply-To: <1504100343-26607-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

30.08.2017 16:39, Thomas Huth =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> The "slow" ivshmem-tests currently fail when they are running on a
> big endian host:

Applied to -trivial, thanks!

/mjt
