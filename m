Received: from eggs.gnu.org ([2001:4830:134:3::10]:32865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdLQ-0006xN-CW
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdLL-00020y-04
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:02:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmdLK-00020p-Pd
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:01:58 -0400
Received: by mail-wm0-x244.google.com with SMTP id e67so3193222wmd.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 03:01:58 -0700 (PDT)
Date: Tue, 29 Aug 2017 11:01:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829100155.GN25960@stefanha-x1.localdomain>
References: <20170825155732.15665-1-stefanha@redhat.com>
	<4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
	<CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
	<4f21291d-d696-9651-e317-78ec4f08cbda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f21291d-d696-9651-e317-78ec4f08cbda@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Aug 25, 2017 at 12:42:44PM -0500, Eric Blake wrote:
> On 08/25/2017 11:40 AM, Peter Maydell wrote:
> > Our choices about our dependencies are generally driven by "what
> > are the versions available on the oldest distros which we wish
> > to support building QEMU on", which typically is whatever the
> > long-term-support versions of Ubuntu, SUSE, Redhat, etc are.
> > 
> > Has somebody checked what that means for our Python version
> > requirements?
> 
> At least this one:
> 
> RHEL/CentOS 6: Python-2.6.6

Thanks for checking this.

Stefan
