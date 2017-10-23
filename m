Received: from eggs.gnu.org ([2001:4830:134:3::10]:58486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aY5-00037R-Or
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aY5-0006YH-1O
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6aY4-0006Xl-Ro
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:05:36 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171020090556.18631-8-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 20 Oct 2017 10:05:56 +0100")
References: <20171020090556.18631-1-dgilbert@redhat.com>
	<20171020090556.18631-8-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:05:30 +0200
Message-ID: <87376aazut.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 7/7] migration: pause-before-switchover
 for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, peterx@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add pause-before-switchover support for postcopy.
> After starting postcopy it will transition
>     active->pre-switchover->postcopy_active
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
