Received: from eggs.gnu.org ([2001:4830:134:3::10]:34640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFDmd-0008TD-2u
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFDmY-00014K-7J
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:36:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFDmY-00013h-19
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:36:14 -0500
Date: Thu, 16 Nov 2017 14:36:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171116063600.GE30426@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<150996313592.327.4353631543325177108@bafd83ae6430>
	<20171106130800.GA4764@xz-mi>
	<20171115094246.GC8130@stefanha-x1.localdomain>
	<20171116053200.GB30426@xz-mi> <20171116053951.GD14771@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171116053951.GD14771@lemon>
Subject: Re: [Qemu-devel] [RFC v3 00/27] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, quintela@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, marcandre.lureau@redhat.com, shajnocz@redhat.com, pbonzini@redhat.com, jdenemar@redhat.com, dgilbert@redhat.com

On Thu, Nov 16, 2017 at 01:39:51PM +0800, Fam Zheng wrote:

[...]

> I think what you could better use here is a checkpatch.pl hook, either before
> committing or before posting. I personally prefer the checkpatch.pl check in the
> pre-publish-tag hook of git-publish so I can freely do dirty commits that
> doesn't need s-o-b lines when I'm working on the branch, but still remember to
> add it before posting.

Noted. :)

-- 
Peter Xu
