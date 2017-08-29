Received: from eggs.gnu.org ([2001:4830:134:3::10]:60540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdJB-0005L1-PU
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdJ7-0000sf-81
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:59:45 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmdJ7-0000sQ-1u
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:59:41 -0400
Received: by mail-wm0-x22b.google.com with SMTP id y71so17559300wmd.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:59:40 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:59:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829095937.GM25960@stefanha-x1.localdomain>
References: <20170825155732.15665-1-stefanha@redhat.com>
	<150367827575.135.18312492625326080794@205a2245145f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150367827575.135.18312492625326080794@205a2245145f>
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, chugh.ishani@research.iiit.ac.in, famz@redhat.com

On Fri, Aug 25, 2017 at 09:24:36AM -0700, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/3: scripts: add argparse module for Python 2.6 compatibility...
> ERROR: trailing whitespace
> #115: FILE: COPYING.PYTHON:93:
> +Reserved" are retained in Python alone or in any derivative version $
> 
> total: 1 errors, 0 warnings, 2676 lines checked

I'm not going to modify the Python Software Foundation License text for
the sake of checkpatch.pl.  Let's keep it verbatim.
