Received: from eggs.gnu.org ([2001:4830:134:3::10]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYXiP-0000LN-Ew
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYXiO-00086w-Qg
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:43:49 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYXiO-00086X-L1
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:43:48 -0500
Received: by mail-ot0-x243.google.com with SMTP id o1so9228081oti.12
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 05:43:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171223075326.9265-1-pbonzini@redhat.com>
References: <20171223075326.9265-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 13:43:27 +0000
Message-ID: <CAFEAcA9M8-0nytynTRnY3YxTDhC9W5v5F7rJLVz6f6-O48A+Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 December 2017 at 07:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 43ab9a5376c95c61ae898a222c4d04bdf60e239b:
>
>   hw/i386/vmport: fix missing definitions with non-log trace backends (2017-12-21 22:52:28 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>
> for you to fetch changes up to 895f9fdf3ac5481ca5ad5763bf667cbf82aa52c4:
>
>   i386: hvf: cleanup x86_gen.h (2017-12-22 15:02:07 +0100)
>
> ----------------------------------------------------------------
> Initial support for the HVF accelerator

Applied, thanks.

(We should make sure we mention this in the changelog, and
perhaps have a blog post about it at release time, if anybody
would like to volunteer to write one.)

-- PMM
