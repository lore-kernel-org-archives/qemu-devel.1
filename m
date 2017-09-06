Received: from eggs.gnu.org ([2001:4830:134:3::10]:41589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dpWgF-0004yw-Ve
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dpWgB-00060y-3K
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:31:31 -0400
Date: Wed, 6 Sep 2017 10:31:22 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170906093122.GB18719@redhat.com>
References: <20170906085006.26983-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906085006.26983-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-options: Document the -drive
 locking parameter.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru, famz@redhat.com, armbru@redhat.com

On Wed, Sep 06, 2017 at 09:50:06AM +0100, Richard W.M. Jones wrote:
> Commit 16b48d5d66d2 ("file-posix: Add 'locking' option") added this
> option, but as it was not documented in the -help output it was not
> easily possible to tell if a particular qemu binary supports it.

My apologies, I think this patch is wrong.  I'm going to rethink it.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
