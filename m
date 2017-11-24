Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eIAZM-0003kD-Fu
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eIAZI-0005oc-Bf
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:46:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eIAZI-0005nC-6M
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:46:44 -0500
Date: Fri, 24 Nov 2017 09:46:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171124094635.GA2302@work-vm>
References: <151142853452.597.17238191575233522294@bafd83ae6430>
	<5A177041.7080001@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A177041.7080001@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] docs/devel/migration.txt: keep functions
 consistent with the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, quintela@redhat.com

* Jay Zhou (jianjay.zhou@huawei.com) wrote:
> This patch does not touch any code at all.
> 
> So I think this patch is not relevant to this test failure.

Yes, that's true; there's a block problem that's been affecting all
tests recently.

Dave

> Regards,
> Jay
> 
> On 2017/11/23 17:15, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> > 
> > Subject: [Qemu-devel] [PATCH] docs/devel/migration.txt: keep functions consistent with the code
> > Type: series
> > Message-id: 1511426872-13980-1-git-send-email-jianjay.zhou@huawei.com
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
