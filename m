Received: from eggs.gnu.org ([2001:4830:134:3::10]:35217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ek2Ah-0003eM-Ta
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ek2Ad-0002hz-Gh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:28:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ek2Ad-0002gd-Bw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:28:27 -0500
Date: Fri, 9 Feb 2018 14:28:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180209062819.GC2783@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208103132.28452-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/28] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Feb 08, 2018 at 06:31:04PM +0800, Peter Xu wrote:
> Tree is pushed here for better reference and testing (online tree
> includes monitor OOB series):
> 
>   https://github.com/xzpeter/qemu/tree/postcopy-recovery-support

Hello, Patchew,

Based-on: <20180124053957.29145-1-peterx@redhat.com>

-- 
Peter Xu
