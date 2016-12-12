Received: from eggs.gnu.org ([2001:4830:134:3::10]:54346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGN4k-0006Br-Oh
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 04:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGN4h-0001st-MS
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 04:39:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGN4h-0001sd-GS
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 04:39:11 -0500
Date: Mon, 12 Dec 2016 17:39:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161212093907.GA7918@lemon>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On Mon, 12/12 09:43, Liviu Ionescu wrote:
> 
> > On 12 Dec 2016, at 09:39, Fam Zheng <famz@redhat.com> wrote:
> > 
> >> any idea how difficult would be to push any changes to SDL?
> > 
> > Not sure I understand this question, could you be more specific?
> 
> I guess making SDL run asynchronously will need some major changes to the SDL
> source code, not simple patches that can be added to the QEMU build.
> 
> do you know someone who can not only implement the patches, but also push them
> to the mainstream SDL repository, to have them available to everyone?

Sorry I have no idea how to answer that.. Anyone can contribute since it is an
open source project, but I myself know next to nothing about SDL project.

Fam
