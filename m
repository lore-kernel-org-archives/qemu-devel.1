Received: from eggs.gnu.org ([2001:4830:134:3::10]:42262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbrK-00007z-K5
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbrJ-0005Km-OQ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:22:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejbrJ-0005KQ-Jf
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:22:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B10C40363AD
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 02:22:45 +0000 (UTC)
Date: Thu, 8 Feb 2018 10:22:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180208022243.GD24289@lemon.usersys.redhat.com>
References: <20180201022046.9425-1-famz@redhat.com>
	<76a404cb-7163-e3f8-a97a-d75c3fda3b29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a404cb-7163-e3f8-a97a-d75c3fda3b29@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, 02/07 15:31, Paolo Bonzini wrote:
> On 01/02/2018 03:20, Fam Zheng wrote:
> > To make our efforts on QEMU testing easier to consume by contributors,
> > let's add a document. For example, Patchew reports build errors on
> > patches that should be relatively easy to reproduce with a few steps, and
> > it is much nicer if there is such a documentation that it can refer to.
> > 
> > This focuses on how to run existing tests and how to write new test
> > cases, without going into the frameworks themselves.
> > 
> > The VM based testing section is moved from tests/vm/README which now
> > is a single line pointing to the new doc.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Queued, thanks.

Thank you, I've included this in the pull request I just sent. :)

Fam
