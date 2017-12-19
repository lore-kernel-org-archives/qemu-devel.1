Received: from eggs.gnu.org ([2001:4830:134:3::10]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRB1z-0001u8-Q1
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRB1w-0005f1-IF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:05:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRB1w-0005eQ-Cj
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:05:32 -0500
Date: Tue, 19 Dec 2017 14:05:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171219060513.GA22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171214145247.GP14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214145247.GP14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 00/26] QMP: out-of-band (OOB) execution
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

On Thu, Dec 14, 2017 at 02:52:47PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:34PM +0800, Peter Xu wrote:
> > This version is mostly document update, and dropped the single patch
> > that is migration related (will be put into postcopy recovery
> > series).
> 
> I've finished reviewing this revision.  The overall approach looks good.

Thanks for the in-depth review!  I'm posting another version soon
after the smoke test.

-- 
Peter Xu
