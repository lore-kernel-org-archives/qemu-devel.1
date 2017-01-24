Received: from eggs.gnu.org ([2001:4830:134:3::10]:54872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cVyPa-00027U-D8
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cVyPX-0000M7-CS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:33:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cVyPX-0000LC-7V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:33:11 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC61A7FE91
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:33:10 +0000 (UTC)
Date: Tue, 24 Jan 2017 16:03:04 +0530
From: Amit Shah <amit.shah@redhat.com>
Message-ID: <20170124103304.GB1679@amit-lp.rh>
References: <1485178976-15225-1-git-send-email-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485178976-15225-1-git-send-email-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Change name of live
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com

On (Mon) 23 Jan 2017 [19:12:56], Pankaj Gupta wrote:
> Change the name of live migration thread from 'migration'
> to 'live_migration' to identify it clearly. 'migration'
> is a generic word and kernel also has  tasks for process
> migration with the name 'migration/cpu#'.
> 
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
