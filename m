Received: from eggs.gnu.org ([2001:4830:134:3::10]:34255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYBwh-00049q-Bj
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYBwg-0002EU-EN
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:24:35 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYBwg-0002EJ-9V
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:24:34 -0500
Received: by mail-ua0-x233.google.com with SMTP id 96so249377684uaq.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 05:24:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127193504.32290-1-pbonzini@redhat.com>
References: <20170127193504.32290-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 13:24:13 +0000
Message-ID: <CAFEAcA-RxB1Y8NUYGdhDL=gPJ8wkSerHjQapOwJZH2d2k1JqrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/41] Misc patches for 2017-01-27
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

On 27 January 2017 at 19:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 29ba0cdc1fd1300f910d150c03a0f74236083b=
f7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-27'=
 into staging (2017-01-27 15:20:08 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6da67de6803e93cbb7e93ac3497865832f8c00ea:
>
>   memory: don't sign-extend 32-bit writes (2017-01-27 18:08:00 +0100)
>
> ----------------------------------------------------------------
> * SCSI max_transfer support for scsi-generic (Eric)
> * x86 SMI broadcast (Laszlo)
> * Character device QOMification (Marc-Andr=C3=A9)
> * Record/replay improvements (Pavel)
> * iscsi fixes (Peter L.)
> * "info mtree -f" command (Peter Xu)
> * TSC clock rate reporting (Phil)
> * DEVICE_CATEGORY_CPU (Thomas)
> * Memory sign-extension fix (Ladi)
>

Applied, thanks.

-- PMM
