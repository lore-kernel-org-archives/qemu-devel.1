Received: from eggs.gnu.org ([2001:4830:134:3::10]:44683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFdWz-0004K9-JH
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFdWw-00086F-A7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dFdWw-000860-4Z
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:33:34 -0400
Date: Tue, 30 May 2017 17:33:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170530093328.GC20514@lemon.lan>
References: <20170526075246.20265-1-famz@redhat.com>
	<20170530091939.GF11362@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530091939.GF11362@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PULL 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 05/30 10:19, Stefan Hajnoczi wrote:
> On Fri, May 26, 2017 at 03:52:24PM +0800, Fam Zheng wrote:
> > The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:
> > 
> >   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
> > 
> > for you to fetch changes up to 77269bba94ef97de99ae61fdc98629a8704ae2ed:
> > 
> >   block: make accounting thread-safe (2017-05-26 09:25:30 +0800)
> > 
> > ----------------------------------------------------------------
> > 
> > For Paolo's block layer thread safety part I and my docker testing
> > enhancements.
> 
> Please fix the checkpatch issues.

Paolo, could you provide the comments that can be added to the memory barriers?

Fam
