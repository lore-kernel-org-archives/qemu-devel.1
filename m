Received: from eggs.gnu.org ([2001:4830:134:3::10]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52gp-0004OO-0S
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52gl-0003Sq-3b
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e52gk-0003SM-TJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:44:11 -0400
Date: Thu, 19 Oct 2017 12:44:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171019044403.GU4166@pxdev.xzpeter.org>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171018174013.22709-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171018174013.22709-6-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] migrate: HMP migate_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

On Wed, Oct 18, 2017 at 06:40:11PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> HMP equivalent to the just added migrate-continue
> Unpause a migrate paused at a given state.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
