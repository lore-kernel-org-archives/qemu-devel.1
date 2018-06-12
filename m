Received: from eggs.gnu.org ([2001:4830:134:3::10]:54740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fScjP-0001H5-Uf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fScjL-0004tN-0q
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:24:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fScjK-0004sw-Rm
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64399805A530
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 06:24:34 +0000 (UTC)
Received: from xz-mi (dhcp-14-142.nay.redhat.com [10.66.14.142])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B4CB2026609
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 06:24:33 +0000 (UTC)
Date: Tue, 12 Jun 2018 14:24:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180612062430.GA15344@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>

Hi,

For example, I wanted to compile QEMU once and install it on multiple
systems.  What would be the suggested way to do so?

Is there something similar to "make bin-rpmpkg" for Linux?

Thanks in advance,

-- 
Peter Xu
