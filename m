Received: from eggs.gnu.org ([2001:4830:134:3::10]:46468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eIFry-0006oI-NO
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eIFrv-0006mH-H4
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:26:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eIFrv-0006lJ-An
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:26:19 -0500
Date: Fri, 24 Nov 2017 16:26:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171124152614.GC4010@localhost.localdomain>
References: <20171124085351.26386-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124085351.26386-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] docs: Add documentation for image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Philipp Hahn <hahn@univention.de>, mreitz@redhat.com

Am 24.11.2017 um 09:53 hat Fam Zheng geschrieben:
> v2: Grammar and spelling fixes pointed out by Kevin and Philipp.
> 
> Image locking feature was added in 2.10 but the documentation has been missing.
> Users sometimes get confused and wonder how to configure it for their specific
> needs. We should address common use cases in the man page and explain related
> options.

Thanks, applied to the block branch.

Kevin
