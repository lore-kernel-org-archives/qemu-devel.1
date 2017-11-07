Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBwwP-00059m-4i
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBwwM-0007Tr-4U
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:00:53 -0500
Date: Tue, 7 Nov 2017 14:00:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107060033.GD16355@lemon>
References: <cover.1510021573.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Don't write headers if BDS is
 INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

On Mon, 11/06 21:31, Jeff Cody wrote:
> Changes from v2->v3:
> 
> Patch 2: Uh... fix that misspelling.  Thanks Stefan :)
> Patch 3: New patch to block migration in parallels

Reviewed-by: Fam Zheng <famz@redhat.com>
