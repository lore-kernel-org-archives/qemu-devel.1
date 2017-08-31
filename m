Received: from eggs.gnu.org ([2001:4830:134:3::10]:45592)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dnU3i-0003mz-2s
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dnU3e-0001jw-4C
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:19:18 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47580 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dnU3d-0001hd-PT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:19:14 -0400
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <e224ad7a-fbbd-f7d4-fbde-39adad4900ec@kamp.de>
Date: Thu, 31 Aug 2017 20:19:08 +0200
MIME-Version: 1.0
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/79] Patch Round-up for
 stable 2.9.1, freeze on 2017-09-04
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

Am 29.08.2017 um 02:13 schrieb Michael Roth:
> Hi everyone,
>
> The following new patches are queued for QEMU stable v2.9.1:
>
>   https://github.com/mdroth/qemu/commits/stable-2.9-staging
>
> The release is planned for 2017-09-07:
>
>   http://wiki.qemu.org/Planning/2.9
>
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

I also have:

452589b vl.c/exit: pause cpus before closing block devices

Peter
