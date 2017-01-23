Received: from eggs.gnu.org ([2001:4830:134:3::10]:50113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVcE3-0005V2-CM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVcDz-0003Xp-PR
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:51:51 -0500
Date: Mon, 23 Jan 2017 18:51:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170123105137.GA28257@lemon.Home>
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
	<20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
	<7428bd3f-0cc8-f42f-a2bd-442c2c6ffbef@linux.vnet.ibm.com>
	<20170116052600.GA16076@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170116052600.GA16076@lemon>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] block/vmdk: Fix the endian problem
 of buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liujing <liujbjl@linux.vnet.ibm.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: borntraeger@de.ibm.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, "cornelia.huck@de.ibm.com QingFeng Hao" <haoqf@linux.vnet.ibm.com>

On Mon, 01/16 13:26, Fam Zheng wrote:
> On Mon, 01/16 10:38, liujing wrote:
> > Dears,
> > 
> > We would like to know if this patch will be pulled
> > 
> > into upstream or what else we need to do for it?
> > 
> > Because for upstream, the qemu-iotests case 055 still failed.
> 
> Kevin, would you like to take this or should I do it?

Adding Max since he's taking care of the other VMDK fix I posted.

Fam
