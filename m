Received: from eggs.gnu.org ([209.51.188.92]:48550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hB6ZW-0000Gz-8I
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hB6ZV-0006Kt-1p
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:42:34 -0400
MIME-Version: 1.0
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
	<20190401210011.16009-60-mdroth@linux.vnet.ibm.com>
	<CAMo8BfLMM7RSXMcvA-jPJFUzt23fCGU-q=3fXZBv_=S_6UszSQ@mail.gmail.com>
	<155416128371.3333.10200489776884563434@sif>
In-Reply-To: <155416128371.3333.10200489776884563434@sif>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 1 Apr 2019 16:42:10 -0700
Message-ID: <CAMo8BfKDrfwONQ-8HWssbRqDhbpidvhBnswz4ytOp8ov9zR98w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 59/97] target/xtensa: drop num_[core_]regs
 from dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Mon, Apr 1, 2019 at 4:28 PM Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > I'm curious why this change was picked for stable, it wasn't marked for it.
> Looks like an earlier patch was tagged for stable:
...
> Since patches are often referred to qemu-stable via actual email Cc: and
> often don't get tagged in the commit I don't rely too much on the
> "Cc: qemu-stable@nongnu.org" tags in the commit messages currently.

Oh, I see.

> I should probably take note next time a tag is explicitly removed from the
> final commit though, but the safest way to avoid this if a patch ends up
> getting Cc'd to qemu-stable at some point is to reply to the patch on why
> it should be kept out, since I'll usually see those.

Ok, will do it next time.

-- 
Thanks.
-- Max
