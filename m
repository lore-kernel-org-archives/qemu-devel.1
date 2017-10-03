Received: from eggs.gnu.org ([2001:4830:134:3::10]:44099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzQHC-0008Ow-RF
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzQHC-0005Ra-53
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:42:34 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:49199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzQHB-0005Pv-UG
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:42:34 -0400
Received: by mail-wr0-x230.google.com with SMTP id p10so5002746wrc.6
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 09:42:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
References: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 17:42:12 +0100
Message-ID: <CAFEAcA9Z0V_ZaqJjyBJ1QRX35qMHozPcb0S1XYt7G=27Q3k+jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Misc patches for 2017-10-03
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

On 3 October 2017 at 11:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 346b1215b1e9f7cc6d8fe9fb6f3c2778b890afb6:
>
>   kvmclock: use the updated system_timer_msr (2017-10-02 14:39:51 +0200)
>
> ----------------------------------------------------------------
> * iothread bugfix (Eduardo)
> * Linux headers sync (Dave)
> * .gitignore fix (Eric)
> * KVM capability check fixes (Greg)
> * kvmclock fix (Jim)
>

Applied, thanks.

-- PMM
