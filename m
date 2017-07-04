Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dSKKu-0007IU-8M
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dSKKt-0002Zm-7i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:41:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1dSKKt-0002ZW-13
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:41:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2A5A80F8E
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 09:41:33 +0000 (UTC)
Date: Tue, 4 Jul 2017 10:41:31 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170704094131.GC3004@redhat.com>
References: <20170704093815.28285-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704093815.28285-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Error if signal(2) is used
 non-portably.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com


Ignore this, Paolo also sent a similar patch after we were discussing
this on IRC.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
