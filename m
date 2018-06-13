Received: from eggs.gnu.org ([2001:4830:134:3::10]:44840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSv6D-0005qD-06
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSv69-0008ST-Vf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:01:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSv69-0008SD-RD
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:01:21 -0400
Date: Wed, 13 Jun 2018 10:01:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180613020111.GE15344@xz-mi>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
	<1528445443-43406-5-git-send-email-wei.w.wang@intel.com>
	<20180612075016.GD15344@xz-mi> <5B1FAAAF.4030705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B1FAAAF.4030705@intel.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/6] migration/ram.c: add ram save state
 notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Jun 12, 2018 at 07:12:47PM +0800, Wei Wang wrote:

[...]

> Hi Peter,
> 
> Thanks for the review. We just got a little accident in the kernel part,
> which may cause some modifications to the QEMU side interfaces. So I will
> implement a new version and let you review in v9 patches.

No problem.  Yeah I actually noticed the accident.  Please feel free
to postpone the QEMU part until the kernel part is fully settled.

Regards,

-- 
Peter Xu
