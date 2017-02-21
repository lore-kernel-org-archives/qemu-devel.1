Received: from eggs.gnu.org ([2001:4830:134:3::10]:45146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg7hY-0001zb-6c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg7hX-0006ek-Cr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:29:44 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg7hX-0006do-5g
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:29:43 -0500
Received: by mail-wm0-x233.google.com with SMTP id r141so71756851wmg.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:29:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 10:29:21 +0000
Message-ID: <CAFEAcA9E4+vxKJXUnGiTMjarreXw+76CDMhLuZsyH2jSN33zrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/11] usb patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 February 2017 at 07:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the usb patch queue, bringing the usual share of bugfixes.
> Also a generic xhci device variant (qemu-xhci).
>
> please pull,
>   Gerd
>
> The following changes since commit 56f9e46b841c7be478ca038d8d4085d776ab4b0d:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-20' into staging (2017-02-20 17:42:47 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-usb-20170221-1
>
> for you to fetch changes up to 31fb4444a485a348f8e2699d7c3dd15e1819ad2c:
>
>   usb-ccid: add check message size checks (2017-02-21 08:11:43 +0100)
>
> ----------------------------------------------------------------
> xhci: add qemu-xhci device, some followup cleanups.
> ccid: better sanity checking.
> ehci: fix memory leak
> ohci: bugfixes.

Applied, thanks.

-- PMM
