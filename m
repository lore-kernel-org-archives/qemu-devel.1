Received: from eggs.gnu.org ([2001:4830:134:3::10]:54248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cHPJ3-0005HC-65
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 01:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cHPJ0-0004Xd-28
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 01:14:17 -0500
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d57a4c3d-19fd-7e2d-4e15-8f4578cf8fcb@weilnetz.de>
Date: Thu, 15 Dec 2016 07:14:09 +0100
MIME-Version: 1.0
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/67] Patch Round-up for stable 2.7.1,
 freeze on 2016-12-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 12/15/16 01:43, Michael Roth wrote:
> Hi everyone,
>
> The following new patches are queued for QEMU stable v2.7.1:
>
>   https://github.com/mdroth/qemu/commits/stable-2.7-staging
>
> The release is planned for 2016-12-23:
>
>   http://wiki.qemu.org/Planning/2.7
>
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>
> Testing/feedback is greatly appreciated.
>
> Thanks!


http://patchwork.ozlabs.org/patch/705682/
[for-2.8] ui/gtk: fix "Copy" menu item segfault

(still missing in git)

Regards,
Stefan
