Received: from eggs.gnu.org ([2001:4830:134:3::10]:34990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYso-0003qK-4X
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYsj-0004fw-31
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:28:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJYsi-0004fk-UN
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:28:49 -0400
Date: Fri, 18 May 2018 14:28:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518062838.GJ2569@xz-mi>
References: <20180517085927.24925-1-peterx@redhat.com>
	<CAHyh4xhP+ERYmSee+ybFtFEKyiHTUcEnUviCDRtKAXebancKLw@mail.gmail.com>
	<20180518062659.GI2569@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518062659.GI2569@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] intel-iommu: nested vIOMMU,
 cleanups, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, May 18, 2018 at 02:26:59PM +0800, Peter Xu wrote:

[...]

> I'll temporarily consider putting it at the last patch of series if no
> one jumps out and tells me another more correct way.  Also I'll
> possibly make bold to append your suggested-by too to further claim
                                    ^^^^^^^^^^^^
Sorry, I mean "Reported-by".

> your contribution to this problem.

Regards,

-- 
Peter Xu
