Received: from eggs.gnu.org ([2001:4830:134:3::10]:58147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck99I-0002pu-Nt
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck99H-0000SW-PX
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:51:00 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ck99H-0000SO-J3
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:50:59 -0500
Received: by mail-wr0-x22a.google.com with SMTP id u48so89403572wrc.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 04:50:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
References: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 12:50:37 +0000
Message-ID: <CAFEAcA9ixwZnvbjeQXg+BzMyiEmV9yFthe1CHpET7yubw=vT+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v5 00/21] Misc patches for QEMU soft freeze
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

On 3 March 2017 at 16:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 508e038a5d725f2aa729f58a1f5209b9be4227de:
>
>   dtc: Revert unintentional submodule downgrade from commit 077dd74239a99 (2017-03-03 12:48:42 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f6eb0b319e4bad3d01d74d71e3a6cf40f0ede720:
>
>   iscsi: fix missing unlock (2017-03-03 16:41:20 +0100)
>
> v4->v5: 4.11 kernel header already merged
>         added two more patches at the end
>

Applied, thanks.

-- PMM
