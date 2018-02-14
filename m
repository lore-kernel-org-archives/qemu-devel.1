Received: from eggs.gnu.org ([2001:4830:134:3::10]:41407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eloze-0004eg-K1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elozc-0002op-2h
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:48:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1elozb-0002oi-Uf
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:48:28 -0500
Date: Wed, 14 Feb 2018 12:48:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180214044814.GH4472@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
	<20180208103132.28452-27-peterx@redhat.com>
	<20180213194508.GT2378@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213194508.GT2378@work-vm>
Subject: Re: [Qemu-devel] [PATCH v6 26/28] hmp/migration: add
 migrate_recover command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Feb 13, 2018 at 07:45:09PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Sister command to migrate-recover in QMP.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Yes, useful for testing, although we don't have any OOB equivalent yet,
> something I need to look at.

That'll be nice.

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks,

-- 
Peter Xu
