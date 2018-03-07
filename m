Received: from eggs.gnu.org ([2001:4830:134:3::10]:34615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etT83-0002hp-Vk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etT7z-0001Jv-39
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etT7y-0001JW-T9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:43 -0500
Date: Wed, 7 Mar 2018 15:04:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307070433.GK17720@xz-mi>
References: <20180228201837.26629.3346.stgit@gimli.home>
	<20180228204537.26629.49502.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228204537.26629.49502.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH 2/5] vfio/quirks: Add quirk reset callback
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

On Wed, Feb 28, 2018 at 01:45:37PM -0700, Alex Williamson wrote:
> Quirks can be self modifying, provide a hook to allow them to cleanup
> on device reset if desired.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
