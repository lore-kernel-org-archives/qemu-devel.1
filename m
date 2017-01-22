Received: from eggs.gnu.org ([2001:4830:134:3::10]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVJ9l-0007zW-La
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 09:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVJ9k-0006px-Vf
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 09:30:09 -0500
Date: Sun, 22 Jan 2017 22:29:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170122142959.GA12419@lemon.Home>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, 01/20 17:25, Eric Farman wrote:
> Changes:
>  v2->v3:
>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>  v1->v2:
>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]

Reviewed-by: Fam Zheng <famz@redhat.com>
