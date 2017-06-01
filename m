Received: from eggs.gnu.org ([2001:4830:134:3::10]:33152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGMij-0007Nr-Nx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGMie-0001IT-Sx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:48:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGMie-0001IB-Nq
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:48:40 -0400
Date: Thu, 1 Jun 2017 17:48:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170601094834.GB13127@lemon.lan>
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
	<20170530113502.GC27787@lemon.lan>
	<CAJrWOzB8FdDo4e0TKuWRDf+VowWQaNntOGpnpQyZ0J5P_-tgdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrWOzB8FdDo4e0TKuWRDf+VowWQaNntOGpnpQyZ0J5P_-tgdA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 06/01 11:38, Roman Penyaev wrote:
> On Tue, May 30, 2017 at 1:35 PM, Fam Zheng <famz@redhat.com> wrote:
> [cut]
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> Do I need to resend the patch with 'reviewed-by' line?  Or it is
> already queued?

No need to resend just for adding reviewed-by, it can be picked up by
maintainers when applying. The question is who's going to take it :)

Fam
