Received: from eggs.gnu.org ([2001:4830:134:3::10]:34544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etT7k-0002X0-TO
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etT7g-0001AX-0q
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etT7f-0001A2-Sd
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:23 -0500
Date: Wed, 7 Mar 2018 15:04:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307070410.GJ17720@xz-mi>
References: <20180228201837.26629.3346.stgit@gimli.home>
	<20180228204523.26629.68401.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228204523.26629.68401.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio/quirks: Add common quirk alloc
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, eric.auger@redhat.com

On Wed, Feb 28, 2018 at 01:45:23PM -0700, Alex Williamson wrote:
> This will later be used to include list initialization.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
