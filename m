Received: from eggs.gnu.org ([2001:4830:134:3::10]:53182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFG5k-0000YU-IU
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFG5g-00058D-O9
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:59:40 -0500
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-2-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1732f81-a46f-3f6f-996f-71bb338b6239@redhat.com>
Date: Fri, 9 Dec 2016 08:59:31 +0100
MIME-Version: 1.0
In-Reply-To: <20161209022314.14399-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.9 1/5] pseries: Add pseries-2.9 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On 09.12.2016 03:23, David Gibson wrote:
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c      | 23 +++++++++++++++++++++--
>  include/hw/compat.h |  3 +++
>  2 files changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
