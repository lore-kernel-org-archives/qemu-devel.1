Received: from eggs.gnu.org ([2001:4830:134:3::10]:39870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eYXVg-0004ok-Gr
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eYXVf-0007dN-Cz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:30:40 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:47033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eYXVf-0007cr-7J
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:30:39 -0500
Received: by mail-io0-x22b.google.com with SMTP id z130so13552494ioe.13
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 05:30:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Mon, 8 Jan 2018 05:30:37 -0800
Message-ID: <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Jan 8, 2018 02:16, "Peter Maydell" <peter.maydell@linaro.org> wrote:

On 22 December 2017 at 02:15, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 43ab9a5376c95c61ae898a222c4d04
bdf60e239b:
>
>   hw/i386/vmport: fix missing definitions with non-log trace backends
(2017-12-21 22:52:28 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 0065e915192cdf83c2700bb377e5323c2649476e:
>
>   qemu-doc: Update the deprecation information of -tftp, -bootp, -redir
and -smb (2017-12-22 10:06:05 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Applied, thanks.

PS: just noticed, but "Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>"
is a bit of an odd Author string to end up in git commit logs, so you
and/or Ed might like to fix that up for any future patches.


Thanks for pointing that out. I wonder if it's happening because I let
git-send-email automatically fill in the From: line.

Anyway if it's not too late to fix, the correct address is Ed Swierk <
eswierk@skyportsystems.com> .


thanks
-- PMM
