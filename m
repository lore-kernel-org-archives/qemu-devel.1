Received: from eggs.gnu.org ([2001:4830:134:3::10]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cP3g3-0006Lq-IW
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cP3g0-0003n0-DG
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:45:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:35968)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cP3g0-0003me-1c
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:45:36 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	<8737h9xidn.fsf@mail.parknet.co.jp>
	<87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
	<1483519820.5670.45.camel@redhat.com>
	<46bcf40d-7c47-733b-44e3-b5a38527524e@reactos.org>
	<87y3yqil7s.fsf@mail.parknet.co.jp>
	<1483603931.3966.12.camel@redhat.com>
Date: Thu, 05 Jan 2017 17:45:31 +0900
In-Reply-To: <1483603931.3966.12.camel@redhat.com> (Gerd Hoffmann's message of
	"Thu, 05 Jan 2017 09:12:11 +0100")
Message-ID: <87tw9dj3o4.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] ps2: Fix lost scancodes by recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

>> Yes, please use v3. Here is copy&paste, FWIW.
>
> Please don't send new versions of patches as reply.  That confuses
> various patch management tools, they are considered being part of the
> discussion then.  This is how the reviewed-by tag ended up being
> attributed to the wrong patch version.
>
> Have a look at http://patchew.org/QEMU/ for example, the patches sent as
> reply don't show up there, so they are not tested automatically.

Hm, it is surprise to me. Ok, I will re-start on new thread for
qemu-devel next time. BTW, url of your example didn't show even initial
patch (if I didn't overlook). Looks like it is broken.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
