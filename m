Received: from eggs.gnu.org ([2001:4830:134:3::10]:37306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejM2H-0000p9-UL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejM2E-0005js-Qd
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:29:01 -0500
Date: Wed, 7 Feb 2018 10:28:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180207102841.17a18b5d.cohuck@redhat.com>
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/54] Patch Round-up for stable 2.11.1,
 freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, christian.ehrhardt@canonical.com

On Tue,  6 Feb 2018 13:14:21 -0600
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Hi everyone,                                                                                              
> 
> The following new patches are queued for QEMU stable v2.11.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> 
> The release is planned for 2017-02-14:
> 
>   https://wiki.qemu.org/Planning/2.11
> 
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> 
> Of particular importance would be any feedback on the various QEMU
> patches relating to Spectre/Meltdown mitigation. The current tree has
> what I understand to be the QEMU components required for x86, s390,
> and pseries, but feedback/confirmation from the various authors would
> be greatly appreciated.
> 
> Thanks!

AFAICS, the patches include everything we need for s390x. Thanks!
