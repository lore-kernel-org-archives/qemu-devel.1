Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTfku-0007EG-Io
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTfkq-0004Ae-GS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:13:44 -0500
Date: Wed, 18 Jan 2017 10:13:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118021334.GB31883@lemon.Home>
References: <1484702052-7900-1-git-send-email-skiver.cloud.yzy@gmail.com>
	<148470234043.214.7219322137444222645@790289a7ca88>
	<CAHkcwafqx4-vMsCVJOZS04Kb1cRVbu2ea802hjdOhJp2JoPA+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkcwafqx4-vMsCVJOZS04Kb1cRVbu2ea802hjdOhJp2JoPA+A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] gdbstub.c: fix GDB connection segfault
 caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Ziyue <skiver.cloud.yzy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Ziyue Yang <yzylivezh@hotmail.com>

On Wed, 01/18 09:34, Yang Ziyue wrote:
> Oops seems I forgot to check the patch before submitting. Sorry for that.
> The new patch is tagged as v3 now, but I'm not sure whether it should
> be tagged as v2 since the origin v2 failed. Is there any specification
> about this? Thanks!

Hi Ziyue, thanks for submitting the patch. When you repost, use v3 please, a
(even failed or mistaken) version shouldn't be reused, so that people looking at
the subjects will know which one is newer.

Fam
