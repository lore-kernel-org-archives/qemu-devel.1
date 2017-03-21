Received: from eggs.gnu.org ([2001:4830:134:3::10]:49373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cq8ds-00085R-3Z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cq8dr-0000dm-3k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:31:20 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <030b963a-df0a-9b7c-5d54-5bd5fafa5113@twiddle.net>
Date: Tue, 21 Mar 2017 11:31:07 +1000
MIME-Version: 1.0
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/81] Patch Round-up for stable 2.8.1,
 freeze on 2017-03-27
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

On 03/21/2017 09:07 AM, Michael Roth wrote:
> Hi everyone,
>
> The following new patches are queued for QEMU stable v2.8.1:
>
>   https://github.com/mdroth/qemu/commits/stable-2.8-staging
>
> The release is planned for 2017-03-30:
>
>   http://wiki.qemu.org/Planning/2.8
>
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

Other possibilities include

6cde517 linux-user: Fix s390x safe-syscall for z900
0a97c40 target-arm: Fix aarch64 disas_ldst_single_struct
416d72b target-arm: Fix aarch64 vec_reg_offset


r~
