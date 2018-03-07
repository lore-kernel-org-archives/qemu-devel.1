Received: from eggs.gnu.org ([2001:4830:134:3::10]:36488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etTEY-0006X7-PU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etTEU-0005Ms-Qx
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:11:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etTEU-0005Md-Mx
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:11:26 -0500
Date: Wed, 7 Mar 2018 15:11:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307071114.GM17720@xz-mi>
References: <20180228195504.25283.45666.stgit@gimli.home>
	<20180228201446.25283.82272.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228201446.25283.82272.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio/pci: Pull BAR mapping setup from
 read-write path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru

On Wed, Feb 28, 2018 at 01:14:46PM -0700, Alex Williamson wrote:
> This creates a common helper that we'll use for ioeventfd setup.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
