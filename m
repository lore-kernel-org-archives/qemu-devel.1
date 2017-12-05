Received: from eggs.gnu.org ([2001:4830:134:3::10]:52051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM78o-0001Xe-9Q
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM78j-0004PT-Un
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:55:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM78j-0004P4-Ob
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 01:55:37 -0500
Date: Tue, 5 Dec 2017 14:55:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171205065531.GB2925@xz-mi>
References: <20171205065307.21853-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171205065307.21853-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/28] Migration: postcopy failure
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Dec 05, 2017 at 02:52:39PM +0800, Peter Xu wrote:
> Tree is pushed here for better reference and testing (online tree
> includes monitor OOB series):
> 
>   https://github.com/xzpeter/qemu/tree/postcopy-recover-all

Sorry, now this series is depending on the OOB series.  Hello,
Patchew, hope you see this soon enough:

Based-on: <20171205055200.16305-1-peterx@redhat.com>

-- 
Peter Xu
