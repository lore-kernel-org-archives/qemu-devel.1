Received: from eggs.gnu.org ([2001:4830:134:3::10]:50922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHXri-0003a3-OD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHXrh-0004Ke-F4
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:31:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHXrZ-0004G6-Kr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:31:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id q1so2455822otk.0
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030112337.17973-1-laurent@vivier.eu>
References: <20181030112337.17973-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 17:31:08 +0000
Message-ID: <CAFEAcA9wOKFxRQDqaxtz5krfskGnxrDjTApE8BZxDH--0bWLew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/20] Qemu trivial for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>, Michael Walle <michael@walle.cc>, Markus Armbruster <armbru@redhat.com>

On 30 October 2018 at 11:23, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99c=
f2:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-s=
f0' into staging (2018-10-25 17:41:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/qemu-trivial-for-3.1-pull-request
>
> for you to fetch changes up to 7b2b797cf0addac789ba858fdbd95c55128d72d5:
>
>   milkymist-minimac2: Use qemu_log_mask(GUEST_ERROR) instead of error_rep=
ort (2018-10-30 09:13:31 +0100)
>
> ----------------------------------------------------------------
> QEMU trivial patches collected between June and October 2018
> (Thank you to Thomas Huth)
>
> v2: fix 32bit build with updated patch (v3) from Philippe Mathieu-Daud=C3=
=A9
>     built in a 32bit debian sid chroot
>

Applied, thanks.

-- PMM
