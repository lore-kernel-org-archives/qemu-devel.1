Received: from eggs.gnu.org ([2001:4830:134:3::10]:50034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIYv5-00023Q-Ot
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIYv1-0006dY-47
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:14:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dIYv0-0006dN-UM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:14:31 -0400
Date: Wed, 7 Jun 2017 19:14:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170607111423.GC4314@lemon.lan>
References: <1496820931-27416-10-git-send-email-a.perevalov@samsung.com>
	<149682484945.96.2900136396151676257@7f80c91fe18c>
	<CGME20170607092434epcas3p4d94054fb9aa0c4eb984e7cf4451119cd@epcas3p4.samsung.com>
	<20170607092426.GB4314@lemon.lan>
	<dc236aea-2015-3384-7a18-a67406df0586@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc236aea-2015-3384-7a18-a67406df0586@samsung.com>
Subject: Re: [Qemu-devel] [[PATCH V7] 09/11] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, 06/07 12:29, Alexey Perevalov wrote:
> On 06/07/2017 12:24 PM, Fam Zheng wrote:
> > On Wed, 06/07 01:40, no-reply@patchew.org wrote:
> > > Hi,
> > > 
> > > This series failed build test on s390x host. Please find the details below.
> > So what happened is the double '[[' in the subject line confused Patchew, and
> > each patch in this series is treated as a standalone patch.
> it's not bad to check every patch in sequence separately,
> but including previous patches )

That won't happen because patchew cannot reason about the dependencies any more
because it doesn't recognized subject tags around this nested [] syntax.

Fam

> 
> > 
> > Fam
> > 
> > 
> > 
> 
> -- 
> Best regards,
> Alexey Perevalov
> 
