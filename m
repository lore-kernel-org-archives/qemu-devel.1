Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvloy-0003ur-3b
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 10:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvlox-0008Kb-BX
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 10:54:20 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:51398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvlox-0008Jk-4O
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 10:54:19 -0400
Received: by mail-wr0-x22e.google.com with SMTP id z39so2629826wrb.8
	for <qemu-devel@nongnu.org>; Sat, 23 Sep 2017 07:54:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922190853.1911-1-pbonzini@redhat.com>
References: <20170922190853.1911-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Sep 2017 15:53:56 +0100
Message-ID: <CAFEAcA-dxO91e9E-P8EpO81ev+Fs=N-zMOYpx_faZ2SJ1DATmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/32] Misc patches for 2017-09-22
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

On 22 September 2017 at 20:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98dae6:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-09-20 20:33:48 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to bb86d05f4afab3ebfee2e897e295d61dbd8cc28e:
>
>   chardev: remove context in chr_update_read_handler (2017-09-22 21:07:27 +0200)
>
> ----------------------------------------------------------------
> * Speed up AddressSpaceDispatch creation (Alexey)
> * Fix kvm.c assert (David)
> * Memory fixes and further speedup (me)
> * Persistent reservation manager infrastructure (me)
> * virtio-serial: add enable_backend callback (Pavel)
> * chardev GMainContext fixes (Peter)
>

Applied, thanks.

-- PMM
