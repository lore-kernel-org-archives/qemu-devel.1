Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frfrD-0001yN-JO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frfrB-00061t-Jf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:48:15 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frfrA-00060a-VR
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:48:13 -0400
Received: by mail-oi0-x244.google.com with SMTP id j205-v6so24485948oib.4
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 01:48:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153452552631.13804.12031418293966530953.stgit@gimli.home>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 09:47:50 +0100
Message-ID: <CAFEAcA9120cOBm6G7HkavnzKwiB4GKXc8xVtWmsJrWm3vkUpog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] VFIO update 2018-08-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 August 2018 at 18:08, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180817.0
>
> for you to fetch changes up to 238e91728503d400e1c4e644e3a9b80f9e621682:
>
>   vfio/ccw/pci: Allow devices to opt-in for ballooning (2018-08-17 09:27:16 -0600)
>
> ----------------------------------------------------------------
> VFIO update 2018-08-17
>
>  - Enhance balloon inhibitor for multiple users and use around vfio
>    device assignment (Alex Williamson)
>

Applied, thanks.

-- PMM
