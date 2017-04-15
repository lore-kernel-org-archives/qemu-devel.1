Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1czDQ9-0003xt-5y
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 22:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1czDQ8-0004iQ-C8
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 22:26:41 -0400
References: <20170410022636.29925-1-famz@redhat.com>
	<20170410160417.GH3214@stefanha-x1.localdomain>
	<0800f14a-4b80-9bed-bf2a-41f177ffff64@redhat.com>
	<20170413072137.GA7585@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9771d4cd-3da7-93da-19db-5fe9afb49dcf@redhat.com>
Date: Sat, 15 Apr 2017 10:26:24 +0800
MIME-Version: 1.0
In-Reply-To: <20170413072137.GA7585@lemon>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>



On 13/04/2017 15:21, Fam Zheng wrote:
> Paolo, maybe you want to submit a formal patch for 2.10? (Sorry for the
> confusion, these series of mine went a bit messy.)

Yes, will do.  Or just submit the alternative fix that is mentioned in
the comment.

Paolo
