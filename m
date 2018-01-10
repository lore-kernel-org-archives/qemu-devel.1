Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ8Jv-00062t-Fc
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ8Jr-0003Um-K0
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZ8Jr-0003Tv-DC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:48:55 -0500
Date: Wed, 10 Jan 2018 12:48:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110044839.GB16137@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20180109145248.GJ31400@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109145248.GJ31400@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 00/27] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jan 09, 2018 at 02:52:49PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:30PM +0800, Peter Xu wrote:
> > This v6 kept most of the high level design untouched, however there
> > are quite a few of changes that try to make the series more robust and
> > safe.  My sincere thank to the reviewers (especially Stefan!) on all
> > review comments to previous one.  Let's see how this version goes.
> > 
> > v6:
> 
> I've finished my review of this revision and posted comments.

Thanks Stefan (and all the reviewers)!  I'll revisit the series in one
or two days.

-- 
Peter Xu
